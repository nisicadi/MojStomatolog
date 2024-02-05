using EasyNetQ;
using MojStomatolog.Models;

namespace MojStomatolog.Services.Common
{
    public class MessageSender
    {
        private readonly string _host = Environment.GetEnvironmentVariable("RABBITMQ_HOST") ?? "localhost";
        private readonly string _username = Environment.GetEnvironmentVariable("RABBITMQ_USERNAME") ?? "user";
        private readonly string _password = Environment.GetEnvironmentVariable("RABBITMQ_PASSWORD") ?? "mypass";
        private readonly string _virtualhost = Environment.GetEnvironmentVariable("RABBITMQ_VIRTUALHOST") ?? "/";
        public void SendMessage(SendEmailRequest sendEmailRequest)
        {
            using var bus = RabbitHutch.CreateBus($"host={_host};virtualHost={_virtualhost};username={_username};password={_password}");

            bus.PubSub.Publish(sendEmailRequest);
        }
    }
}
