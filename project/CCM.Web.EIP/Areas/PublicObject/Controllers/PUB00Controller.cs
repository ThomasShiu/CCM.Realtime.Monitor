/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
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

    public class PUB00Controller : Controller
    {
        private PO_PUBLIC_OBJECTApp tableApp = new PO_PUBLIC_OBJECTApp();
        private CcmServices cs = new CcmServices();

        #region 取得公共物件
        // 公共物件
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetPublicObject(string keyword)
        {
            var data = tableApp.GetList(keyword);
            return Content(data.ToJson());
        }
        #endregion

        #region 取得公共物件 by SID
        // 公共物件 by SID
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetPublicObjectSID(string keyword)
        {
            var data = tableApp.GetListSID(keyword);
            return Content(data.ToJson());
        }
        #endregion

        #region 取得警衛名單
        // 警衛名單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGuardList(string keyword)
        {
            //string v_sql = "SELECT USR_NO, USR_NM, USR_PW, DEPM_NO, DEPM_NM, E_MAIL  FROM PO_GUARDNO";
            //string result = ccmService.GetJson(v_sql);
            string result = cs.getGuardList();

            //var data = tableApp.GetList(keyword);
            return Content(result);
        }
        #endregion

        #region 取得最近里程
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetLastMileage(string keyValue)
        {
            var data = cs.GetCarMile(keyValue);
            return Content(data);
        }
        #endregion
    }


}
