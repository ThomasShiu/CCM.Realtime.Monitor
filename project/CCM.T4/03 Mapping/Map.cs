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
		             
	//mapping table name: CCM_Main_Employee
	public class CCM_Main_EmployeeMap : EntityTypeConfiguration<CCM_Main_EmployeeEntity>
    {
        public CCM_Main_EmployeeMap()
        {
            this.ToTable("CCM_Main_Employee");
            this.HasKey(t => t.SID);
        }
    }
			                  
}