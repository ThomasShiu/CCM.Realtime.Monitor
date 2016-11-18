using CCM.Domain;
using System.Data.Entity.ModelConfiguration;


namespace CCM.Mapping.MisManage
{
    public class MisIpAddressMap : EntityTypeConfiguration<MisIpAddressEntity>
    {
        public MisIpAddressMap()
        {
            this.ToTable("Mis_IpAddress");
            this.HasKey(t => t.SID);
        }
    }
}
