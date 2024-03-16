namespace MojStomatolog.Models.Requests.Article
{
    public class UpdateArticleRequest
    {
        public string Title { get; set; } = string.Empty;

        public string Summary { get; set; } = string.Empty;

        public string Content { get; set; } = string.Empty;

        public DateTime PublishDate { get; set; } = DateTime.Now;

        public int UserCreatedId { get; set; }
    }
}
