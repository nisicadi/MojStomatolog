using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests.User;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.Enums;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [Authorize]
    [ApiController]
    [Route("[controller]")]
    public class UserController(ILogger<BaseController<UserResponse, BaseSearchObject>> logger, IUserService service)
        : BaseCrudController<UserResponse, BaseSearchObject, AddUserRequest, UpdateUserRequest>(logger, service)
    {
        [AllowAnonymous]
        [HttpPost("Login")]
        public async Task<ActionResult<LoginResponse>> Login([FromBody] LoginRequest login)
        {
            var loginResponse = await service.Login(login.Username, login.Password);

            return loginResponse.Result == LoginResult.Success ? Ok(loginResponse.User) : BadRequest(loginResponse.Result);
        }

        [AllowAnonymous]
        [HttpPost("Register")]
        public override Task<ActionResult<UserResponse>> Insert([FromBody] AddUserRequest insert)
        {
            return base.Insert(insert);
        }

        [HttpPost("{userId:int}/ChangePassword")]
        public async Task<ActionResult> ChangePassword(int userId, [FromBody] ChangePasswordRequest request)
        {
            try
            {
                var isSuccessful = await service.ChangePassword(userId, request);

                return isSuccessful ? Ok() : BadRequest("An error occurred while processing your request.");
            }
            catch
            {
                return BadRequest("An error occurred while processing your request.");
            }
        }
    }
}