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

    //mapping table name: BU_ORDERS_DETAIL
    public class BU_ORDERS_DETAILMap : EntityTypeConfiguration<BU_ORDERS_DETAILEntity>
    {
        public BU_ORDERS_DETAILMap()
        {
            this.ToTable("BU_ORDERS_DETAIL");
            this.HasKey(t => t.SID);
        }
    }

}