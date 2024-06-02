namespace MojStomatolog.Models.Requests.SentEmail
{
    public class UpdateSentEmailRequest
    {
        public string Subject { get; set; } = string.Empty;
        public string Body { get; set; } = string.Empty;
    }
}
