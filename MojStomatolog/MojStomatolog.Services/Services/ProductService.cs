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
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x => x.Name.Contains(searchTermLower));
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
    }
}
