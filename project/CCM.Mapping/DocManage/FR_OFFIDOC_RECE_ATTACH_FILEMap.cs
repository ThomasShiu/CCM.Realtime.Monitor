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

    //mapping table name: FR_OFFIDOC_RECE_ATTACH_FILE
    public class FR_OFFIDOC_RECE_ATTACH_FILEMap : EntityTypeConfiguration<FR_OFFIDOC_RECE_ATTACH_FILEEntity>
    {
        public FR_OFFIDOC_RECE_ATTACH_FILEMap()
        {
            this.ToTable("FR_OFFIDOC_RECE_ATTACH_FILE");
            this.HasKey(t => t.SID);
        }
    }

}