using System.ComponentModel.DataAnnotations;

namespace MojStomatolog.Models.Core
{
    public class CompanySetting
    {
        [Key]
        public int SettingId { get; set; }
        public string SettingName { get; set; } = string.Empty;
        public string SettingValue { get; set; } = string.Empty;
    }
}
