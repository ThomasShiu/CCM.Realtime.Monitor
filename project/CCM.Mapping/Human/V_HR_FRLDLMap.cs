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

    //mapping table name: V_HR_FRLDL
    public class V_HR_FRLDLMap : EntityTypeConfiguration<V_HR_FRLDLEntity>
    {
        public V_HR_FRLDLMap()
        {
            this.ToTable("V_HR_FRLDL");
            this.HasKey(t => t.FMNO);
        }
    }

}