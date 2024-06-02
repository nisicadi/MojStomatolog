using AutoMapper;
using MojStomatolog.Database;

namespace MojStomatolog.Services.Common
{
    public class BaseCrudService<T, TDb, TSearch, TInsert, TUpdate>(MojStomatologContext context, IMapper mapper)
        : BaseService<T, TDb, TSearch>(context, mapper)
        where TDb : class
        where T : class
        where TSearch : BaseSearchObject
    {
        public virtual Task BeforeInsert(TDb entity, TInsert insert)
        {
            return Task.CompletedTask;
        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            Microsoft.EntityFrameworkCore.DbSet<TDb> set = Context.Set<TDb>();
            var entity = Mapper.Map<TDb>(insert);

            set.Add(entity);
            await BeforeInsert(entity, insert);

            await Context.SaveChangesAsync();
            return Mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(int id, TUpdate update)
        {
            Microsoft.EntityFrameworkCore.DbSet<TDb> set = Context.Set<TDb>();

            var entity = await set.FindAsync(id);

            if (entity is not null)
            {
                Mapper.Map(update, entity);
                await Context.SaveChangesAsync();
            }

            return Mapper.Map<T>(entity);
        }

        public virtual async Task<bool> Delete(int id)
        {
            Microsoft.EntityFrameworkCore.DbSet<TDb> set = Context.Set<TDb>();
            var entity = await set.FindAsync(id);

            if (entity is null)
            {
                return false;
            }

            set.Remove(entity);
            await Context.SaveChangesAsync();
            return true;
        }
    }
}