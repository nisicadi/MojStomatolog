namespace MojStomatolog.Models.Requests.Appointment
{
    public class AddAppointmentRequest
    {
        public DateTime AppointmentDateTime { get; set; }
        public string Procedure { get; set; } = null!;
        public bool IsConfirmed { get; set; }
        public string Notes { get; set; } = null!;
        public int PatientId { get; set; }
        public int EmployeeId { get; set; }
        public int ServiceId { get; set; }
    }
}
