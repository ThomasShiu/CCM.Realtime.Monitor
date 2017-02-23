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

    //mapping table name: SRM_ALBUMMT
    public class SRM_ALBUMMTMap : EntityTypeConfiguration<SRM_ALBUMMTEntity>
    {
        public SRM_ALBUMMTMap()
        {
            this.ToTable("SRM_ALBUMMT");
            this.HasKey(t => t.SID);
        }
    }

}