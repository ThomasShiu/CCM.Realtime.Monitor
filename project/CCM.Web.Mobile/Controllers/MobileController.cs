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
using System.Collections.Generic;
using System.Text;
using System.Web.Mvc;

namespace CCM.Web.Mobile.Controllers
{
    [HandlerLogin]
    public class MobileController : Controller
    {
        private CcmServices cs = new CcmServices();

        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }

        #region 通訊錄
        [HttpGet]
        public ActionResult page_01()
        {
            return View();
        }
        #endregion

        #region 通訊錄
        [HttpGet]
        public ActionResult page_02()
        {
            return View();
        }
        #endregion

        #region 通訊錄
        [HttpGet]
        public ActionResult page_03()
        {
            return View();
        }
        #endregion

        #region 取得員工通訊資料
        [HttpPost]
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
