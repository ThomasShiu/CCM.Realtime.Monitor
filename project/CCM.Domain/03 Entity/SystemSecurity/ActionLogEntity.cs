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
    public class ActionLogEntity : IEntity<ActionLogEntity>, ICreationAudited
    {
        public string F_Id { get; set; }

        public string F_Operator { get; set; }

        public string F_Refer { get; set; }

        public string F_Destination { get; set; }

        public string F_Method { get; set; }

        public Boolean F_MobleDevices { get; set; }

        public string F_Browser { get; set; }

        public string F_IPAddress { get; set; }

        public DateTime F_RequestTime { get; set; }

        public DateTime? F_CreatorTime { get; set; }

        public string F_CreatorUserId { get; set; }

       

    }
}