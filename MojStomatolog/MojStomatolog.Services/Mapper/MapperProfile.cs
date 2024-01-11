﻿using AutoMapper;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.Appointment;
using MojStomatolog.Models.Requests.Employee;
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
        }
    }
}
