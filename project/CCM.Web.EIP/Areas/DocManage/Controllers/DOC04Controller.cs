using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Web.EIP.App_Start;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

/// <summary>
/// 收文附件管理
/// </summary>
/// <remarks>
/// 紀錄接收公文的附加檔案
/// </remarks>
namespace CCM.Web.EIP.Areas.DocManage.Controllers
{

    public class DOC04Controller : ControllerBase
    {
        //
        // GET: /DocManage/DOC04/
        private FR_OFFIDOC_RECE_ATTACH_FILEApp tableApp = new FR_OFFIDOC_RECE_ATTACH_FILEApp();
        private FR_OFFIDOC_RECEApp App = new FR_OFFIDOC_RECEApp();

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

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJsonUpload(string keyword)
        {
            //var data = tableApp.GetList(keyword); 
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = tableApp.GetList(keyword),
                total = tableApp.GetList(keyword).Count
            };
            return Content(data.ToJson());
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetSubGridJson(string keyword)
        {
            var master = App.GetList(keyword);
            var guid = (from x in master
                      where x.SID == keyword
                      select new { guid = x.GUID }).First();

            var data = tableApp.GetList(keyword); 
            //var data = new
            //{
            //    current = 1,
            //    rowCount = 10,
            //    rows = tableApp.GetList(guid.ToString()),
            //    total = tableApp.GetList(guid.ToString()).Count
            //};
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
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
        public ActionResult SubmitForm(FR_OFFIDOC_RECE_ATTACH_FILEEntity entity, string keyValue)
        {
            tableApp.SubmitForm(entity, keyValue);
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
