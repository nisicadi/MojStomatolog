using MojStomatolog.Models.Core;

namespace MojStomatolog.Models.Responses
{
    public class AppointmentResponse
    {
        public int AppointmentId { get; set; }
        public DateTime AppointmentDateTime { get; set; }
        public string Procedure { get; set; } = null!;
        public bool IsConfirmed { get; set; }
        public string Notes { get; set; } = null!;
        public int PatientId { get; set; }

        public UserResponse Patient { get; set;}
    }
}