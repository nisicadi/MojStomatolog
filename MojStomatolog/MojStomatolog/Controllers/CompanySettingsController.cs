using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Core;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class CompanySettingsController : ControllerBase
    {
        private readonly ICompanySettingService _companySettingService;
        public CompanySettingsController(ICompanySettingService companySettingService)
        {
            _companySettingService = companySettingService;
        }

        [HttpGet]
        public async Task<ActionResult<CompanySetting>> GetBySettingName(string settingName)
        {
            try
            {
                return Ok(await _companySettingService.GetBySettingName(settingName));
            }
            catch (Exception e)
            {
                return BadRequest(e);
            }
        }

        [HttpPost]
        public async Task<ActionResult<CompanySetting>> AddOrUpdate(CompanySetting request)
        {
            try
            {
                return Ok(await _companySettingService.AddOrUpdate(request));
            }
            catch (Exception e)
            {
                return BadRequest(e);
            }
        }
    }
}