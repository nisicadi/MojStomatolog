using MojStomatolog.Models.Core;

namespace MojStomatolog.Models.Responses
{
    public class OrderResponse
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int PaymentId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }
        public int Status { get; set; }

        public List<OrderItem> OrderItems { get; set; } = [];
        public PaymentResponse Payment { get; set; } = null!;
        public UserResponse User { get; set; } = null!;
    }
}
