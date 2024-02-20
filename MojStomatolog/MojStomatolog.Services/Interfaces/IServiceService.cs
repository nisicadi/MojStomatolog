using MojStomatolog.Models.Requests.Service;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IServiceService : IBaseCrudService<ServiceResponse, ServiceSearchObject, AddServiceRequest, UpdateServiceRequest>
    {
    }
}
