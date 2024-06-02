using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using Microsoft.ML;
using Microsoft.ML.Trainers;
using MojStomatolog.Database;
using MojStomatolog.Services.Common.Enums;

namespace MojStomatolog.Services.Common.RecommenderModel
{
    public class ModelTrainingService(IServiceScopeFactory scopeFactory)
    {
        private readonly IServiceScopeFactory _scopeFactory = scopeFactory ?? throw new ArgumentNullException(nameof(scopeFactory));
        private readonly MLContext _mlContext = new();
        private ITransformer? _model;
        private readonly string _modelPath = Environment.GetEnvironmentVariable("MODEL_PATH") ?? "trained_model.zip";

        private void TrainModel()
        {
            using var scope = _scopeFactory.CreateScope();
            var dbContext = scope.ServiceProvider.GetRequiredService<MojStomatologContext>() ?? throw new InvalidOperationException("Database context cannot be null.");

            List<Models.Core.Order> tmpData = [.. dbContext.Orders
                .Where(x => x.Status != (int)OrderStatus.Cancelled)
                .Include(x => x.OrderItems)];
            List<ProductEntry> data = [];

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
                        IEnumerable<Models.Core.OrderItem> relatedItems = item.OrderItems.Where(y => y.ProductId != x);

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

            if (data.IsNullOrEmpty())
            {
                return;
            }

            var trainData = _mlContext.Data.LoadFromEnumerable(data);

            MatrixFactorizationTrainer.Options options = new()
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

            // Save the trained model to disk
            _mlContext.Model.Save(_model, trainData.Schema, _modelPath);
        }

        public ITransformer GetTrainedModel()
        {
            if (_model == null)
            {
                // Check if there's a model saved to disk
                if (File.Exists(_modelPath))
                {
                    _model = _mlContext.Model.Load(_modelPath, out _);
                }
                else
                {
                    TrainModel(); // Train the model if no saved model is found
                }
            }

            return _model ?? throw new InvalidOperationException("Model training failed, model is null.");
        }

        public void RetrainModel()
        {
            TrainModel();
        }
    }
}
