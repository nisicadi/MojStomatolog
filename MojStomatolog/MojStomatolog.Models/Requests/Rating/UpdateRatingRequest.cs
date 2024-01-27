namespace MojStomatolog.Models.Requests.Rating
{
    public class UpdateRatingRequest
    {
        public int RatingId { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }
        public int RatingValue { get; set; }
    }
}
