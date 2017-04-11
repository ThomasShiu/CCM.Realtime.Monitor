/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain
{

    //mapping table name: RD_DWG_EXMANAGE_MT
    public class RD_DWG_EXMANAGE_MTEntity : IEntityCcm<RD_DWG_EXMANAGE_MTEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String ORD_NO { get; set; }

        public DateTime? ORD_DATE { get; set; }

        public String PROD_NO { get; set; }

        public String ITEM_NO { get; set; }

        public String ITEM_NM { get; set; }

        public DateTime? EXPORT_DATE { get; set; }

        public Int32 EXPORT_QTY { get; set; }

        public String TO_DEPT { get; set; }

        public String TO_EMP { get; set; }

        public String FM_DEPT { get; set; }

        public String FM_EMP { get; set; }

        public String CS_NO { get; set; }

        public String SHORT_NM { get; set; }

        public String REMARK { get; set; }

        public String STATUS { get; set; }

        public String GUID { get; set; }

        public bool? Enable { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}