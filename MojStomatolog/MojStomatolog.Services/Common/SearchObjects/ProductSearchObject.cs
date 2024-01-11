namespace MojStomatolog.Services.Common.SearchObjects
{
    public class ProductSearchObject : BaseSearchObject
    {
        public string? SearchTerm { get; set; } = null!;
        public double? PriceFrom { get; set; }
        public double? PriceTo { get; set; }
        public bool? IsActive { get; set; }
    }
}
