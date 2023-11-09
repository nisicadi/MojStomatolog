using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;

namespace MojStomatolog.Services.Interfaces
{
    public interface IUserService
    {
        UserResponse Add(AddUserRequest  request);
    }
}
