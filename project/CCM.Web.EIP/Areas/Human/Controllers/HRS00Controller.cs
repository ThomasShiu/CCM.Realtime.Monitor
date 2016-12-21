/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using System.Web.Mvc;

namespace CCM.Web.EIP.Areas.Human.Controllers
{
    public class HRS00Controller : ControllerBase
    {
        //
        // GET: /Human/HRS00/

        private HR_DEPApp DepApp = new HR_DEPApp();

        // 部門
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHR_DEP(string keyword)
        {
            var data = DepApp.GetList(keyword);
            return Content(data.ToJson());
        }
        private HR_EMPLYMApp EmplyApp = new HR_EMPLYMApp();

        // 員工
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHR_EMPLY(string keyword)
        {
            //var data = EmplyApp.GetList(keyword);
            var data = EmplyApp.GetListActDep(keyword); 
            return Content(data.ToJson());
        }

        CCM_Main_EmployeeApp CCM_EmpApp = new CCM_Main_EmployeeApp();
        // 員工
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCCM_EMP(string keyword)
        {
            //var data = EmplyApp.GetList(keyword);
            var data = CCM_EmpApp.GetList(keyword);
            return Content(data.ToJson());
        }
    }
}
