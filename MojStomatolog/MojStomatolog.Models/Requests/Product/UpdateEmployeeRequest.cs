namespace MojStomatolog.Models.Requests.Product
{
    public class UpdateProductRequest
    {
        public string Name { get; set; } = null!;

        public string Description { get; set; } = null!;

        public string Category { get; set; } = null!;

        public double Price { get; set; }

        public string ImageUrl { get; set; } = null!;

        public bool Active { get; set; }
    }
}
