namespace MojStomatolog.Models.Requests.Order
{
    public class PatchOrderRequest
    {
        public int OrderId { get; set; }
        public int OrderStatus { get; set; }
    }
}
