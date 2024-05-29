namespace MojStomatolog.Models.Responses
{
    public class RatingResponse
    {
        public int RatingId { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }
        public int RatingValue { get; set; }

        public ProductResponse Product { get; set; } = null!;
    }
}
