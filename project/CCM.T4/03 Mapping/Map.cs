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
		             
	//mapping table name: HR_EMPLYM
	public class HR_EMPLYMMap : EntityTypeConfiguration<HR_EMPLYMEntity>
    {
        public HR_EMPLYMMap()
        {
            this.ToTable("HR_EMPLYM");
            this.HasKey(t => t.SID);
        }
    }
			                  
}