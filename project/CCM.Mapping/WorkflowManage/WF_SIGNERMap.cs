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

    //mapping table name: WF_SIGNER_TEST
    public class WF_SIGNERMap : EntityTypeConfiguration<WF_SIGNEREntity>
    {
        public WF_SIGNERMap()
        {
            this.ToTable("VIEW_WF_SIGNER1");
            this.HasKey(t => t.SID);
        }
    }

}