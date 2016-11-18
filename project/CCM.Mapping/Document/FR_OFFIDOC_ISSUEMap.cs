using CCM.Domain.Entity;
using System.Data.Entity.ModelConfiguration;

namespace CCM.Mapping
{
    public class FR_OFFIDOC_ISSUEMap : EntityTypeConfiguration<FR_OFFIDOC_ISSUEEntity>
    {
        public FR_OFFIDOC_ISSUEMap()
        {
            this.ToTable("FR_OFFIDOC_ISSUE");
            this.HasKey(t => t.F_Id);
        }
    }
}
