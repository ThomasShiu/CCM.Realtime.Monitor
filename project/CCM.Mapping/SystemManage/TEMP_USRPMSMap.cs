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

    //mapping table name: TEMP_USRPMS
    public class TEMP_USRPMSMap : EntityTypeConfiguration<TEMP_USRPMSEntity>
    {
        public TEMP_USRPMSMap()
        {
            this.ToTable("TEMP_USRPMS");
            this.HasKey(t => t.SID);
        }
    }

}