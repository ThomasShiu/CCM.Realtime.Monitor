/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版权所有
 * Author: CCM
 * Description: CCM快速开发平台
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
    public class HomeController : Controller
    {
        private CcmServices cs = new CcmServices();

        [HttpGet]
        public ActionResult Index()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Indexm()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Default()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Dashboard()
        {
            return View();
        }
        [HttpGet]
        public ActionResult About()
        {
            return View();
        }
        [HttpGet]
        public ActionResult Study()
        {
            return View();
        }
        // 特約廠商
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetVendor() {
            var result = cs.GetVendorList();
            var data = new
            {
                Vendors = result
            };

            return Content(data.ToJson());
        }
        // 公佈欄
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetBulletin()
        {
            var result = cs.GetBulletinList();
            var data = new
            {
                Bulletin = result
            };

            return Content(data.ToJson());
        }
        // 公務車
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCarList()
        {
            var result = cs.getPubObjectList("公務車輛");
            var data = new
            {
                CarList = result
            };

            return Content(data.ToJson());
        }

        // 會議室
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetRoomList()
        {
            var result = cs.getPubObjectList("會議室");
            var data = new
            {
                RoomList = result
            };

            return Content(data.ToJson());
        }

        // 差勤人員
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetLeaveEmpList()
        {
            var result = cs.getLeaveEmpList();
            var data = new
            {
                LeaveEmpList = result
            };

            return Content(data.ToJson());
        }

        // 外出人員
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetOutdoorEmpList()
        {
            var result = cs.getOutdoorEmpList();
            var data = new
            {
                OutdoorEmpList = result
            };

            return Content(data.ToJson());
        }
        // 待簽核加班單筆數
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetWaitSignCount()
        {
            var result = cs.getWaitSignCount("");
            var data = new
            {
                WaitSignCount = result
            };

            return Content(data.ToJson());
        }
    }
}
