using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Service;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ServiceController(
        ILogger<BaseController<ServiceResponse, ServiceSearchObject>> logger,
        IServiceService service)
        : BaseCrudController<ServiceResponse, ServiceSearchObject, AddServiceRequest, UpdateServiceRequest>(logger,
            service);
}