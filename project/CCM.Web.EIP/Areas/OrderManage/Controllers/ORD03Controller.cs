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
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.OrderManage.Controllers
{
    // 訂餐明細
    public class ORD03Controller : ControllerBase
    {
        private BU_ORDERS_DETAILApp tableApp = new BU_ORDERS_DETAILApp();
        

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

        public ActionResult GetDetailJson(string ParentSID)
        {
            var data = tableApp.GetDetailList(ParentSID);
            return Content(data.ToJson());
        }

        // 新增明細表單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJson2(string keyValue)
        {
            var data = tableApp.GetForm2(keyValue);
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
        public ActionResult SubmitForm(BU_ORDERS_DETAILEntity BU_ORDERS_DETAILEntity, string keyValue)
        {
            tableApp.SubmitForm(BU_ORDERS_DETAILEntity, keyValue);
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
