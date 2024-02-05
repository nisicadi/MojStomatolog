using System.Net;
using System.Net.Mail;

namespace MailingService
{
    public class EmailSender
    {
        private readonly string _outlookMail;
        private readonly string _outlookPass;

        public EmailSender(string email, string password)
        {
            _outlookMail = email;
            _outlookPass = password;
        }

        public Task SendEmailAsync(string email, string subject, string message)
        {
            var client = new SmtpClient("smtp.office365.com", 587)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(_outlookMail, _outlookPass)
            };

            var mailMessage = new MailMessage
            {
                From = new MailAddress(_outlookMail),
                To = { email },
                Subject = subject,
                Body = message
            };

            return client.SendMailAsync(mailMessage);
        }
    }
}
