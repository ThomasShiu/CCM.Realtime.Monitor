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

namespace CCM.Web.EIP.Controllers
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
    }
}
