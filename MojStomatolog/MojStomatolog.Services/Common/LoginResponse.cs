using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common.Enums;

namespace MojStomatolog.Services.Common
{
    public class LoginResponse
    {
        public LoginResult Result { get; set; }
        public UserResponse User { get; set; } = null!;
    }

}
