using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ArticleService : BaseCrudService<ArticleResponse, Article, BaseSearchObject, AddArticleRequest, UpdateArticleRequest>, IArticleService
    {
        public ArticleService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
