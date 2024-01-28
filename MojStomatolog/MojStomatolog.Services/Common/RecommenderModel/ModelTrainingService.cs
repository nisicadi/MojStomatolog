using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using MojStomatolog.Database;

namespace MojStomatolog.Services.Common.RecommenderModel
{
    public class ModelTrainingService
    {
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly MLContext _mlContext;
        private ITransformer _model;

        public ModelTrainingService(IServiceScopeFactory scopeFactory)
        {
            _scopeFactory = scopeFactory;
            _mlContext = new MLContext();
        }

        public void TrainModel()
        {
            using var scope = _scopeFactory.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<MojStomatologContext>();

            var tmpData = dbContext.Orders
                .Include(x => x.OrderItems)
                .ToList();
            var data = new List<ProductEntry>();

            foreach (var item in tmpData)
            {
                if (item.OrderItems.Count > 1)
                {
                    var distinctItemId = item.OrderItems
                        .Select(x => x.ProductId)
                        .Distinct()
                        .ToList();

                    distinctItemId.ForEach(x =>
                    {
                        var relatedItems = item.OrderItems.Where(y => y.ProductId != x);

                        foreach (var relatedItem in relatedItems)
                        {
                            data.Add(new ProductEntry
                            {
                                ProductId = (uint)x,
                                CoPurchaseProductId = (uint)relatedItem.ProductId
                            });
                        }
                    });
                }
            }

            var trainData = _mlContext.Data.LoadFromEnumerable(data);

            MatrixFactorizationTrainer.Options options = new MatrixFactorizationTrainer.Options();
            options.MatrixColumnIndexColumnName = nameof(ProductEntry.ProductId);
            options.MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductId);
            options.LabelColumnName = "Label";
            options.LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass;
            options.Alpha = 0.01;
            options.Lambda = 0.025;
            options.NumberOfIterations = 100;
            options.C = 0.00001;

            var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);
            _model = est.Fit(trainData);
        }

        public ITransformer GetTrainedModel()
        {
            if (_model == null)
            {
                TrainModel();
            }
            return _model;
        }

        public void RetrainModel()
        {
            TrainModel();
        }
    }
}
