using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class EmployeeService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<EmployeeResponse, Employee, EmployeeSearchObject, AddEmployeeRequest, UpdateEmployeeRequest>(
            context, mapper), IEmployeeService
    {
        public override IQueryable<Employee> AddFilter(IQueryable<Employee> query, EmployeeSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTerm = $"%{search.SearchTerm}%";
                query = query.Where(x =>
                    EF.Functions.Like(x.FirstName + " " + x.LastName, searchTerm) ||
                    EF.Functions.Like(x.LastName + " " + x.FirstName, searchTerm));
            }

            if (search.DateFrom is not null)
            {
                query = query.Where(x => x.StartDate >= search.DateFrom);
            }

            if (search.DateTo is not null)
            {
                query = query.Where(x => x.StartDate <= search.DateTo);
            }

            return query.OrderByDescending(x => x.StartDate);
        }
    }
}
