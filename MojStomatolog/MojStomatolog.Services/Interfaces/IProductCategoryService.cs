using MojStomatolog.Models.Requests.ProductCategory;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IProductCategoryService : IBaseCrudService<ProductCategoryResponse, ProductCategorySearchObject, AddProductCategoryRequest, UpdateProductCategoryRequest>
    {
    }
}
