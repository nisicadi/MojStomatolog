﻿using AutoMapper;
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
    public class UserService(MojStomatologContext context, IMapper mapper)
        : BaseCrudService<UserResponse, User, BaseSearchObject, AddUserRequest, UpdateUserRequest>(context, mapper),
            IUserService
    {
        public async Task<LoginResponse> Login(string username, string password)
        {
            try
            {
                var user = await Context.Users.SingleOrDefaultAsync(x => x.Username == username);

                return user is null
                    ? new LoginResponse { Result = LoginResult.UserNotFound }
                    : !VerifyPassword(password, user.PasswordSalt, user.PasswordHash)
                    ? new LoginResponse { Result = LoginResult.IncorrectPassword }
                    : new LoginResponse
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

        public async Task<bool> ChangePassword(int userId, ChangePasswordRequest request)
        {
            var isSuccessful = false;

            var user = await Context.Users.SingleOrDefaultAsync(x => x.UserId == userId);
            if (user is not null)
            {
                if (user.PasswordHash == GenerateHash(user.PasswordSalt, request.CurrentPassword)
                    && request.NewPassword == request.ConfirmPassword)
                {
                    user.PasswordHash = GenerateHash(user.PasswordSalt, request.NewPassword);
                    await Context.SaveChangesAsync();

                    isSuccessful = true;
                }
            }

            return isSuccessful;
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
            var hashBytes = SHA256.HashData(combinedBytes);

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
