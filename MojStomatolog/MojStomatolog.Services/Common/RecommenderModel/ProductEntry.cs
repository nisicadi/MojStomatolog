using Microsoft.ML.Data;

namespace MojStomatolog.Services.Common.RecommenderModel
{
    public class ProductEntry
    {
        [KeyType(count: 30)]
        public uint ProductId { get; set; }

        [KeyType(count: 30)]
        public uint CoPurchaseProductId { get; set; }

        public float Label { get; set; }
    }
}