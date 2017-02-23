/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain.Entity.SystemSecurity
{

    //mapping table name: SS_ACTIONLOG
    public class ActionLogEntity : IEntityCcm<ActionLogEntity>, ICreationAuditedCcm , IModificationAuditedCcm
    {
        public String SID { get; set; }

        public String Operator { get; set; }

        public String Refer { get; set; }

        public String Destination { get; set; }

        public String Method { get; set; }

        public Boolean MobleDevices { get; set; }

        public String Browser { get; set; }

        public String IPAddress { get; set; }

        public DateTime RequestTime { get; set; }

        public String OrganizeId { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String LastModifyUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

    }
}