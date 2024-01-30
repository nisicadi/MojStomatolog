namespace MojStomatolog.Models.Requests.Product
{
    public class UpdateProductRequest
    {
        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public int ProductCategoryId { get; set; }

        public double Price { get; set; }

        public string ImageUrl { get; set; } = null!;

        public bool Active { get; set; }
    }
}
