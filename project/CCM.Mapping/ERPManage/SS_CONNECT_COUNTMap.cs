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

    //mapping table name: SS_CONNECT_COUNT
    public class SS_CONNECT_COUNTMap : EntityTypeConfiguration<SS_CONNECT_COUNTEntity>
    {
        public SS_CONNECT_COUNTMap()
        {
            this.ToTable("SS_CONNECT_COUNT");
            this.HasKey(t => t.SID);
        }
    }

}