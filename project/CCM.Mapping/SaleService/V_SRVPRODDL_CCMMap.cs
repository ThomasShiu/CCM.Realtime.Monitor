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

    //mapping table name: V_SRVPRODDL_CCM
    public class V_SRVPRODDL_CCMMap : EntityTypeConfiguration<V_SRVPRODDL_CCMEntity>
    {
        public V_SRVPRODDL_CCMMap()
        {
            this.ToTable("V_SRVPRODDL_CCM");
            this.HasKey(t => t.PROD_NO);
        }
    }

}