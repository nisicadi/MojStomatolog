using MojStomatolog.Models.Core;

namespace MojStomatolog.Services.Interfaces
{
    public interface ICompanySettingService
    {
        Task<CompanySetting> AddOrUpdate(CompanySetting request);
        Task<CompanySetting> GetBySettingName(string name);
    }
}
