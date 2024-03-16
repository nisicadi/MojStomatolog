using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class Article
    {
        public int ArticleId { get; set; }

        public string Title { get; set; } = string.Empty;

        public string Summary { get; set; } = string.Empty;

        public string Content { get; set; } = string.Empty;

        public DateTime PublishDate { get; set; } = DateTime.Now;

        public int UserCreatedId { get; set; }

        [ForeignKey("UserCreatedId")]
        public User User { get; set; } = null!;
    }
}