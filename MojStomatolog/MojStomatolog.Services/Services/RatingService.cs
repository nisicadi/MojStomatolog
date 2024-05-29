using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Rating;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class RatingService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<RatingResponse, Rating, BaseSearchObject, AddRatingRequest, UpdateRatingRequest>(context,
            mapper), IRatingService
    {
        public async Task<double> GetAverageRatingAsync(int productId)
        {
            return await Context.Ratings
                .Where(r => r.ProductId == productId)
                .AverageAsync(r => (double?)r.RatingValue) ?? 0.0;
        }

        public async Task<RatingResponse> GetUserRatingAsync(int userId, int productId)
        {
            var rating = await Context.Ratings
                .FirstOrDefaultAsync(r => r.ProductId == productId && r.UserId == userId);

            return Mapper.Map<RatingResponse>(rating);
        }
    }
}