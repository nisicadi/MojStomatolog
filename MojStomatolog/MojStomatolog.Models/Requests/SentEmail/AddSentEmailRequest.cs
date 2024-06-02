namespace MojStomatolog.Models.Requests.SentEmail
{
    public class AddSentEmailRequest
    {
        public string Subject { get; set; } = string.Empty;
        public string Body { get; set; } = string.Empty;
        public int UserId { get; set; }
    }
}
