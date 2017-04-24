/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 *              共用功能集中區
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Application.Services;
using CCM.Application.ViewModel;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using System;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.RTM.Admin.Areas.rtmManage.Controllers
{
    public class RTM00Controller : Controller
    {
        private readonly RealTimeService _RealTimeSvc;
        public RTM00Controller()
        {
            _RealTimeSvc = new RealTimeService();
        }

        
        public ActionResult ShowClock()
        {
            return View();
        }

    }


}
