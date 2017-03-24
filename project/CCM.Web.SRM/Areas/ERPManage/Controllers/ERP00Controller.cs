/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Application._02_Services;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.SRM.Areas.ERPManage.Controllers
{
    public class ERP00Controller : Controller
    {
        private SRMService ss = new SRMService();

        #region 取得料件分類
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetITCLASList(string keyword="")
        {
            var data = ss.GetITCLASList(keyword);
            return Content(data.ToJson());
        }
        #endregion

        #region 取得料件
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetITEMList(string keyword = "")
        {
            var data = ss.GetITEMList(keyword);
            return Content(data.ToJson());
        }
        #endregion
    }


}
