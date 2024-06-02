namespace MojStomatolog.Models.Responses
{
    public class SentEmailResponse
    {
        public int Id { get; set; }
        public string Subject { get; set; } = string.Empty;
        public string Body { get; set; } = string.Empty;

        public UserResponse User { get; set; } = new();
    }
}