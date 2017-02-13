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

    //mapping table name: BU_FEEDBACKMIS
    public class BU_FEEDBACKMISMap : EntityTypeConfiguration<BU_FEEDBACKMISEntity>
    {
        public BU_FEEDBACKMISMap()
        {
            this.ToTable("BU_FEEDBACKMIS");
            this.HasKey(t => t.SID);
        }
    }

}