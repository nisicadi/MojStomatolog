using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Controllers
{
    [Route("[controller]")]
    [Authorize]
    public class BaseController<T, TSearch> : ControllerBase
        where T : class
        where TSearch : class
    {
        protected readonly IBaseService<T, TSearch> Service;
        protected readonly ILogger<BaseController<T, TSearch>> Logger;

        public BaseController(ILogger<BaseController<T, TSearch>> logger, IBaseService<T, TSearch> service)
        {
            Logger = logger ?? throw new ArgumentNullException(nameof(logger));
            Service = service ?? throw new ArgumentNullException(nameof(service));
        }

        [HttpGet]
        public async Task<ActionResult<PagedResult<T>>> Get([FromQuery] TSearch? search = null)
        {
            try
            {
                var result = await Service.Get(search);

                return Ok(result);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpGet("{id:int}")]
        public async Task<ActionResult<T>> GetById(int id)
        {
            try
            {
                var entity = await Service.GetById(id);

                return Ok(entity);
            }
            catch (Exception ex)
            {
                Logger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}