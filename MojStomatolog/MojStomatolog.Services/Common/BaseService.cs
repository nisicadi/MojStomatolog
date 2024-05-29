using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;

namespace MojStomatolog.Services.Common
{
    public class BaseService<T, TDb, TSearch>(MojStomatologContext context, IMapper mapper) : IBaseService<T, TSearch>
        where TDb : class
        where T : class
        where TSearch : BaseSearchObject
    {
        protected MojStomatologContext Context = context ?? throw new ArgumentNullException(nameof(context));
        protected IMapper Mapper { get; } = mapper ?? throw new ArgumentNullException(nameof(mapper));

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            IQueryable<TDb> query = Context.Set<TDb>().AsQueryable();
            PagedResult<T> result = new();

            query = AddFilter(query, search);
            query = AddInclude(query, search);

            result.Count = await query.CountAsync().ConfigureAwait(false);

            if (search?.Page.HasValue == true && search.PageSize.HasValue)
            {
                // First page is 1, hence the (search.Page.Value - 1)
                query = query.Skip((search.Page.Value - 1) * search.PageSize.Value).Take(search.PageSize.Value);
            }

            List<TDb> list = await query.ToListAsync().ConfigureAwait(false);

            List<T> mappedList = Mapper.Map<List<T>>(list);
            result.Results = mappedList;
            return result;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> query, TSearch? search = null)
        {
            // Implement specific includes in derived classes, if needed
            return query;
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> query, TSearch? search = null)
        {
            // Implement specific filtering in derived classes, if needed
            return query;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await Context.Set<TDb>().FindAsync(id).ConfigureAwait(false);
            return Mapper.Map<T>(entity);
        }
    }
}