/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Web.EIP.App_Start;
using CCM.Web.EIP.App_Start._01_Handler;
using System.Web.Mvc;

//公務車預約
namespace CCM.Web.EIP.Areas.PublicObject.Controllers
{
    public class PUB03Controller : ControllerBase
    {
        private PO_PUBLIC_OBJECT_BOOKINGApp tableApp = new PO_PUBLIC_OBJECT_BOOKINGApp();
        private CcmServices cs = new CcmServices();

        [HttpGet]
        [ActionTraceLog]
        public ActionResult IndexPub()
        {
            return View();
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetRoomGridJson(Pagination pagination, string queryJson)
        {
            var data = new
            {
                rows = tableApp.GetList_BookingRoom(pagination, queryJson),
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
        public ActionResult SubmitForm(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity, string keyValue)
        {
            // 判斷該時段是否已有預約
            string v_message = cs.chkPubObjExistBooking(tableEntity);
            if (!string.IsNullOrEmpty(v_message))
            {
                return Error(v_message);
            }

            tableApp.SubmitForm(tableEntity , keyValue);
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
