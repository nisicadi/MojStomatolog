using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class EmployeeController(
        ILogger<BaseController<EmployeeResponse, EmployeeSearchObject>> logger,
        IEmployeeService service)
        : BaseCrudController<EmployeeResponse, EmployeeSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>(logger,
            service);
}