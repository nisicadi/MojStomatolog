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
    public class UserController : BaseCrudController<UserResponse, BaseSearchObject, AddUserRequest, UpdateUserRequest>
    {
        private readonly IUserService _userService;
        public UserController(ILogger<BaseController<UserResponse, BaseSearchObject>> logger, IUserService service) : base(logger, service)
        {
            _userService = service;
        }

        [AllowAnonymous]
        [HttpPost("Login")]
        public async Task<ActionResult<LoginResponse>> Login([FromBody] LoginRequest login)
        {
            var loginResponse = await _userService.Login(login.Username, login.Password);

            if (loginResponse.Result == LoginResult.Success)
            {
                return Ok(loginResponse.User);
            }

            return BadRequest(loginResponse.Result);
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
                var isSuccessful = await _userService.ChangePassword(userId, request);

                if (isSuccessful)
                    return Ok();

                return BadRequest("An error occurred while processing your request.");
            }
            catch
            {
                return BadRequest("An error occurred while processing your request.");
            }
        }
    }
}