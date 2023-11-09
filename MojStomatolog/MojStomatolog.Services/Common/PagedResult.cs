namespace MojStomatolog.Services.Common
{
    public class PagedResult<T>
    {
        public List<T> Results { get; set; } = null!;
        public int? Count { get; set; }
    }
}