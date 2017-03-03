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

    //mapping table name: RD_MACHINEAUTH_HISTORY
    public class RD_MACHINEAUTH_HISTORYMap : EntityTypeConfiguration<RD_MACHINEAUTH_HISTORYEntity>
    {
        public RD_MACHINEAUTH_HISTORYMap()
        {
            this.ToTable("RD_MACHINEAUTH_HISTORY");
            this.HasKey(t => t.SID);
        }
    }

}