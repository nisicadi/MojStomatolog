using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class ArticleController(
        ILogger<BaseController<ArticleResponse, ArticleSearchObject>> logger,
        IArticleService service)
        : BaseCrudController<ArticleResponse, ArticleSearchObject, AddArticleRequest, UpdateArticleRequest>(logger,
            service);
}