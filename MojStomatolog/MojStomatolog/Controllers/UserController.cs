using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using MojStomatolog.Models.Requests;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : BaseCrudController<UserResponse, BaseSearchObject, AddUserRequest, UpdateUserRequest>
    {
        public UserController(ILogger<BaseController<UserResponse, BaseSearchObject>> logger, IUserService service) : base(logger, service)
        {
        }

        [AllowAnonymous]
        public override Task<ActionResult<UserResponse>> Insert([FromBody] AddUserRequest insert)
        {
            return base.Insert(insert);
        }
    }
}