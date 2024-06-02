using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int PaymentId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public int Status { get; set; }

        public HashSet<OrderItem> OrderItems { get; set; } = [];

        [ForeignKey("UserId")]
        public User User { get; set; } = null!;

        [ForeignKey("PaymentId")]
        public Payment Payment { get; set; } = null!;
    }
}
