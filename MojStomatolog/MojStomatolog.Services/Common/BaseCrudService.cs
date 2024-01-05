using AutoMapper;
using MojStomatolog.Database;

namespace MojStomatolog.Services.Common
{
    public class BaseCrudService<T, TDb, TSearch, TInsert, TUpdate> : BaseService<T, TDb, TSearch>
        where TDb : class
        where T : class
        where TSearch : BaseSearchObject
    {
        public BaseCrudService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public virtual Task BeforeInsert(TDb entity, TInsert insert)
        {
            return Task.CompletedTask;
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = Context.Set<TDb>();
            var entity = Mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await Context.SaveChangesAsync();
            return Mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(int id, TUpdate update)
        {
            var set = Context.Set<TDb>();

            var entity = await set.FindAsync(id);

            if (entity != null)
            {
                Mapper.Map(update, entity);
                await Context.SaveChangesAsync();
            }

            return Mapper.Map<T>(entity);
        }

        public virtual async Task<bool> Delete(int id)
        {
            var set = Context.Set<TDb>();
            var entity = await set.FindAsync(id);

            if (entity == null) 
                return false;

            set.Remove(entity);
            await Context.SaveChangesAsync();
            return true;
        }
    }
}