using Microsoft.EntityFrameworkCore;
using MojStomatolog.Models.Core;

namespace MojStomatolog.Database
{
    public class MojStomatologContext : DbContext
    {

        public MojStomatologContext(DbContextOptions<MojStomatologContext> options) : base(options)
        {
        }

        public virtual DbSet<User> Users { get; set; } = null!;
        public virtual DbSet<Employee> Employees { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            foreach (var foreignKey in modelBuilder.Model.GetEntityTypes()
                         .SelectMany(e => e.GetForeignKeys()))
            {
                foreignKey.DeleteBehavior = DeleteBehavior.NoAction;
            }
        }
    }
}
