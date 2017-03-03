/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
 * Features:加班單簽核
 * Table: HR_OVRTM
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Web.EIP.App_Start._01_Handler;
using System;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.WorkflowControl.Controllers
{
    // 待簽核加班單清單
    public class WFC07Controller : ControllerBase
    {
        private HR_OVRTMApp tableApp = new HR_OVRTMApp();
        private V_HR_TICKETApp tableApp2 = new V_HR_TICKETApp();

        private CcmServices cs = new CcmServices();


        // 會簽
        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult Signwith()
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

        #region 待簽核加班單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJsonList(string keyword)
        {
            //var data = tableApp.GetList(keyword);
            var data = cs.getWaitSignList(keyword);
            return Content(data.ToJson());
        }
        #endregion

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


        #region 取得打卡時間
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetTicketJsonList(string emplyid, string yymmdd)
        {

            var rows = cs.getTicketList(emplyid, yymmdd);

            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = rows,
                total = rows.Count
            };
            return Content(data.ToJson());
        }
        #endregion

    }


}
