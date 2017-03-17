/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Application;
using CCM.Application.SystemManage;
using CCM.Code;
using CCM.Domain.Entity.SystemManage;
using CCM.Web.EIP.App_Start._01_Handler;
using System.Collections.Generic;
using System.Text;
using System.Web.Mvc;

namespace CCM.Web.EIP.Controllers
{
    public class MobileController : Controller
    {
        private CcmServices cs = new CcmServices();

        [HttpGet]
        [ActionTraceLog]
        public ActionResult Login()
        {
            return View();
        }

        [HttpGet]
        [ActionTraceLog]
        public ActionResult Index()
        {
            return View();
        }

        #region 通訊錄
        [HttpGet]
        [ActionTraceLog]
        public ActionResult page_01()
        {
            return View();
        }
        #endregion

        #region 通訊錄明細
        [HttpGet]
        public ActionResult page_01_1()
        {
            return View();
        }
        #endregion

        #region 通訊錄明細
        [HttpGet]
        public ActionResult page_01_2()
        {
            return View();
        }
        #endregion

        #region 待簽核
        [HttpGet]
        [ActionTraceLog]
        public ActionResult page_02()
        {
            return View();
        }
        [HttpGet]
        [ActionTraceLog]
        public ActionResult page_02_1()
        {
            return View();
        }
        #endregion

        #region 其他下載
        [HttpGet]
        [ActionTraceLog]
        public ActionResult page_03()
        {
            return View();
        }
        #endregion

        #region 取得員工通訊資料
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetEmpContact(string emplyid="")
        {
            var result = cs.getEmpContact(emplyid);
            var data = new
            {
                EmpContact = result
            };

            return Content(data.ToJson());
        }
        #endregion

    }
}
