using AutoMapper;
using Microsoft.EntityFrameworkCore;
using MojStomatolog.Database;
using MojStomatolog.Models.Core;
using MojStomatolog.Services.Interfaces;

namespace MojStomatolog.Services.Services
{
    public class CompanySettingService : ICompanySettingService
    {
        private MojStomatologContext _context;
        private IMapper _mapper { get; }

        public CompanySettingService(MojStomatologContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
        }
        public async Task<CompanySetting> AddOrUpdate(CompanySetting request)
        {
            var entity = await _context.CompanySettings
                .FirstOrDefaultAsync(x => x.SettingName == request.SettingName);

            if (entity == null)
            {
                await _context.CompanySettings.AddAsync(request);
            }
            else
            {
                entity.SettingValue = request.SettingValue;
                _context.CompanySettings.Update(entity);
            }

            await _context.SaveChangesAsync();
            return await GetBySettingName(request.SettingName);
        }

        public async Task<CompanySetting> GetBySettingName(string name)
        {
            return await _context.CompanySettings.FirstOrDefaultAsync(x => x.SettingName == name) ?? new CompanySetting();
        }
    }
}
