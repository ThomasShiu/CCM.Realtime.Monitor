/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Application._02_Services;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using System;
using System.Web.Mvc;

/// <summary>
/// 售服機台資料-大陸地區
/// </summary>
namespace CCM.Web.SRM.Areas.SaleService.Controllers
{
    public class SRM03Controller : ControllerBase
    {
        //private V_SRVPRODMT_CCMApp tableAppCcm = new V_SRVPRODMT_CCMApp();
        private V_SRVPRODMT_KSCApp tableAppKsc = new V_SRVPRODMT_KSCApp();
        private V_SRVPRODMT_NGBApp tableAppNgb = new V_SRVPRODMT_NGBApp();
        private V_SRVPRODMT_DACApp tableAppDac = new V_SRVPRODMT_DACApp();
        private SRMService ss = new SRMService();


        [HttpGet]
        public virtual ActionResult Details2()
        {
            return View();
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJson(Pagination pagination, string keyword)
        {

            var data = new
            {
                rows = tableAppKsc.GetList(pagination, keyword),
                total = pagination.total,
                page = pagination.page,
                records = pagination.records
            };

            return Content(data.ToJson());


        }

        public ActionResult GetGridJson(string keyword)
        {
            var data = tableAppKsc.GetList(keyword);
            return Content(data.ToJson());
        }

        //[HttpGet]
        //[HandlerAjaxOnly]
        //public ActionResult GetFormJsonCCM(string keyValue)
        //{
        //    var data = tableAppKsc.GetForm(keyValue);
        //    return Content(data.ToJson());
        //}

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJsonKSC(string keyValue)
        {
            var data = tableAppKsc.GetForm(keyValue);
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJsonNGB(string keyValue)
        {
            var data = tableAppNgb.GetForm(keyValue);
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetFormJsonDAC(string keyValue)
        {
            var data = tableAppDac.GetForm(keyValue);
            return Content(data.ToJson());
        }

        #region 售服機台資料明細
        //[HttpGet]
        //[HandlerAjaxOnly]
        //public ActionResult getSRVPRODDLListCCM(string keyValue)
        //{
        //    var rows = ss.getSRVPRODDLList(keyValue, "CCM");
        //    var data = new
        //    {
        //        current = 1,
        //        rowCount = 10,
        //        rows = rows,
        //        total = rows.Count
        //    };
        //    return Content(data.ToJson());
        //}

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult getSRVPRODDLListKSC(string keyValue)
        {
            var rows = ss.getSRVPRODDLList(keyValue, "KSC");
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = rows,
                total = rows.Count
            };
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult getSRVPRODDLListNGB(string keyValue)
        {
            var rows = ss.getSRVPRODDLList(keyValue, "NGB");
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = rows,
                total = rows.Count
            };
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult getSRVPRODDLListDAC(string keyValue)
        {
            var rows = ss.getSRVPRODDLList(keyValue, "DAC");
            var data = new
            {
                current = 1,
                rowCount = 10,
                rows = rows,
                total = rows.Count
            };
            return Content(data.ToJson());
        }
        #endregion
    }


}
