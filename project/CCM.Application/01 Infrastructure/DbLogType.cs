/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCM.Application
{
    public enum DbLogType
    {
        [Description("其他")]
        Other = 0,
        [Description("登錄")]
        Login = 1,
        [Description("退出")]
        Exit = 2,
        [Description("訪問")]
        Visit = 3,
        [Description("新增")]
        Create = 4,
        [Description("刪除")]
        Delete = 5,
        [Description("修改")]
        Update = 6,
        [Description("提交")]
        Submit = 7,
        [Description("異常")]
        Exception = 8,
    }
}

