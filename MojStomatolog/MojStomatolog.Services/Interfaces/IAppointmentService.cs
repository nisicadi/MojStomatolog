using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IAppointmentService : IBaseCrudService<AppointmentResponse, AppointmentSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>
    {
    }
}
