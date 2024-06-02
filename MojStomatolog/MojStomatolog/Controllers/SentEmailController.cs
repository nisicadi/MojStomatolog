using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.SentEmail;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class SentEmailController(
        ILogger<BaseController<SentEmailResponse, BaseSearchObject>> logger,
        ISentEmailService service)
        : BaseCrudController<SentEmailResponse, BaseSearchObject, AddSentEmailRequest, UpdateSentEmailRequest>(logger,
            service);
}