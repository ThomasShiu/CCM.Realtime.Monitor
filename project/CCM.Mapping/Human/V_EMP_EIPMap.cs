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

    //mapping table name: V_EMP_EIP
    public class V_EMP_EIPMap : EntityTypeConfiguration<V_EMP_EIPEntity>
    {
        public V_EMP_EIPMap()
        {
            this.ToTable("V_EMP_EIP");
            this.HasKey(t => t.EMPLYID);
        }
    }

}