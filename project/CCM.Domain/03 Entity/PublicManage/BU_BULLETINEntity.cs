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

    //mapping table name: BU_BULLETIN
    public class BU_BULLETINEntity : IEntityCcm<BU_BULLETINEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String BUSubject { get; set; }

        public String BUContent { get; set; }

        public DateTime StartDate { get; set; }

        public DateTime EndDate { get; set; }

        public String WhoCanSee { get; set; }

        public String DepartmentID { get; set; }

        public String EmployeeID { get; set; }

        public String GUID { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}