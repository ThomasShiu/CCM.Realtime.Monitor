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
using CCM.Web.EIP.App_Start._01_Handler;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.WorkflowControl.Controllers
{
    // 查詢本身部門加班單
    public class WFC08Controller : ControllerBase
    {
        private HR_OVRTMApp tableApp = new HR_OVRTMApp();
        private V_HR_OVRTMApp vtableApp = new V_HR_OVRTMApp();
        private CcmServices cs = new CcmServices();

        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult IndexEmp()
        {
            return View();
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJson(Pagination pagination, string queryJson)
        {
            var data = new
            {
                rows = vtableApp.GetList(pagination, queryJson),
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
        public ActionResult SubmitForm(HR_OVRTMEntity tableEntity, string keyValue)
        {
            if (string.IsNullOrEmpty(keyValue)) //新建模式才判斷時段是否重複
            {
                // 判斷該加班時段是否已有預約
                string v_message = cs.chkOverTimeDup(tableEntity);
                if (!string.IsNullOrEmpty(v_message))
                {
                    return Error(v_message);
                }
            }
            tableApp.SubmitForm(tableEntity, keyValue);
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
