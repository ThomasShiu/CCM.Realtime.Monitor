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

    //mapping table name: PO_PUBLIC_OBJECT
    public class PO_PUBLIC_OBJECTMap : EntityTypeConfiguration<PO_PUBLIC_OBJECTEntity>
    {
        public PO_PUBLIC_OBJECTMap()
        {
            this.ToTable("PO_PUBLIC_OBJECT");
            this.HasKey(t => t.SID);
        }
    }

}