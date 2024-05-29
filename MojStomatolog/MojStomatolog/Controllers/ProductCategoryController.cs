using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.ProductCategory;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ProductCategoryController(
        ILogger<BaseController<ProductCategoryResponse, ProductCategorySearchObject>> logger,
        IProductCategoryService service)
        : BaseCrudController<ProductCategoryResponse, ProductCategorySearchObject, AddProductCategoryRequest,
            UpdateProductCategoryRequest>(logger, service);
}