using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Service;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ServiceService : BaseCrudService<ServiceResponse, Service, ServiceSearchObject, AddServiceRequest, UpdateServiceRequest>, IServiceService
    {
        public ServiceService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Service> AddFilter(IQueryable<Service> query, ServiceSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x => x.Name.ToLower().Contains(searchTermLower));
            }

            return query;
        }
    }
}