using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Payment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class PaymentService : BaseCrudService<PaymentResponse, Payment, BaseSearchObject, AddPaymentRequest, UpdatePaymentRequest>, IPaymentService
    {
        public PaymentService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }
    }
}