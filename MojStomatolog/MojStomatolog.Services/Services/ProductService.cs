﻿using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.ML;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.RecommenderModel;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ProductService(MojStomatologContext context, IMapper mapper, ModelTrainingService modelTrainingService)
        : BaseCrudService<ProductResponse, Product, ProductSearchObject, AddProductRequest, UpdateProductRequest>(
            context, mapper), IProductService
    {
        private readonly MLContext _mlContext = new();

        public List<ProductResponse> GetRecommendedProducts(int productId)
        {
            var products = Context.Products.Where(x => x.ProductId != productId);
            List<Tuple<Product, float>> predictionResult = [];
            var model = modelTrainingService.GetTrainedModel();

            foreach (var product in products)
            {
                var predictionEngine = _mlContext.Model.CreatePredictionEngine<ProductEntry, CoPurchasePrediction>(model);
                var prediction = predictionEngine.Predict(
                    new ProductEntry
                    {
                        ProductId = (uint)productId,
                        CoPurchaseProductId = (uint)product.ProductId
                    });

                predictionResult.Add(new Tuple<Product, float>(product, prediction.Score));
            }

            List<Product> finalResult = predictionResult.OrderByDescending(x => x.Item2)
                .Select(x => x.Item1)
                .Take(3)
                .ToList();

            return Mapper.Map<List<ProductResponse>>(finalResult);
        }

        public override IQueryable<Product> AddFilter(IQueryable<Product> query, ProductSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                query = query.Where(x => EF.Functions.Like(x.Name, $"%{search.SearchTerm}%"));
            }

            if (search.PriceFrom is not null)
            {
                query = query.Where(x => x.Price >= search.PriceFrom);
            }

            if (search.PriceTo is not null)
            {
                query = query.Where(x => x.Price <= search.PriceTo);
            }

            if (search.IsActive is not null)
            {
                query = query.Where(x => x.Active == search.IsActive);
            }

            return query;
        }

        public override IQueryable<Product> AddInclude(IQueryable<Product> query, ProductSearchObject? search = null)
        {
            return query.Include(x => x.ProductCategory);
        }
    }
}
