namespace MojStomatolog.Models.Requests.Payment
{
    public class UpdatePaymentRequest
    {
        public double Amount { get; set; }
        public DateTime PaymentDate { get; set; }
        public string PaymentNumber { get; set; } = string.Empty;
    }
}
