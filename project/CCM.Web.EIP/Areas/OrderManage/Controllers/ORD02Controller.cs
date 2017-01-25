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
using CCM.Web.EIP.App_Start._01_Handler;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.OrderManage.Controllers
{
    public class ORD02Controller : ControllerBase
    {
        private BU_ORDERSApp tableApp = new BU_ORDERSApp();
        private BU_ORDERS_SOTREApp storeApp = new BU_ORDERS_SOTREApp();
        private BU_ORDERS_DETAILApp detailApp = new BU_ORDERS_DETAILApp();
        private CcmServices cs = new CcmServices();

        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult Form2()
        {
            return View();
        }

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

        // 特約廠商
        public ActionResult GetStoreJsonList()
        {
            var data = cs.GetVendorList();
            return Content(data.ToJson());
        }

        // 訂餐明細
        public ActionResult GetOrderDetailList(string keyword)
        {
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = cs.getOrderDetailList(keyword),
                total = cs.getOrderDetailList(keyword).Count
            };
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
        public ActionResult SubmitForm(BU_ORDERSEntity BU_ORDERSEntity, string keyValue)
        {
            tableApp.SubmitForm(BU_ORDERSEntity, keyValue);
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
        
        // 新增訂購明細
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult SubmitDetail( string submitJson)
        {
            var result = cs.addOrderDetail(submitJson);
            if (result)
            {
                return Success("操作成功。");
            }
            else {
                return Error("操作失敗。");
            }
        }

        // 刪除訂購明細
        [HttpPost]
        [HandlerAjaxOnly]
        public ActionResult DeleteDetail(string keyValue,string keyValue2)
        {
            detailApp.DeleteForm(keyValue);
            cs.refreshOrderDetail(keyValue2);
            return Success("删除成功。");
        }

    }


}
