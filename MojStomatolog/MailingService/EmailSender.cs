using System.Net;
using System.Net.Mail;

namespace MailingService
{
    public class EmailSender(string outlookMail, string password)
    {
        public Task SendEmailAsync(string email, string subject, string message)
        {
            var smtpHost = Environment.GetEnvironmentVariable("SMTP_HOST") ?? "smtp.office365.com";
            var smtpPort = 587;

            if (int.TryParse(Environment.GetEnvironmentVariable("SMTP_PORT"), out var port))
            {
                smtpPort = port;
            }

            SmtpClient client = new(smtpHost, smtpPort)
            {
                EnableSsl = true,
                UseDefaultCredentials = false,
                Credentials = new NetworkCredential(outlookMail, password)
            };

            MailMessage mailMessage = new()
            {
                From = new MailAddress(outlookMail),
                To = { email },
                Subject = subject,
                Body = message
            };

            return client.SendMailAsync(mailMessage);
        }
    }
}
