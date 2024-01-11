using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController : BaseCrudController<AppointmentResponse, AppointmentSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>
    {
        public AppointmentController(ILogger<BaseController<AppointmentResponse, AppointmentSearchObject>> logger, IAppointmentService service) : base(logger, service)
        {
        }
    }
}