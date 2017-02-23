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

    //mapping table name: WF_EMPADDEPT
    public class WF_EMPADDEPTMap : EntityTypeConfiguration<WF_EMPADDEPTEntity>
    {
        public WF_EMPADDEPTMap()
        {
            this.ToTable("WF_EMPADDEPT");
            this.HasKey(t => t.SID);
        }
    }

}