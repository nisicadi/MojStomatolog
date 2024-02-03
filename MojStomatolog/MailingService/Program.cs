using System.Net;
using System.Net.Mail;
using EasyNetQ;
using MojStomatolog.Models;

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

    class Program
    {
        static void Main()
        {
            var email = Environment.GetEnvironmentVariable("OUTLOOK_MAIL") ?? "mojstomatolog@outlook.com";
            var password = Environment.GetEnvironmentVariable("OUTLOOK_PASS") ?? "2ogncWS@JD@*RM";

            // RabbitMQ configuration
            var hostNameMq = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
            var usernameMq = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
            var passwordMq = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
            var virtualHostMq = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

            var emailSender = new EmailSender(email, password);
            var rabbitMqConnectionString = $"host={hostNameMq};username={usernameMq};password={passwordMq};virtualHost={virtualHostMq}";

            using var bus = RabbitHutch.CreateBus(rabbitMqConnectionString);
            bus.PubSub.Subscribe<SendEmailRequest>("order_processed", request => HandleTextMessage(request, emailSender));
            Console.WriteLine("Listening for messages. Hit <return> to quit.");
            Console.ReadLine();
        }

        static async void HandleTextMessage(SendEmailRequest request, EmailSender emailSender)
        {
            Console.WriteLine($"Received: {request.Subject}, {request.Message}");

            try
            {
                await emailSender.SendEmailAsync(request.Email, request.Subject, request.Message);
                Console.WriteLine("Email sent successfully");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Error sending email: {ex.Message}");
            }
        }
    }
}