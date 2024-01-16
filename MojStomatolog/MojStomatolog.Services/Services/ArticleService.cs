using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ArticleService : BaseCrudService<ArticleResponse, Article, ArticleSearchObject, AddArticleRequest, UpdateArticleRequest>, IArticleService
    {
        public ArticleService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Article> AddFilter(IQueryable<Article> query, ArticleSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x => x.Title.Contains(searchTermLower));
            }

            if (search.DateFrom is not null)
            {
                query = query.Where(x => x.PublishDate >= search.DateFrom);
            }

            if (search.DateTo is not null)
            {
                query = query.Where(x => x.PublishDate <= search.DateTo);
            }   

            return query;
        }
    }
}
