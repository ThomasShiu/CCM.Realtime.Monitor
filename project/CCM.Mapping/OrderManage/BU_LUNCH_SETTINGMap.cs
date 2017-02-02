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

    //mapping table name: BU_LUNCH_SETTING
    public class BU_LUNCH_SETTINGMap : EntityTypeConfiguration<BU_LUNCH_SETTINGEntity>
    {
        public BU_LUNCH_SETTINGMap()
        {
            this.ToTable("BU_LUNCH_SETTING");
            this.HasKey(t => t.SID);
        }
    }

}