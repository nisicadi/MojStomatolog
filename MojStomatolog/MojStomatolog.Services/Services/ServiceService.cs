using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Service;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ServiceService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<ServiceResponse, Service, ServiceSearchObject, AddServiceRequest, UpdateServiceRequest>(
            context, mapper), IServiceService
    {
        public override IQueryable<Service> AddFilter(IQueryable<Service> query, ServiceSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                query = query.Where(x => EF.Functions.Like(x.Name, $"%{search.SearchTerm}%"));
            }

            return query;
        }
    }
}