﻿/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;

namespace CCM.Domain
{
    public interface IDeleteAuditedCcm
    {
        /// <summary>
        /// 邏輯刪除標記
        /// </summary>
        bool? DeleteMark { get; set; }

        /// <summary>
        /// 刪除實體的使用者
        /// </summary>
        string DeleteUserId { get; set; }

        /// <summary>
        /// 刪除實體時間
        /// </summary>
        DateTime? DeleteTime { get; set; }
    }
}