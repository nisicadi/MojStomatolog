using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ArticleController : BaseCrudController<ArticleResponse, BaseSearchObject, AddArticleRequest, UpdateArticleRequest>
    {
        public ArticleController(ILogger<BaseController<ArticleResponse, BaseSearchObject>> logger, IArticleService service) : base(logger, service)
        {
        }
    }
}