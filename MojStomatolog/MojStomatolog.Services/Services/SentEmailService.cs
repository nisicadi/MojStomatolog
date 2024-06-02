using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.SentEmail;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class SentEmailService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<SentEmailResponse, SentEmail, BaseSearchObject, AddSentEmailRequest, UpdateSentEmailRequest>(
            context,
            mapper), ISentEmailService
    {
        public override IQueryable<SentEmail> AddInclude(IQueryable<SentEmail> query, BaseSearchObject? search = null)
        {
            return query.Include(x => x.User);
        }
    }
}