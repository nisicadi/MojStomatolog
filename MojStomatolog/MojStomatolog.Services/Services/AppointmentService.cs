using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class AppointmentService : BaseCrudService<AppointmentResponse, Appointment, AppointmentSearchObject, AddAppointmentRequest, UpdateAppointmentRequest>, IAppointmentService
    {
        public AppointmentService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public override IQueryable<Appointment> AddFilter(IQueryable<Appointment> query, AppointmentSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                var searchTermLower = search.SearchTerm.ToLower();

                query = query.Where(x => x.Procedure.Contains(searchTermLower));
            }

            if (search.DateTimeFrom is not null)
            {
                query = query.Where(x => x.AppointmentDateTime >= search.DateTimeFrom);
            }

            if (search.DateTimeTo is not null)
            {
                query = query.Where(x => x.AppointmentDateTime <= search.DateTimeTo);
            }

            if (search.IsConfirmed is not null)
            {
                query = query.Where(x => x.IsConfirmed == search.IsConfirmed);
            }

            if (search.PatientId is not null)
            {
                query = query.Where(x => x.PatientId == search.PatientId);
            }

            return query;
        }
    }
}
