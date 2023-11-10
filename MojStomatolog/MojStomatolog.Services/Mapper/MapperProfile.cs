using AutoMapper;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;

namespace MojStomatolog.Services.Mapper
{
    public class MapperProfile : Profile
    {
        public MapperProfile()
        {
            CreateMap<AddUserRequest, User>();
            CreateMap<UpdateUserRequest, User>();
            CreateMap<User, UserResponse>();
        }
    }
}
