using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IProductService : IBaseCrudService<ProductResponse, BaseSearchObject, AddProductRequest, UpdateProductRequest>
    {
    }
}
