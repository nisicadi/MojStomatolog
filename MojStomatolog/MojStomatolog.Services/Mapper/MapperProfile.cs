using AutoMapper;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Requests.Article;
using MojStomatolog.Models.Requests.Employee;
using MojStomatolog.Models.Requests.Order;
using MojStomatolog.Models.Requests.OrderItem;
using MojStomatolog.Models.Requests.Payment;
using MojStomatolog.Models.Requests.Product;
using MojStomatolog.Models.Requests.ProductCategory;
using MojStomatolog.Models.Requests.Rating;
using MojStomatolog.Models.Requests.Service;
using MojStomatolog.Models.Requests.User;
using MojStomatolog.Models.Requests.WorkingHours;
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

            #region Rating

            CreateMap<AddRatingRequest, Rating>()
                .ForMember(dest => dest.RatingId, opt => opt.Ignore())
                .ForMember(dest => dest.ProductId, opt => opt.MapFrom(src => src.ProductId))
                .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.UserId))
                .ForMember(dest => dest.RatingValue, opt => opt.MapFrom(src => src.RatingValue))
                .ForMember(dest => dest.Product, opt => opt.Ignore());
            
            CreateMap<UpdateRatingRequest, Rating>();
            CreateMap<Rating, RatingResponse>();

            #endregion

            #region ProductCategory

            CreateMap<AddProductCategoryRequest, ProductCategory>();
            CreateMap<UpdateProductCategoryRequest, ProductCategory>();
            CreateMap<ProductCategory, ProductCategoryResponse>();

            #endregion

            #region Service

            CreateMap<AddServiceRequest, Service>();
            CreateMap<UpdateServiceRequest, Service>();
            CreateMap<Service, ServiceResponse>();

            #endregion

            #region WorkingHours

            CreateMap<AddWorkingHoursRequest, WorkingHours>();
            CreateMap<UpdateWorkingHoursRequest, WorkingHours>();
            CreateMap<WorkingHours, WorkingHoursResponse>();

            #endregion

            #region Payment

            CreateMap<AddPaymentRequest, Payment>();
            CreateMap<UpdatePaymentRequest, Payment>();
            CreateMap<Payment, PaymentResponse>();

            #endregion
        }
    }
}
