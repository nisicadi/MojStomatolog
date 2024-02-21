using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;

namespace MojStomatolog.Services.Interfaces
{
    public interface IOrderService : IBaseService<OrderResponse, OrderSearchObject>
    {
        Task<bool> CreateOrder(AddOrderRequest request);
        Task<bool> ChangeStatus(PatchOrderRequest request);
    }
}
