using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class EmployeeController : BaseCrudController<EmployeeResponse, EmployeeSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>
    {
        public EmployeeController(ILogger<BaseController<EmployeeResponse, EmployeeSearchObject>> logger, IEmployeeService service) : base(logger, service)
        {
        }
    }
}