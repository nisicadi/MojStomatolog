using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Payment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class PaymentController : BaseCrudController<PaymentResponse, BaseSearchObject, AddPaymentRequest, UpdatePaymentRequest>
    {
        public PaymentController(ILogger<BaseController<PaymentResponse, BaseSearchObject>> logger, IPaymentService service) : base(logger, service)
        {
        }
    }
}