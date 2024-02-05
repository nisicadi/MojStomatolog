using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IProductService : IBaseCrudService<ProductResponse, ProductSearchObject, AddProductRequest, UpdateProductRequest>
    {
        List<ProductResponse> GetRecommendedProducts(int productId);
    }
}
