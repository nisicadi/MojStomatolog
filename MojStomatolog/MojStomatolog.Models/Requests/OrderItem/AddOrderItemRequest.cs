namespace MojStomatolog.Models.Requests.OrderItem
{
    public class AddOrderItemRequest
    {
        public int ProductId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
    }
}
