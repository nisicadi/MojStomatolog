using MojStomatolog.Models.Requests.User;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;

namespace MojStomatolog.Services.Interfaces
{
    public interface IUserService : IBaseCrudService<UserResponse, BaseSearchObject, AddUserRequest, UpdateUserRequest>
    {
        public Task<LoginResponse> Login(string username, string password);
    }
}
