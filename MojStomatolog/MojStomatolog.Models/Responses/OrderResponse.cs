using MojStomatolog.Models.Core;

namespace MojStomatolog.Models.Responses
{
    public class OrderResponse
    {
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }

        public List<OrderItem> OrderItems { get; set; } = new List<OrderItem>();
    }
}
