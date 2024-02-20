namespace MojStomatolog.Models.Responses
{
    public class ArticleResponse
    {
        public int ArticleId { get; set; }

        public string Title { get; set; } = string.Empty;

        public string Summary { get; set; } = string.Empty;

        public string Content { get; set; } = string.Empty;

        public DateTime PublishDate { get; set; }

        public int UserCreatedId { get; set; }
    }
}
