namespace MojStomatolog.Models.Responses
{
    public class EmployeeResponse
    {
        public int EmployeeId { get; set; }

        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public char Gender { get; set; }

        public string Email { get; set; } = null!;

        public string Number { get; set; } = null!;

        public string Specialization { get; set; } = null!;

        public DateTime StartDate { get; set; }
    }
}
