using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IEmployeeService : IBaseCrudService<EmployeeResponse, BaseSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>
    {
    }
}
