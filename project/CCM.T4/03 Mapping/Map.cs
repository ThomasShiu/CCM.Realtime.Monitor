/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Domain;
using System.Data.Entity.ModelConfiguration;

//todo: 請修改對應的namespace
namespace CCM.Mapping 
{        
		             
	//mapping table name: RD_DWG_EXMANAGE_MT
	public class RD_DWG_EXMANAGE_MTMap : EntityTypeConfiguration<RD_DWG_EXMANAGE_MTEntity>
    {
        public RD_DWG_EXMANAGE_MTMap()
        {
            this.ToTable("RD_DWG_EXMANAGE_MT");
            this.HasKey(t => t.SID);
        }
    }
			                  
}