using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IAppointmentService : IBaseCrudService<AppointmentResponse, BaseSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>
    {
    }
}
