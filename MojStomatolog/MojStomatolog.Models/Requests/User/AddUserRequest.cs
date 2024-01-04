namespace MojStomatolog.Models.Requests.User
{
    public class AddUserRequest
    {
        public string Username { get; set; } = null!;

        public string Password { get; set; } = null!;

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? Email { get; set; }

        public string? Number { get; set; }
    }
}
