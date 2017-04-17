
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
    public class rtm_machinesEntity : IEntity<rtm_machinesEntity>, ICreationAudited, IModificationAudited
    {

        public string F_Id { get; set; }

        public string F_Machine_ID { get; set; }

        public string F_Machine_Model { get; set; }

        public string F_Machine_Type { get; set; }

        public string F_ADC_IP_Address { get; set; }

        public string F_Remark { get; set; }

        public DateTime? F_CreatorTime { get; set; }

        public string F_CreatorUserId { get; set; }

        public DateTime? F_LastModifyTime { get; set; }

        public string F_LastModifyUserId { get; set; }

    }
}