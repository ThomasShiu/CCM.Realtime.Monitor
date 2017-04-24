
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
    public class realtime_sortingEntity : IEntity<realtime_sortingEntity> //, ICreationAudited, IModificationAudited
    {

        public int Date_Machine { get; set; }

        public string Machine { get; set; }

        public string Status { get; set; }

        public string WorkOrder { get; set; }

        public int Total { get; set; }

        public int Pass { get; set; }

        public int Rejected { get; set; }

        public int Speed { get; set; }

        public int Retest { get; set; }

        public string Teach { get; set; }

        public string User_ID { get; set; }

        public DateTime StartingTime { get; set; }

        public DateTime EndTime { get; set; }

    }
}