/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
 * Features:機台認證檔產生-研發單位管理使用
 * Table: HR_OVRTM
*********************************************************************************/
using CCM.Application;
using CCM.Application._02_Services;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.RDM.Areas.RDManage.Controllers
{
    public class RDM02Controller : ControllerBase
    {
        private RD_MACHINEAUTHApp tableApp = new RD_MACHINEAUTHApp();
        private RDService rs = new RDService();

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
        [HandlerAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteForm(string keyValue)
        {
            tableApp.DeleteForm(keyValue);
            return Success("删除成功。");
        }

       

        #region 送出
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(RD_MACHINEAUTHEntity entity, string keyValue)
        {
            //var result = rs.chkMachineExists(entity.Machine_Id);
            //if (result != "")
            //{
            //    return Error(result);
            //}
            
            tableApp.SubmitForm(entity, keyValue);
            return Success("操作成功。");
        }
        #endregion

        [HttpGet]
        public ActionResult ResetFile()
        {
            return View();
        }

        #region 清空認證檔欄位
        [HttpPost]
        [HandlerAjaxOnly]
        //[HandlerAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitResetFile( string keyValue)
        {
            tableApp.ResetFile(keyValue);
            return Success("清空認證檔成功。");
        }
        #endregion

    }


}
