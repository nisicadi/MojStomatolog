using MojStomatolog.Models.Requests.SentEmail;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface ISentEmailService : IBaseCrudService<SentEmailResponse, BaseSearchObject, AddSentEmailRequest, UpdateSentEmailRequest>
    {
    }
}
