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
		             
	//mapping table name: V_SRVPRODMT_CCM
	public class V_SRVPRODMT_CCMMap : EntityTypeConfiguration<V_SRVPRODMT_CCMEntity>
    {
        public V_SRVPRODMT_CCMMap()
        {
            this.ToTable("V_SRVPRODMT_CCM");
            this.HasKey(t => t.SID);
        }
    }
			                  
}