using CCM.Data;
using CCM.Domain.Entity;

//todo: 請修改對應的namespace
namespace CCM.Domain 
{        
		             
	//mapping table name: Mis_IpAddre
	public class Mis_IpAddreMap : EntityTypeConfiguration<Mis_IpAddreEntity>
    {
        public Mis_IpAddreMap()
        {
            this.ToTable("Mis_IpAddre");
            this.HasKey(t => t.SID);
        }
    }
			 		                               

}