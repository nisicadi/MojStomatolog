﻿namespace MojStomatolog.Models
{
    public class SendEmailRequest
    {
        public string Email { get; set; } = null!;
        public string Subject { get; set; } = null!;
        public string Message { get; set; } = null!;
    }
}
