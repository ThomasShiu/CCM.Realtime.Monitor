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

    //mapping table name: HR_DEP
    public class HR_DEPMap : EntityTypeConfiguration<HR_DEPEntity>
    {
        public HR_DEPMap()
        {
            this.ToTable("V_HR_DEP");
            this.HasKey(t => t.DEPID);
        }
    }

}