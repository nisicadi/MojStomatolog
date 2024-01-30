using EasyNetQ;
using MojStomatolog.Models;

namespace MojStomatolog.Services.Common
{
    public class MessageSender
    {
        public static void SendMessage(SendEmailRequest sendEmailRequest)
        {
            var hostName = Environment.GetEnvironmentVariable("HOSTNAME") ?? "localhost";
            using var bus = RabbitHutch.CreateBus($"host={hostName}");
            bus.PubSub.Publish(sendEmailRequest);
        }
    }
}
