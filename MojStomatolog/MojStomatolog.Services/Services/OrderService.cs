using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Requests.SentEmail;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.Enums;
using MojStomatolog.Services.Common.SearchObjects;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class OrderService(MojStomatologContext context, IMapper mapper, ISentEmailService sentEmailService)
        : BaseService<OrderResponse, Order, OrderSearchObject>(context, mapper), IOrderService
    {
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
                    SendEmailRequest sendEmailRequest = new()
                    {
                        Email = user.Email,
                        Subject = "Narudžba kreirana",
                        Message = $"Vaša narudžba sa brojem {order.Id} je uspješno kreirana."
                    };

                    MessageSender messageSender = new();
                    messageSender.SendMessage(sendEmailRequest);

                    AddSentEmailRequest sentEmailRequest = new()
                    {
                        Subject = sendEmailRequest.Subject,
                        Body = sendEmailRequest.Message,
                        UserId = user.UserId
                    };

                    await sentEmailService.Insert(sentEmailRequest);
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
            {
                return false;
            }

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
                        .ThenInclude(x => x.Product)
                        .Include(x => x.Payment)
                        .Include(x => x.User);
        }
    }
}
