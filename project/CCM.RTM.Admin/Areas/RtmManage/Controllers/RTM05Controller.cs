/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
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
    public class RTM05Controller : Controller
    {
        private readonly RealTimeService _RealTimeSvc;
        public RTM05Controller()
        {
            _RealTimeSvc = new RealTimeService();
        }
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetSortList(string keyword)
        {
            var data = _RealTimeSvc.GetSortArray("篩選機");
            return Content(data.ToJson());
        }


       

        public ActionResult SortingIndex()
        {
            var Machine_List = _RealTimeSvc.GetSortList("篩選機");
            return View(Machine_List);
        }

        public ActionResult SortingIndex2()
        {
            var Machine_List = _RealTimeSvc.GetSortList("篩選機");
            return View(Machine_List);
        }
        [ChildActionOnly]
        public ActionResult RealTime_Sorting(string Machine_ID)
        {
            ViewBag.Machine_ID = Machine_ID;
            return View();
        }
        [ChildActionOnly]
        public ActionResult RealTime_Sorting2(string Machine_ID)
        {
            ViewBag.Machine_ID = Machine_ID;
            return View();
        }
        #region 抓取機台即時資訊
        public JsonResult GetSortingData(string Machine_ID)
        {
            SortingMachine_DataViewModel query = new SortingMachine_DataViewModel();
            try
            {
                query = _RealTimeSvc.GetSortingMachineData(Machine_ID);
            }
            catch (Exception)
            {
                query = _RealTimeSvc.GetSortingFailMsg();
            }
            return Json(query);
        }
        #endregion
    }


}
