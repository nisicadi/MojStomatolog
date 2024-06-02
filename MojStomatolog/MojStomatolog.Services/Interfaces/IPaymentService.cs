using MojStomatolog.Models.Requests.Payment;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IPaymentService : IBaseCrudService<PaymentResponse, BaseSearchObject, AddPaymentRequest, UpdatePaymentRequest>
    {
    }
}
