/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
 * Features:機台認證檔產生-研發單位管理使用
 * Table: HR_OVRTM
*********************************************************************************/
using CCM.Application;
using CCM.Application._02_Services;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.RDM.Areas.RDManage.Controllers
{
    public class RDM00Controller : Controller
    {
        private RD_MACHINEAUTHApp tableApp = new RD_MACHINEAUTHApp();
        private RDService rs = new RDService();

        #region 取得ERP客戶清單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCustList()
        {
            var result = rs.GetCustList();
            return Content(result.ToJson());
        }
        #endregion

        #region 取得品號清單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetITEM(string company="")
        {
            var result = rs.GetITEMList(company);
            return Content(result.ToJson());
        }
        #endregion

        #region 取得料件基本資料
        //[HttpGet]
        //[HandlerAjaxOnly]
        //public ActionResult GetITEMDdata(string company)
        //{
        //    var result = rs.GetITEMList(company);
        //    return Content(result.ToJson());
        //}
        #endregion

        #region 取得售服機台資料
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetSRVPRODdata(string keyValue)
        {
            var result = rs.GetSRVPRODList(keyValue);
            return Content(result.ToJson());
        }
        #endregion

        #region 取得客戶資料
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCSNAME(string keyValue)
        {
            var result = rs.GetCSNAME(keyValue);
            return Content(result.ToJson());
        }
        #endregion

    }


}
