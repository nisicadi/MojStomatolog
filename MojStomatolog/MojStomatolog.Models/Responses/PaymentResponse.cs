namespace MojStomatolog.Models.Responses
{
    public class PaymentResponse
    {
        public int Id { get; set; }
        public double Amount { get; set; }
        public DateTime PaymentDate { get; set; }
        public string PaymentNumber { get; set; } = string.Empty;
    }
}
