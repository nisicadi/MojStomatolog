namespace MojStomatolog.Models.Requests.Appointment
{
    public class UpdateAppointmentRequest
    {
        public DateTime AppointmentDateTime { get; set; }
        public string Procedure { get; set; } = null!;
        public bool IsConfirmed { get; set; }
        public string Notes { get; set; } = null!;
        public int PatientId { get; set; }
    }
}
