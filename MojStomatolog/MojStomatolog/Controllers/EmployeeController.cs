using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class EmployeeController : BaseCrudController<EmployeeResponse, BaseSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>
    {
        public EmployeeController(ILogger<BaseController<EmployeeResponse, BaseSearchObject>> logger, IEmployeeService service) : base(logger, service)
        {
        }
    }
}