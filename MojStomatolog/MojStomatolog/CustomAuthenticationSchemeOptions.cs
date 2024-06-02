using Microsoft.AspNetCore.Authentication;

namespace MojStomatolog
{
    public class CustomAuthenticationSchemeOptions : AuthenticationSchemeOptions
    {
        public new TimeProvider TimeProvider { get; set; } = TimeProvider.System;
    }
}
