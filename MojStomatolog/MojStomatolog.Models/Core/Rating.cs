using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class Rating
    {
        public int RatingId { get; set; }
        public int ProductId { get; set; }
        public int UserId { get; set; }
        public int RatingValue { get; set; }

        [ForeignKey("ProductId")]
        public Product Product { get; set; } = null!;

        [ForeignKey("UserId")]
        public User User { get; set; } = null!;
    }
}