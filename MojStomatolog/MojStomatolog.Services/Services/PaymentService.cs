using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Payment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class PaymentService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<PaymentResponse, Payment, BaseSearchObject, AddPaymentRequest, UpdatePaymentRequest>(context,
            mapper), IPaymentService;
}