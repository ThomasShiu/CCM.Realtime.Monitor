﻿/*******************************************************************************
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
    public class V_SRVPRODMT_KSCMap : EntityTypeConfiguration<V_SRVPRODMT_KSCEntity>
    {
        public V_SRVPRODMT_KSCMap()
        {
            this.ToTable("V_SRVPRODMT_KSC");
            this.HasKey(t => t.PROD_NO);
        }
    }

}