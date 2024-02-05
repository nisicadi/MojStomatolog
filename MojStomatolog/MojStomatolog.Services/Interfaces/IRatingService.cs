using MojStomatolog.Models.Requests.Rating;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IRatingService : IBaseCrudService<RatingResponse, BaseSearchObject, AddRatingRequest, UpdateRatingRequest>
    {
        Task<double> GetAverageRatingAsync(int productId);
        Task<RatingResponse> GetUserRatingAsync(int userId, int productId);
    }
}
