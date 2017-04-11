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

    //mapping table name: V_HR_FRLDL_1
    public class V_HR_FRLDL_1Map : EntityTypeConfiguration<V_HR_FRLDL_1Entity>
    {
        public V_HR_FRLDL_1Map()
        {
            this.ToTable("V_HR_FRLDL_1");
            this.HasKey(t => t.SID);
        }
    }

}