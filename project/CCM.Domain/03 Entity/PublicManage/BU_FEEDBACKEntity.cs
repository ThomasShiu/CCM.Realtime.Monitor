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

    //mapping table name: BU_FEEDBACK
    public class BU_FEEDBACKEntity : IEntityCcm<BU_FEEDBACKEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String FeedBackType { get; set; }

        public String FeedBackContent { get; set; }

        public DateTime? CreateDate { get; set; }

        public String WhoCanSee { get; set; }

        public String DepartmentID { get; set; }

        public String EmployeeID { get; set; }

        public String ReplyContent { get; set; }

        public DateTime? ReplyDate { get; set; }

        public String ReplyDepartmentID { get; set; }

        public String ReplyEmployeeID { get; set; }

        public String Status { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}