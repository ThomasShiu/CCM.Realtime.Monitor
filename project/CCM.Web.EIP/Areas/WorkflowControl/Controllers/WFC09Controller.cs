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

// 預留
namespace CCM.Web.EIP.Areas.WorkflowControl.Controllers
{
    public class WFC09Controller : Controller
    {
        private HR_OVRTMApp tableApp = new HR_OVRTMApp();
        private CcmServices cs = new CcmServices();


        [HttpGet]
        //[HandlerAuthorize]
        public virtual ActionResult IndexEmpTest()
        {
            return View();
        }

        [HttpGet]
        //[HandlerAuthorize]
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


    }


}
