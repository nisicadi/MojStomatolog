using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.Rating;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class RatingController : BaseCrudController<RatingResponse, BaseSearchObject, AddRatingRequest, UpdateRatingRequest>
    {
        private readonly IRatingService _ratingService;
        public RatingController(ILogger<BaseController<RatingResponse, BaseSearchObject>> logger, IRatingService service) : base(logger, service)
        {
            _ratingService = service;
        }

        [HttpGet("{productId}/averageRating")]
        public async Task<IActionResult> GetAverageRating(int productId)
        {
            try
            {
                var averageRating = await _ratingService.GetAverageRatingAsync(productId);
                return Ok(averageRating);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpGet("user/{userId}/product/{productId}")]
        public async Task<ActionResult<Rating>> GetUserRating(int userId, int productId)
        {
            try
            {
                var rating = await _ratingService.GetUserRatingAsync(userId, productId);
                return Ok(rating);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}