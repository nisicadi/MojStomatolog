using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class ArticleService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<ArticleResponse, Article, ArticleSearchObject, AddArticleRequest, UpdateArticleRequest>(
            context, mapper), IArticleService
    {
        public override IQueryable<Article> AddFilter(IQueryable<Article> query, ArticleSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                query = query.Where(x => EF.Functions.Like(x.Title, $"%{search.SearchTerm}%"));
            }

            if (search.DateFrom is not null)
            {
                query = query.Where(x => x.PublishDate >= search.DateFrom);
            }

            if (search.DateTo is not null)
            {
                query = query.Where(x => x.PublishDate <= search.DateTo);
            }

            return query.OrderByDescending(x => x.PublishDate);
        }
    }
}
