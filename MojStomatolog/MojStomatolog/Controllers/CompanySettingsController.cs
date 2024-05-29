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
    public class CompanySettingsController(
        ILogger<BaseController<WorkingHoursResponse, BaseSearchObject>> logger,
        IWorkingHoursService service)
        : BaseCrudController<WorkingHoursResponse, BaseSearchObject, AddWorkingHoursRequest, UpdateWorkingHoursRequest>(
            logger, service)
    {
        [HttpGet("GeneratePDF")]
        public async Task<ActionResult> GetPdfReport()
        {
            try
            {
                var pdfBytes = await service.GetPdfReportBytes();
                return File(pdfBytes, "application/pdf", "Izvjestaj.pdf");
            }
            catch
            {
                return BadRequest("An error occurred while generating the PDF report.");
            }
        }
    }
}