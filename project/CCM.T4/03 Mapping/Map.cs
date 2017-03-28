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
		             
	//mapping table name: PO_PUBLIC_OBJECT_ATTEND_EMP
	public class PO_PUBLIC_OBJECT_ATTEND_EMPMap : EntityTypeConfiguration<PO_PUBLIC_OBJECT_ATTEND_EMPEntity>
    {
        public PO_PUBLIC_OBJECT_ATTEND_EMPMap()
        {
            this.ToTable("PO_PUBLIC_OBJECT_ATTEND_EMP");
            this.HasKey(t => t.SID);
        }
    }
			                  
}