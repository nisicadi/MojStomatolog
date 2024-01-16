using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IArticleService : IBaseCrudService<ArticleResponse, BaseSearchObject, AddArticleRequest, UpdateArticleRequest>
    {
    }
}
