using MojStomatolog.Models.Requests.WorkingHours;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IWorkingHoursService : IBaseCrudService<WorkingHoursResponse, BaseSearchObject, AddWorkingHoursRequest, UpdateWorkingHoursRequest>
    {
        Task<byte[]> GetPdfReportBytes();
    }
}
