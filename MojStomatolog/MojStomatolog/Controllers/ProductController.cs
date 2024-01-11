using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : BaseCrudController<ProductResponse, ProductSearchObject, AddProductRequest, UpdateProductRequest>
    {
        public ProductController(ILogger<BaseController<ProductResponse, ProductSearchObject>> logger, IProductService service) : base(logger, service)
        {
        }
    }
}