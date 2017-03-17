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
using System;
using System.Web.Mvc;

/// <summary>
/// 售服機台資料
/// </summary>
namespace CCM.Web.SRM.Areas.SaleService.Controllers
{
    public class SRM02Controller : ControllerBase
    {
        private V_SRVPRODMT_CCMApp tableApp = new V_SRVPRODMT_CCMApp();

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

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJson(string keyValue)
        {
            var data = tableApp.GetForm(keyValue);
            return Content(data.ToJson());
        }
       
    }


}
