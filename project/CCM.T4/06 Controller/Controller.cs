﻿/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain.Entity;
using System.Web.Mvc;
             
//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.xxxx.Controllers
{
    public class FR_OFFIDOC_ISSUE_ATTACH_FILEController : ControllerBase
    {
        private FR_OFFIDOC_ISSUE_ATTACH_FILEApp tableApp = new FR_OFFIDOC_ISSUE_ATTACH_FILEApp();

        [HttpGet]
        [HandlerAjaxOnly]
		 public ActionResult GetGridJson(Pagination pagination, string keyword)
        {
            var data = new
            {
                rows = tableApp.GetList(pagination, keyword),
                total = pagination.total,
                page = pagination.page,
                records = pagination.records
            };
            return Content(data.ToJson());
        }

        public ActionResult GetGridJson(string keyword)
        {
            var data = tableApp.GetList(keyword);
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJson(string keyValue)
        {
            var data = tableApp.GetForm(keyValue);
            return Content(data.ToJson());
        }
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(FR_OFFIDOC_ISSUE_ATTACH_FILEEntity FR_OFFIDOC_ISSUE_ATTACH_FILEEntity, string keyValue)
        {
            tableApp.SubmitForm(FR_OFFIDOC_ISSUE_ATTACH_FILEEntity, keyValue);
            return Success("操作成功。");
        }
        [HttpPost]
        [HandlerAjaxOnly]
        [HandlerAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteForm(string keyValue)
        {
            tableApp.DeleteForm(keyValue);
            return Success("删除成功。");
        }
    }


}
	