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
using CCM.Web.EIP.App_Start;
using System.Web.Mvc;

//公務車預約
namespace CCM.Web.EIP.Areas.PublicObject.Controllers
{
    public class PUB02Controller : ControllerBase
    {
        private PO_PUBLIC_OBJECT_BOOKINGApp tableApp = new PO_PUBLIC_OBJECT_BOOKINGApp();

        #region 警衛專用畫面
        [UserTraceLog]
        [HttpGet]
        [HandlerAuthorize]
        public virtual ActionResult Form2()
        {
            return View();
        }
        #endregion

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCarGridJson(Pagination pagination, string queryJson)
        {
            var data = new
            {
                rows = tableApp.GetList_BookingCar(pagination, queryJson),
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
            if (!string.IsNullOrEmpty(tableEntity.Status) )
            {
                if (string.IsNullOrEmpty(tableEntity.CreatorUserId) | !OperatorProvider.Provider.GetCurrent().UserCode.Equals("admin"))
                {
                    if (tableEntity.Status.Contains("鎖定") | tableEntity.Status.Contains("取消"))
                    {
                        return Error("不可修改。");
                    }
                }
            }

            if (tableEntity.BookingStartTime < tableEntity.BookingEndTime) {
                tableApp.SubmitForm(tableEntity, keyValue);
                return Success("操作成功。");
            }else
            {
                return Error("使用時間:<br/>["+ tableEntity.BookingStartTime.ToString("yyyy-MM-dd HH:mm") + "] 至["+ tableEntity.BookingEndTime.ToString("yyyy-MM-dd HH:mm") + "] <br/>結束時間不可等於或早於開始時間，請重新調整時間再存檔。");
            }
        }

        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm2(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity, string keyValue)
        {

            if (tableEntity.BookingStartTime < tableEntity.BookingEndTime)
            {
                tableApp.SubmitForm(tableEntity, keyValue);
                return Success("操作成功。");
            }
            else
            {
                return Error("使用時間:<br/>[" + tableEntity.BookingStartTime.ToString("yyyy-MM-dd HH:mm") + "] 至[" + tableEntity.BookingEndTime.ToString("yyyy-MM-dd HH:mm") + "] <br/>結束時間不可等於或早於開始時間，請重新調整時間再存檔。");
            }
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
