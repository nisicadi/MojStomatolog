using AutoMapper;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class UserService : IUserService
    {
        public readonly IMapper _mapper;

        public UserService(IMapper mapper)
        {
            _mapper = mapper;
        }

    }
}
