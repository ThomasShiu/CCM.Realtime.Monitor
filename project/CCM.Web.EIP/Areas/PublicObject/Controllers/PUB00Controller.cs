/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

// 公務車 會議室 公共設施管理
namespace CCM.Web.EIP.Areas.PublicObject.Controllers
{

    public class PUB00Controller : ControllerBase
    {
        private PO_PUBLIC_OBJECTApp tableApp = new PO_PUBLIC_OBJECTApp();

        // 公共物件
        public ActionResult GetPublicObject(string keyword)
        {
            var data = tableApp.GetList(keyword);
            return Content(data.ToJson());
        }

    }


}
