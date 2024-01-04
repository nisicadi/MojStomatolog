namespace MojStomatolog.Models.Requests.Employee
{
    public class UpdateEmployeeRequest
    {
        public string FirstName { get; set; } = null!;

        public string LastName { get; set; } = null!;

        public char Gender { get; set; }

        public string Email { get; set; } = null!;

        public string Number { get; set; } = null!;

        public string Specialization { get; set; } = null!;

        public DateTime StartDate { get; set; }
    }
}
