using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.WorkingHours;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class CompanySettingsController : BaseCrudController<WorkingHoursResponse, BaseSearchObject, AddWorkingHoursRequest, UpdateWorkingHoursRequest>
    {
        private readonly IWorkingHoursService _workingHoursService;
        public CompanySettingsController(ILogger<BaseController<WorkingHoursResponse, BaseSearchObject>> logger, IWorkingHoursService service) : base(logger, service)
        {
            _workingHoursService = service;
        }

        [HttpGet("GeneratePDF")]
        public async Task<ActionResult> GetPdfReport()
        {
            try
            {
                var pdfBytes = await _workingHoursService.GetPdfReportBytes();
                return File(pdfBytes, "application/pdf", "Izvjestaj.pdf");
            }
            catch
            {
                return BadRequest("An error occurred while generating the PDF report.");
            }
        }
    }
}