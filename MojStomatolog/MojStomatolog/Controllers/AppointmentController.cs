using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController : BaseCrudController<AppointmentResponse, BaseSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>
    {
        public AppointmentController(ILogger<BaseController<AppointmentResponse, BaseSearchObject>> logger, IAppointmentService service) : base(logger, service)
        {
        }
    }
}