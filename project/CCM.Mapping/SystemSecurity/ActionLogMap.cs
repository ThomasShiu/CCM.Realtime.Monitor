/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Domain;
using CCM.Domain.Entity.SystemSecurity;
using System.Data.Entity.ModelConfiguration;

//todo: 請修改對應的namespace
namespace CCM.Mapping.SystemSecurity
{

    //mapping table name: SS_ACTIONLOG
    public class ActionLogMap : EntityTypeConfiguration<ActionLogEntity>
    {
        public ActionLogMap()
        {
            this.ToTable("Sys_ActionLog");
            this.HasKey(t => t.F_Id);
        }
    }

}