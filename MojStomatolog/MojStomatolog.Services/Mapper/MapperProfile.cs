using AutoMapper;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Requests.OrderItem;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Requests.User;
using MojStomatolog.Models.Responses;

namespace MojStomatolog.Services.Mapper
{
    public class MapperProfile : Profile
    {
        public MapperProfile()
        {
            #region User

            CreateMap<AddUserRequest, User>();
            CreateMap<UpdateUserRequest, User>();
            CreateMap<User, UserResponse>();

            #endregion

            #region Employee

            CreateMap<AddEmployeeRequest, Employee>();
            CreateMap<UpdateEmployeeRequest, Employee>();
            CreateMap<Employee, EmployeeResponse>();

            #endregion

            #region Product

            CreateMap<AddProductRequest, Product>();
            CreateMap<UpdateProductRequest, Product>();
            CreateMap<Product, ProductResponse>();

            #endregion

            #region Appointment

            CreateMap<AddAppointmentRequest, Appointment>();
            CreateMap<UpdateAppointmentRequest, Appointment>();
            CreateMap<Appointment, AppointmentResponse>();

            #endregion

            #region Article

            CreateMap<AddArticleRequest, Article>();
            CreateMap<UpdateArticleRequest, Article>();
            CreateMap<Article, ArticleResponse>();

            #endregion

            #region OrderItem

            CreateMap<AddOrderItemRequest, OrderItem>();
            CreateMap<OrderItem, OrderItemResponse>();

            #endregion

            #region Order

            CreateMap<AddOrderRequest, Order>();
            CreateMap<Order, OrderResponse>();

            #endregion
        }
    }
}
