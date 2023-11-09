using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly IUserService _userService;

        public UserController(IUserService userService)
        {
            _userService = userService;
        }


        [HttpPost]
        public UserResponse Add(AddUserRequest request)
        {
            return _userService.Add(request);
        }
    }
}