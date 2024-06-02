using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class SentEmail
    {
        public int Id { get; set; }
        public string Subject { get; set; } = string.Empty;
        public string Body { get; set; } = string.Empty;
        public int UserId { get; set; }

        [ForeignKey("UserId")]
        public User User { get; set; } = null!;
    }
}
