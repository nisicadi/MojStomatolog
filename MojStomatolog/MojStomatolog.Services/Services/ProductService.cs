using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ProductService : BaseCrudService<ProductResponse, Product, ProductSearchObject, AddProductRequest, UpdateProductRequest>, IProductService
    {
        public ProductService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Product> AddFilter(IQueryable<Product> query, ProductSearchObject? search = null)
        {
            if (!string.IsNullOrWhiteSpace(search?.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x => x.Name.Contains(searchTermLower));
            }

            return query;
        }
    }
}
