using MojStomatolog.Models.Core;
using System.ComponentModel.DataAnnotations.Schema;

public class Rating
{
    public int RatingId { get; set; }
    public int ProductId { get; set; }
    public int UserId { get; set; }
    public int RatingValue { get; set; }

    [ForeignKey("ProductId")]
    public Product? Product { get; set; }

    [ForeignKey("UserId")]
    public User? User { get; set; }
}