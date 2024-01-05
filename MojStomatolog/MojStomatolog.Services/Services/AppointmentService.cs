using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class AppointmentService : BaseCrudService<AppointmentResponse, Appointment, BaseSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>, IAppointmentService
    {
        public AppointmentService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}
