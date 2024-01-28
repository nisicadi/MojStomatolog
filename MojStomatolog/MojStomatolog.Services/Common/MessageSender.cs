using Microsoft.Extensions.Configuration;
using RabbitMQ.Client;
using System.Text;

namespace MojStomatolog.Services.Common
{
    public class MessageSender
    {
        private readonly IConfiguration _configuration;

        public MessageSender(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        public void SendMessage(string message)
        {
            var hostName = _configuration["RabbitMQ:HostName"];

            var factory = new ConnectionFactory { HostName = hostName };
            using var connection = factory.CreateConnection();
            using var channel = connection.CreateModel();

            channel.QueueDeclare(queue: "order_processed",
                durable: false,
                exclusive: false,
                autoDelete: false,
                arguments: null);

            var body = Encoding.UTF8.GetBytes(message);

            channel.BasicPublish(exchange: string.Empty,
                routingKey: "order_processed",
                basicProperties: null,
                body: body);
        }
    }
}
