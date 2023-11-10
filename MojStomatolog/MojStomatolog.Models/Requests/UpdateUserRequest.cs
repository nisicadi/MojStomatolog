namespace MojStomatolog.Models.Requests
{
    public class UpdateUserRequest
    {
        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public string? Email { get; set; }

        public string? Number { get; set; }
    }
}
