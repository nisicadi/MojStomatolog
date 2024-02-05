using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IArticleService : IBaseCrudService<ArticleResponse, ArticleSearchObject, AddArticleRequest, UpdateArticleRequest>
    {
    }
}
