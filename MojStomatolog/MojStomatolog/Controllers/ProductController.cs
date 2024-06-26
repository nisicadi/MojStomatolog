using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.RecommenderModel;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ProductController(
        ILogger<BaseController<ProductResponse, ProductSearchObject>> logger,
        IProductService service,
        ModelTrainingService modelTrainingService)
        : BaseCrudController<ProductResponse, ProductSearchObject, AddProductRequest, UpdateProductRequest>(logger,
            service)
    {
        [HttpGet("{productId:int}/recommend")]
        public ActionResult<List<ProductResponse>> Recommend(int productId)
        {
            try
            {
                return Ok(service.GetRecommendedProducts(productId));
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpPost("retrain")]
        public IActionResult RetrainModel()
        {
            try
            {
                modelTrainingService.RetrainModel();
                return Ok("Model retraining initiated.");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}