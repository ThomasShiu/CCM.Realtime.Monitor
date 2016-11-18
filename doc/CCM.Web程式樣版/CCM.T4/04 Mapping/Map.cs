using CCM.Data;
using CCM.Domain.Entity;

//todo: 請修改對應的namespace
namespace CCM.Domain 
{        
		             
	//mapping table name: FR_OFFIDOC_ISSUE
	public class FR_OFFIDOC_ISSUEMap : EntityTypeConfiguration<FR_OFFIDOC_ISSUEEntity>
    {
        public FR_OFFIDOC_ISSUEMap()
        {
            this.ToTable("FR_OFFIDOC_ISSUE");
            this.HasKey(t => t.F_Id);
        }
    }
			 		                               

}