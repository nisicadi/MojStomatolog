﻿using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [Route("[controller]")]
    public class BaseController<T, TSearch>(
        ILogger<BaseController<T, TSearch>> logger,
        IBaseService<T, TSearch> service)
        : ControllerBase
        where T : class
        where TSearch : class
    {
        protected readonly IBaseService<T, TSearch> Service = service ?? throw new ArgumentNullException(nameof(service));
        protected readonly ILogger<BaseController<T, TSearch>> Logger = logger ?? throw new ArgumentNullException(nameof(logger));

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