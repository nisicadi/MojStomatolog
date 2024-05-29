using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using MojStomatolog.Services.Interfaces;
using System.Net.Http.Headers;
using System.Security.Claims;
using System.Text;
using System.Text.Encodings.Web;

namespace MojStomatolog
{
    public class BasicAuthenticationHandler(
        IUserService userService,
        IOptionsMonitor<CustomAuthenticationSchemeOptions> options,
        ILoggerFactory logger,
        UrlEncoder encoder)
        : AuthenticationHandler<CustomAuthenticationSchemeOptions>(options, logger, encoder)
    {
        protected override async Task<AuthenticateResult> HandleAuthenticateAsync()
        {
            if (!Request.Headers.TryGetValue("Authorization", out _))
            {
                return AuthenticateResult.Fail("Missing header");
            }

            var authHeader = AuthenticationHeaderValue.Parse(Request.Headers.Authorization!);

            if (authHeader.Parameter is null)
            {
                return AuthenticateResult.Fail("Invalid Authorization header");
            }

            var credentialsBytes = Convert.FromBase64String(authHeader.Parameter);
            var credentials = Encoding.UTF8.GetString(credentialsBytes).Split(':');

            if (credentials.Length != 2)
            {
                return AuthenticateResult.Fail("Invalid Authorization header");
            }

            var username = credentials[0];
            var password = credentials[1];

            var loginResult = await userService.Login(username, password);
            var user = loginResult.User;

            if (user is null)
            {
                return AuthenticateResult.Fail("Incorrect username or password");
            }

            List<Claim> claims =
            [
                new(ClaimTypes.Name, user.FirstName),
                new(ClaimTypes.NameIdentifier, user.Username)
            ];

            //foreach(var role in user.UserRoles)
            //{
            //    claims.Add(new Claim(ClaimTypes.Role, role.Role.Name));
            //}

            ClaimsIdentity identity = new(claims, Scheme.Name);

            ClaimsPrincipal principal = new(identity);

            AuthenticationTicket ticket = new(principal, Scheme.Name);

            return AuthenticateResult.Success(ticket);
        }
    }
}
