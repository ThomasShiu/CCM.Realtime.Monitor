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

    //mapping table name: ERP_ITEM_ATTACHFILE
    public class ERP_ITEM_ATTACHFILEEntity : IEntityCcm<ERP_ITEM_ATTACHFILEEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String ITEM_NO { get; set; }

        public String ITEM_NM { get; set; }

        public String ITEM_SP { get; set; }

        public String CLAS_NO { get; set; }

        public String CLAS_NM { get; set; }

        public String GUID { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}