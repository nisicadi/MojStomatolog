using AutoMapper;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests;
using MojStomatolog.Services.Interfaces;
using System.Security.Cryptography;
using System.Text;
using MojStomatolog.Models.Responses;

namespace MojStomatolog.Services.Services
{
    public class UserService : IUserService
    {
        private readonly MojStomatologContext _context;
        private readonly IMapper _mapper;

        public UserService(MojStomatologContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }


        public async Task<UserResponse> Add(AddUserRequest request)
        {
            var entity = new User();
            _mapper.Map(request, entity);

            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);

            _context.Users.Add(entity);
            await _context.SaveChangesAsync();

            return _mapper.Map<UserResponse>(entity);
        }

        public static string GenerateSalt()
        {
            using var rng = RandomNumberGenerator.Create();
            var byteArray = new byte[16];
            rng.GetBytes(byteArray);

            return Convert.ToBase64String(byteArray);
        }

        public static string GenerateHash(string salt, string password)
        {
            var src = Convert.FromBase64String(salt);
            var bytes = Encoding.UTF8.GetBytes(password);
            var dst = new byte[src.Length + bytes.Length];

            Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            using var algorithm = SHA256.Create();
            var inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
    }
}
