using CCM.Domain;
using System.Data.Entity.ModelConfiguration;

//todo: 請修改對應的namespace
namespace CCM.Mapping
{

    //mapping table name: FR_OFFIDOC_ISSUE
    public class FR_OFFIDOC_ISSUEMap : EntityTypeConfiguration<FR_OFFIDOC_ISSUEEntity>
    {
        public FR_OFFIDOC_ISSUEMap()
        {
            this.ToTable("FR_OFFIDOC_ISSUE");
            this.HasKey(t => t.SID);
        }
    }

}