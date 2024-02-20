using System.ComponentModel.DataAnnotations.Schema;

namespace MojStomatolog.Models.Core
{
    public class Appointment
    {
        public int AppointmentId { get; set; }
        public DateTime AppointmentDateTime { get; set; }
        public string Procedure { get; set; } = null!;
        public bool IsConfirmed { get; set; }
        public string Notes { get; set; } = null!;
        public int PatientId { get; set; }
        public int EmployeeId { get; set; }

        [ForeignKey("PatientId")]
        public User? Patient { get; set; }

        [ForeignKey("EmployeeId")]
        public Employee? Employee { get; set; }
    }
}