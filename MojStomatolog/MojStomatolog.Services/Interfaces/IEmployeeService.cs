using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IEmployeeService : IBaseCrudService<EmployeeResponse, EmployeeSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>
    {
    }
}
