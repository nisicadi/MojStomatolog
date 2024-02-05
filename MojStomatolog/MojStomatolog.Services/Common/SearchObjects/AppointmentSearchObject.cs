namespace MojStomatolog.Services.Common.SearchObjects
{
    public class AppointmentSearchObject : BaseSearchObject
    {
        public string? SearchTerm { get; set; } = null!;
        public DateTime? DateTimeFrom { get; set; }
        public DateTime? DateTimeTo { get; set; }
        public bool? IsConfirmed { get; set; }
        public int? PatientId { get; set; }
    }
}
