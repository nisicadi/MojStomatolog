using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.ProductCategory;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ProductCategoryService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<ProductCategoryResponse, ProductCategory, ProductCategorySearchObject,
            AddProductCategoryRequest, UpdateProductCategoryRequest>(context, mapper), IProductCategoryService
    {
        public override IQueryable<ProductCategory> AddFilter(IQueryable<ProductCategory> query, ProductCategorySearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                query = query.Where(x => EF.Functions.Like(x.Name, $"%{search.SearchTerm}%"));
            }

            return query;
        }
    }
}