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
    public class V_HR_OVRTMMap : EntityTypeConfiguration<V_HR_OVRTMEntity>
    {
        public V_HR_OVRTMMap()
        {
            this.ToTable("V_HR_OVRTM");
            //this.ToTable("V_HR_OVRTM_TEST");
            this.HasKey(t => t.OVRTNO);
        }
    }

}