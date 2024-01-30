namespace MojStomatolog.Models.Responses
{
    public class ProductResponse
    {
        public int ProductId { get; set; }

        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int ProductCategoryId { get; set; }

        public double Price { get; set; }

        public string ImageUrl { get; set; } = null!;

        public bool Active { get; set; }

        public ProductCategoryResponse ProductCategory { get; set; } = null!;
    }
}
