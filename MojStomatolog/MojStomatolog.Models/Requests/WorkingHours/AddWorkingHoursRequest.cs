namespace MojStomatolog.Models.Requests.WorkingHours
{
    public class AddWorkingHoursRequest
    {
        public DayOfWeek DayOfWeek { get; set; }
        public TimeSpan StartTime { get; set; }
        public TimeSpan EndTime { get; set; }
        public TimeSpan BreakStartTime { get; set; }
        public TimeSpan BreakEndTime { get; set; }

        public int? UserModifiedId { get; set; }
    }
}
