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

    //mapping table name: BU_LUNCH_SETTING
    public class BU_LUNCH_SETTINGEntity : IEntityCcm<BU_LUNCH_SETTINGEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {
        public String SID { get; set; }

        public String EMPLYID { get; set; }

        public String DEPID { get; set; }

        public String LOCATION { get; set; }

        public Int32 MEAT { get; set; }

        public Int32 VEGETABLE { get; set; }

        public String REMARK { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}