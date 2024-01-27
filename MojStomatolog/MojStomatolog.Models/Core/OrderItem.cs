using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace MojStomatolog.Models.Core
{
    public class OrderItem
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public int OrderId { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }

        [ForeignKey("ProductId")]
        public Product Product { get; set; } = null!;

        [ForeignKey("OrderId")]
        [JsonIgnore]
        public Order Order { get; set; } = null!;
    }
}
