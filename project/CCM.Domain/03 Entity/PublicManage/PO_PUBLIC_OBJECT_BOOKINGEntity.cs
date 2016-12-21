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

    //mapping table name: PO_PUBLIC_OBJECT_BOOKING
    public class PO_PUBLIC_OBJECT_BOOKINGEntity : IEntityCcm<PO_PUBLIC_OBJECT_BOOKINGEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String ObjectType { get; set; }

        public String UseReason { get; set; }

        public String Subject { get; set; }

        public String Description { get; set; }

        public String EmployeeID { get; set; }

        public String DepartmentID { get; set; }

        public String ObjectSID { get; set; }

        public DateTime BookingStartTime { get; set; }

        public DateTime BookingEndTime { get; set; }

        public int? ProjectSID { get; set; }

        public int? Mileage { get; set; }

        public int? MileageLast { get; set; }

        public String Status { get; set; }

        public String LeaveTime { get; set; }

        public String BackTime { get; set; }

        public String GuardEMPID { get; set; }
        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }
    }
}