namespace MojStomatolog.Models.Responses
{
    public class UserResponse
    {
        public int UserId { get; set; }

        public string Username { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? Email { get; set; }

        public string? Number { get; set; }

        public byte[]? Image { get; set; }
    }
}
