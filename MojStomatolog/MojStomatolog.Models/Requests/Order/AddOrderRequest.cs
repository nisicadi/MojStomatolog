using MojStomatolog.Models.Requests.OrderItem;

namespace MojStomatolog.Models.Requests.Order
{
    public class AddOrderRequest
    {
        public int UserId { get; set; }
        public decimal TotalAmount { get; set; }
        public List<AddOrderItemRequest> OrderItems { get; set; } = new List<AddOrderItemRequest>();
    }
}