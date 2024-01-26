namespace MojStomatolog.Models.Core
{
    public class Order
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public DateTime OrderDate { get; set; }
        public decimal TotalAmount { get; set; }

        public HashSet<OrderItem> OrderItems { get; set; } = new HashSet<OrderItem>();
    }
}
