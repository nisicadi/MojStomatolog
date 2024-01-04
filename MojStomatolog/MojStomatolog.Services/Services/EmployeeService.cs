using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class EmployeeService : BaseCrudService<EmployeeResponse, Employee, BaseSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>, IEmployeeService
    {
        public EmployeeService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
