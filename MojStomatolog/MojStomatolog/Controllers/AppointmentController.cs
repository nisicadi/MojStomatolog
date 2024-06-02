using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class AppointmentController(
        ILogger<BaseController<AppointmentResponse, AppointmentSearchObject>> logger,
        IAppointmentService service)
        : BaseCrudController<AppointmentResponse, AppointmentSearchObject, AddAppointmentRequest,
            UpdateAppointmentRequest>(logger, service);
}