using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class AppointmentService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<AppointmentResponse, Appointment, AppointmentSearchObject, AddAppointmentRequest,
            UpdateAppointmentRequest>(context, mapper), IAppointmentService
    {
        public override IQueryable<Appointment> AddFilter(IQueryable<Appointment> query, AppointmentSearchObject? search = null)
        {
            if (search is null)
            {
                return query;
            }

            if (!string.IsNullOrWhiteSpace(search.SearchTerm))
            {
                query = query.Where(x => EF.Functions.Like(x.Service.Name, $"%{search.SearchTerm}%"));
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

            return query.OrderByDescending(x => x.AppointmentDateTime);
        }

        public override IQueryable<Appointment> AddInclude(IQueryable<Appointment> query, AppointmentSearchObject? search = null)
        {
            return query.Include(x => x.Patient)
                        .Include(x => x.Employee)
                        .Include(x => x.Service);
        }
    }
}
