/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇 
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
 * Features:加班單申請-個人使用，只顯示自己的加班單
 * Table: HR_OVRTM
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Web.EIP.App_Start._01_Handler;
using System.Web.Mvc;

namespace CCM.Web.EIP.Areas.WorkflowControl.Controllers
{
    public class WFC06Controller : ControllerBase
    {
        private HR_OVRTMApp tableApp = new HR_OVRTMApp();
        private CcmServices cs = new CcmServices();

        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult IndexEmp()
        {
            return View();
        }

        [HttpGet]
        //[HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult IndexEmpTest()
        {
            return View();
        }

        [HttpGet]
        //[HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult FormTest()
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

        #region 加班申請作業-員工個人
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJsonEmp(Pagination pagination, string keyword)
        {
            var data = new
            {
                rows = tableApp.GetListEmp(pagination, keyword),
                total = pagination.total,
                page = pagination.page,
                records = pagination.records
            };
            return Content(data.ToJson());
        }
        #endregion

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
            var chkovrtm = cs.chkOverTime(tableEntity);
            // 加班規則檢查
            if (chkovrtm.Length > 0 & chkovrtm[0] != null) {
                return Error("錯誤碼:"+chkovrtm[0]+" : "+ chkovrtm[1]);
            }
            // 新建模式才判斷時段是否重複
            if (string.IsNullOrEmpty(keyValue)) 
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
