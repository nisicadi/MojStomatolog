using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class OrderController(
        ILogger<BaseController<OrderResponse, OrderSearchObject>> logger,
        IOrderService service)
        : BaseController<OrderResponse, OrderSearchObject>(logger, service)
    {
        [HttpPost]
        public async Task<IActionResult> CreateOrder([FromBody] AddOrderRequest request)
        {
            try
            {
                var result = await service.CreateOrder(request);

                return result ? Ok("Order created successfully.") : BadRequest("Failed to create an order.");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpPatch]
        public async Task<IActionResult> ChangeOrderStatus([FromBody] PatchOrderRequest request)
        {
            try
            {
                var result = await service.ChangeStatus(request);

                return result ? Ok("Order status changed successfully.") : BadRequest("Failed to change the order status.");
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}