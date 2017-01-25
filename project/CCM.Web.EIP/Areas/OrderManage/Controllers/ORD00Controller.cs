/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.OrderManage.Controllers
{
    // 特約廠商
    public class ORD00Controller : ControllerBase
    {
        private BU_ORDERS_SOTREApp tableApp = new BU_ORDERS_SOTREApp();
        private BU_ORDERS_SOTREApp storeApp = new BU_ORDERS_SOTREApp();
        private BU_ORDERS_MENUApp menuApp = new BU_ORDERS_MENUApp();
        private CcmServices cs = new CcmServices();
        [HttpGet]
        [HandlerAjaxOnly]
        // 特約廠商
        public ActionResult GetStoreJsonList()
        {
            var data = cs.GetVendorList();
            return Content(data.ToJson());
        }
        [HttpGet]
        [HandlerAjaxOnly]
        // 訂餐明細
        public ActionResult GetOrderDetailList(string keyword)
        {
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = cs.getOrderDetailList(keyword),
                total = cs.getOrderDetailList(keyword).Count
            };
            return Content(data.ToJson());

        }
        [HttpGet]
        [HandlerAjaxOnly]
        // 菜單 by 特約廠商
        public ActionResult GetMenuListPID(string keyValue)
        {
            var data = menuApp.GetListPID(keyValue);
            return Content(data.ToJson());

        }
        [HttpGet]
        [HandlerAjaxOnly]
        // 菜單 by SID
        public ActionResult GetMenuListSID(string keyValue)
        {
            var data = menuApp.GetListSID(keyValue);
            return Content(data.ToJson());

        }
    }


}
