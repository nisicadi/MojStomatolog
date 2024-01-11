namespace MojStomatolog.Models.Requests.User
{
    public class AddUserRequest
    {
        public string Username { get; set; } = null!;

        public string Password { get; set; } = null!;

        public string FirstName { get; set; } = string.Empty;

        public string LastName { get; set; } = string.Empty;

        public string Email { get; set; } = null!;

        public string Number { get; set; } = string.Empty;
    }
}
