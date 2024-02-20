using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class Product
    {
        public int ProductId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int ProductCategoryId { get; set; }

        public double Price { get; set; }

        public string ImageUrl { get; set; } = null!;

        public bool Active { get; set; }


        [ForeignKey("ProductCategoryId")]
        public ProductCategory? ProductCategory { get; set; }
    }
}