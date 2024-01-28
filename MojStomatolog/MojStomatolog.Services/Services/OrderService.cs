using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class OrderService : BaseService<OrderResponse, Order, OrderSearchObject>, IOrderService
    {
        private readonly MessageSender _messageSender;
        public OrderService(MojStomatologContext context, IMapper mapper, MessageSender messageSender) : base(context, mapper)
        {
            _messageSender = messageSender;
        }

        public async Task<bool> CreateOrder(AddOrderRequest request)
        {
            try
            {
                var order = Mapper.Map<Order>(request);
                order.OrderDate = DateTime.Now;

                Context.Orders.Add(order);
                await Context.SaveChangesAsync();

                _messageSender.SendMessage("Narudžba uspješno kreirana!");

                return true;
            }
            catch
            {
                return false;
            }
        }

        public override IQueryable<Order> AddFilter(IQueryable<Order> query, OrderSearchObject? search = null)
        {
            if (search?.UserId is not null)
            {
                query = query.Where(x => x.UserId == search.UserId);
            }

            return query.OrderByDescending(x => x.OrderDate);
        }

        public override IQueryable<Order> AddInclude(IQueryable<Order> query, OrderSearchObject? search = null)
        {
            return query.Include(x => x.OrderItems)
                        .ThenInclude(x => x.Product);
        }
    }
}
