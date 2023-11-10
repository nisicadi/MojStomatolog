using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IUserService : IBaseCrudService<UserResponse, BaseSearchObject, AddUserRequest, UpdateUserRequest>
    {
        public Task<LoginResponse> Login(string username, string password);
    }
}
