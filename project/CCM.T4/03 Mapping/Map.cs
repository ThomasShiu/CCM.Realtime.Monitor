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
		             
	//mapping table name: Sys_Order_Seq
	public class Sys_Order_SeqMap : EntityTypeConfiguration<Sys_Order_SeqEntity>
    {
        public Sys_Order_SeqMap()
        {
            this.ToTable("Sys_Order_Seq");
            this.HasKey(t => t.SID);
        }
    }
			                  
}