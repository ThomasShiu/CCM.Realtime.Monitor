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

    //mapping table name: HR_OVRTM_TEST
    public class HR_OVRTM_TESTMap : EntityTypeConfiguration<HR_OVRTM_TESTEntity>
    {
        public HR_OVRTM_TESTMap()
        {
            this.ToTable("HR_OVRTM_TEST");
            this.HasKey(t => t.OVRTNO);
        }
    }

}