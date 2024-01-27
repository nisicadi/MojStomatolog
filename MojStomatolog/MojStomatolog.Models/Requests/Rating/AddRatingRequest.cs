namespace MojStomatolog.Models.Requests.Rating
{
    public class AddRatingRequest
    {
        public int ProductId { get; set; }
        public int UserId { get; set; }
        public int RatingValue { get; set; }
    }
}
