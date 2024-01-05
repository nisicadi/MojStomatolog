using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ProductController : BaseCrudController<ProductResponse, BaseSearchObject, AddProductRequest, UpdateProductRequest>
    {
        public ProductController(ILogger<BaseController<ProductResponse, BaseSearchObject>> logger, IProductService service) : base(logger, service)
        {
        }
    }
}