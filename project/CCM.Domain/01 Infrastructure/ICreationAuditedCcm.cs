﻿/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;

namespace CCM.Domain
{
    public interface ICreationAuditedCcm
    {
        string SID { get; set; }
        string CreatorUserId { get; set; }
        DateTime? CreatorTime { get; set; }

        string OrganizeId { get; set; }
    }
}