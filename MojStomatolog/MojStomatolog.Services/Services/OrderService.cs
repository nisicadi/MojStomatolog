using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.Enums;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class OrderService : BaseService<OrderResponse, Order, OrderSearchObject>, IOrderService
    {
        public OrderService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<bool> CreateOrder(AddOrderRequest request)
        {
            try
            {
                var order = Mapper.Map<Order>(request);
                order.OrderDate = DateTime.Now;

                Context.Orders.Add(order);
                await Context.SaveChangesAsync();

                var user = await Context.Users.FindAsync(request.UserId);
                if (user != null && !string.IsNullOrEmpty(user.Email))
                {
                    var sendEmailRequest = new SendEmailRequest
                    {
                        Email = user.Email,
                        Subject = "Narudžba kreirana",
                        Message = "Vaša narudžba je uspješno kreirana."
                    };

                    var messageSender = new MessageSender();
                    messageSender.SendMessage(sendEmailRequest);
                }

                return true;
            }
            catch
            {
                return false;
            }
        }

        public async Task<bool> ChangeStatus(PatchOrderRequest request)
        {
            var order = await Context.Orders.FindAsync(request.OrderId);
            if (order is null || request.OrderStatus < (int)OrderStatus.InProgress || request.OrderStatus > (int)OrderStatus.Cancelled)
                return false;

            if (order.Status == (int)OrderStatus.Delivered && request.OrderStatus == (int)OrderStatus.Cancelled)
                return false;

            order.Status = request.OrderStatus;
            Context.Orders.Update(order);

            await Context.SaveChangesAsync();

            return true;
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
