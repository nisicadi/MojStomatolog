namespace MojStomatolog.Services.Common.SearchObjects
{
    public class EmployeeSearchObject : BaseSearchObject
    {
        public string? SearchTerm { get; set; } = null!;
        public DateTime? DateFrom { get; set; }
        public DateTime? DateTo { get; set; }
    }
}
