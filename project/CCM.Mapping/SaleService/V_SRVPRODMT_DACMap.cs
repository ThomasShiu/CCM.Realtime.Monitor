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

    //mapping table name: V_SRVPRODMT_CCM
    public class V_SRVPRODMT_DACMap : EntityTypeConfiguration<V_SRVPRODMT_DACEntity>
    {
        public V_SRVPRODMT_DACMap()
        {
            this.ToTable("V_SRVPRODMT_DAC");
            this.HasKey(t => t.PROD_NO);
        }
    }

}