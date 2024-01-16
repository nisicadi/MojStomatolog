using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class ArticleController : BaseCrudController<ArticleResponse, ArticleSearchObject, AddArticleRequest, UpdateArticleRequest>
    {
        public ArticleController(ILogger<BaseController<ArticleResponse, ArticleSearchObject>> logger, IArticleService service) : base(logger, service)
        {
        }
    }
}