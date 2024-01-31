using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Core;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
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
            catch
            {
                return BadRequest("An error occurred while processing your request.");
            }
        }

        [HttpPost]
        public async Task<ActionResult<CompanySetting>> AddOrUpdate(CompanySetting request)
        {
            try
            {
                return Ok(await _companySettingService.AddOrUpdate(request));
            }
            catch
            {
                return BadRequest("An error occurred while processing your request.");
            }
        }

        [AllowAnonymous]
        [HttpGet("GeneratePDF")]
        public async Task<ActionResult> GetPdfReport()
        {
            try
            {
                var pdfBytes = await _companySettingService.GetPdfReportBytes();
                return File(pdfBytes, "application/pdf", "Izvjestaj.pdf");
            }
            catch
            {
                return BadRequest("An error occurred while generating the PDF report.");
            }
        }
    }
}