using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ProductService : BaseCrudService<ProductResponse, Product, BaseSearchObject, AddProductRequest, UpdateProductRequest>, IProductService
    {
        public ProductService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
