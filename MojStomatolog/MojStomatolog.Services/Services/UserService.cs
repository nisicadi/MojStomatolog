using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Models.Requests.User;
using MojStomatolog.Models.Responses;
using MojStomatolog.Services.Common;
using MojStomatolog.Services.Common.Enums;
using MojStomatolog.Services.Interfaces;
using System.Security.Cryptography;
using System.Text;

namespace MojStomatolog.Services.Services
{
    public class UserService : BaseCrudService<UserResponse, User, BaseSearchObject, AddUserRequest, UpdateUserRequest>, IUserService
    {
        public UserService(MojStomatologContext context, IMapper mapper) : base(context, mapper)
        {
        }

        public async Task<LoginResponse> Login(string username, string password)
        {
            try
            {
                var user = await Context.Users.SingleOrDefaultAsync(x => x.Username == username);

                if (user is null)
                {
                    return new LoginResponse { Result = LoginResult.UserNotFound };
                }

                if (!VerifyPassword(password, user.PasswordSalt, user.PasswordHash))
                {
                    return new LoginResponse { Result = LoginResult.IncorrectPassword };
                }

                return new LoginResponse
                {
                    Result = LoginResult.Success,
                    User = Mapper.Map<UserResponse>(user)
                };
            }
            catch (Exception)
            {
                return new LoginResponse { Result = LoginResult.UnexpectedError };
            }
        }


        #region Helpers

        public override async Task BeforeInsert(User entity, AddUserRequest request)
        {
            entity.PasswordSalt = GenerateSalt();
            entity.PasswordHash = GenerateHash(entity.PasswordSalt, request.Password);

            await base.BeforeInsert(entity, request);
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
            var passwordBytes = Encoding.UTF8.GetBytes(password);
            var saltBytes = Convert.FromBase64String(salt);

            var combinedBytes = new byte[saltBytes.Length + passwordBytes.Length];
            Buffer.BlockCopy(saltBytes, 0, combinedBytes, 0, saltBytes.Length);
            Buffer.BlockCopy(passwordBytes, 0, combinedBytes, saltBytes.Length, passwordBytes.Length);

            using var sha256 = SHA256.Create();
            var hashBytes = sha256.ComputeHash(combinedBytes);

            return Convert.ToBase64String(hashBytes);
        }

        private static bool VerifyPassword(string password, string storedSalt, string storedHash)
        {
            var hash = GenerateHash(storedSalt, password);

            return hash == storedHash;
        }

        #endregion
    }
}
