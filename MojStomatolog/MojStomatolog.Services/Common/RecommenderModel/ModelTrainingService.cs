using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using MojStomatolog.Database;
using MojStomatolog.Services.Common.Enums;

namespace MojStomatolog.Services.Common.RecommenderModel
{
    public class ModelTrainingService
    {
        private readonly IServiceScopeFactory _scopeFactory;
        private readonly MLContext _mlContext;
        private ITransformer? _model;

        public ModelTrainingService(IServiceScopeFactory scopeFactory)
        {
            _scopeFactory = scopeFactory ?? throw new ArgumentNullException(nameof(scopeFactory));
            _mlContext = new MLContext();
        }

        public void TrainModel()
        {
            using var scope = _scopeFactory.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<MojStomatologContext>() ?? throw new InvalidOperationException("Database context cannot be null.");

            var tmpData = dbContext.Orders
                .Where(x => x.Status != (int)OrderStatus.Cancelled)
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

            if (!data.Any())
                return;

            var trainData = _mlContext.Data.LoadFromEnumerable(data);

            var options = new MatrixFactorizationTrainer.Options
            {
                MatrixColumnIndexColumnName = nameof(ProductEntry.ProductId),
                MatrixRowIndexColumnName = nameof(ProductEntry.CoPurchaseProductId),
                LabelColumnName = "Label",
                LossFunction = MatrixFactorizationTrainer.LossFunctionType.SquareLossOneClass,
                Alpha = 0.01,
                Lambda = 0.025,
                NumberOfIterations = 100,
                C = 0.00001
            };

            var est = _mlContext.Recommendation().Trainers.MatrixFactorization(options);
            _model = est.Fit(trainData);
        }

        public ITransformer GetTrainedModel()
        {
            if (_model == null)
            {
                TrainModel();
            }

            return _model ?? throw new InvalidOperationException("Model training failed, model is null.");
        }

        public void RetrainModel()
        {
            TrainModel();
        }
    }
}
