using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;

namespace MojStomatolog.Services.Interfaces
{
    public interface IUserService
    {
        Task<UserResponse> Add(AddUserRequest  request);
    }
}
