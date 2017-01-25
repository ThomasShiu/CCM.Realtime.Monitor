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

    //mapping table name: BU_ORDERS
    public class BU_ORDERSEntity : IEntityCcm<BU_ORDERSEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String Subject { get; set; }

        public String StoreID { get; set; }

        public String OrderContent { get; set; }

        public String WhoCanSee { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public DateTime? CreateDate { get; set; }

        public String EmployeeID { get; set; }

        public String DepartmentID { get; set; }

        public Int32? Qty { get; set; }

        public Int32? Amount { get; set; }

        public Int32? SubsidizeAmount { get; set; }

        public String GUID { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}