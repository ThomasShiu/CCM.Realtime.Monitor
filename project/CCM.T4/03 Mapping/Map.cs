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
		             
	//mapping table name: BU_ORDERS_MENU
	public class BU_ORDERS_MENUMap : EntityTypeConfiguration<BU_ORDERS_MENUEntity>
    {
        public BU_ORDERS_MENUMap()
        {
            this.ToTable("BU_ORDERS_MENU");
            this.HasKey(t => t.SID);
        }
    }
			                  
}