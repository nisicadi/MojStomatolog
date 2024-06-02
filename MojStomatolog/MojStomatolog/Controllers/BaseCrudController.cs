using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [Route("[controller]")]
    public class BaseCrudController<T, TSearch, TInsert, TUpdate>(
        ILogger<BaseController<T, TSearch>> logger,
        IBaseCrudService<T, TSearch, TInsert, TUpdate> service)
        : BaseController<T, TSearch>(logger, service)
        where T : class
        where TSearch : class
    {
        protected readonly IBaseCrudService<T, TSearch, TInsert, TUpdate> CrudService = service ?? throw new ArgumentNullException(nameof(service));
        protected readonly ILogger<BaseController<T, TSearch>> CrudLogger = logger ?? throw new ArgumentNullException(nameof(logger));

        [HttpPost]
        public virtual async Task<ActionResult<T>> Insert([FromBody] TInsert insert)
        {
            try
            {
                var result = await CrudService.Insert(insert);

                return Ok(result);
            }
            catch (Exception ex)
            {
                CrudLogger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpPut("{id}")]
        public virtual async Task<ActionResult<T>> Update(int id, [FromBody] TUpdate update)
        {
            try
            {
                var result = await CrudService.Update(id, update);

                return Ok(result);
            }
            catch (Exception ex)
            {
                CrudLogger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }

        [HttpDelete("{id}")]
        public virtual async Task<ActionResult> Delete(int id)
        {
            try
            {
                var result = await CrudService.Delete(id);

                return result ? NoContent() : NotFound();
            }
            catch (Exception ex)
            {
                CrudLogger.LogError(ex, "Error occurred while processing the request.");
                return StatusCode(500, "Internal Server Error");
            }
        }
    }
}
