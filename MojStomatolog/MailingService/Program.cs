using EasyNetQ;
using MojStomatolog.Models;

namespace MailingService
{
    internal class Program
    {
        private static async Task Main()
        {
            var email = Environment.GetEnvironmentVariable("OUTLOOK_MAIL") ?? "mojstomatolog@outlook.com";
            var password = Environment.GetEnvironmentVariable("OUTLOOK_PASS") ?? "2ogncWS@JD@*RM";

            // RabbitMQ configuration
            var hostNameMq = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
            var usernameMq = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
            var passwordMq = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
            var virtualHostMq = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";

            EmailSender emailSender = new(email, password);
            var rabbitMqConnectionString = $"host={hostNameMq};username={usernameMq};password={passwordMq};virtualHost={virtualHostMq}";

            await WaitForRabbitMq(rabbitMqConnectionString);

            using var bus = RabbitHutch.CreateBus(rabbitMqConnectionString);
            await bus.PubSub.SubscribeAsync<SendEmailRequest>("order_processed",
                request => HandleMessage(request, emailSender));
            Console.WriteLine("Listening for messages...");
            await Task.Delay(Timeout.Infinite);
        }

        private static async void HandleMessage(SendEmailRequest request, EmailSender emailSender)
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

        private static async Task WaitForRabbitMq(string connectionString)
        {
            while (true)
            {
                try
                {
                    using var bus = RabbitHutch.CreateBus(connectionString);
                    await bus.Advanced.QueueDeclareAsync("dummy_queue");
                    bus.Advanced.QueueDelete("dummy_queue");
                    break;
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Failed to connect to RabbitMQ: {ex.Message}. Retrying in 2 seconds...");
                    await Task.Delay(2000);
                }
            }
            Console.WriteLine("Connected to RabbitMQ.");
        }
    }
}