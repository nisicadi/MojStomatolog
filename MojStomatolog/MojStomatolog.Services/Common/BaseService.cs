using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;

namespace MojStomatolog.Services.Common
{
    public class BaseService<T, TDb, TSearch> : IBaseService<T, TSearch>
        where TDb : class
        where T : class
        where TSearch : BaseSearchObject
    {
        protected MojStomatologContext Context;
        protected IMapper Mapper { get; }

        public BaseService(MojStomatologContext context, IMapper mapper)
        {
            Context = context ?? throw new ArgumentNullException(nameof(context));
            Mapper = mapper ?? throw new ArgumentNullException(nameof(mapper));
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var query = Context.Set<TDb>().AsQueryable();
            var result = new PagedResult<T>();

            query = AddFilter(query, search);
            query = AddInclude(query, search);

            result.Count = await query.CountAsync().ConfigureAwait(false);

            if (search?.Page.HasValue == true && search.PageSize.HasValue)
            {
                query = query.Take(search.PageSize.Value).Skip(search.Page.Value * search.PageSize.Value);
            }

            var list = await query.ToListAsync().ConfigureAwait(false);

            var mappedList = Mapper.Map<List<T>>(list);
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