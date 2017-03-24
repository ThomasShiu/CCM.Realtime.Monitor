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

    //mapping table name: ERP_ITEM_ATTACHFILE
    public class ERP_ITEM_ATTACHFILEMap : EntityTypeConfiguration<ERP_ITEM_ATTACHFILEEntity>
    {
        public ERP_ITEM_ATTACHFILEMap()
        {
            this.ToTable("ERP_ITEM_ATTACHFILE");
            this.HasKey(t => t.SID);
        }
    }

}