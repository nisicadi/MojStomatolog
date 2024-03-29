namespace MojStomatolog.Models.Core
{
    public class Payment
    {
        public int Id { get; set; }
        public double Amount { get; set; }
        public DateTime PaymentDate { get; set; }
        public string PaymentNumber { get; set; } = string.Empty;
    }
}
