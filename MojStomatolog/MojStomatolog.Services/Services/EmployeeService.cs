using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class EmployeeService : BaseCrudService<EmployeeResponse, Employee, EmployeeSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>, IEmployeeService
    {
        public EmployeeService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Employee> AddFilter(IQueryable<Employee> query, EmployeeSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x =>
                    (x.FirstName + " " + x.LastName).ToLower().Contains(searchTermLower) ||
                    (x.LastName + " " + x.FirstName).ToLower().Contains(searchTermLower));
            }

            if (search.DateFrom is not null)
            {
                query = query.Where(x => x.StartDate >= search.DateFrom);
            }

            if (search.DateTo is not null)
            {
                query = query.Where(x => x.StartDate <= search.DateTo);
            }

            return query;
        }
    }
}
