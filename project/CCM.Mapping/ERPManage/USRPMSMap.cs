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

    //mapping table name: TEMP_USRPMS
    public class USRPMSMap : EntityTypeConfiguration<USRPMSEntity>
    {
        public USRPMSMap()
        {
            this.ToTable("V_USRPMS_LIST");
            this.HasKey(t => t.SID);
        }
    }

}