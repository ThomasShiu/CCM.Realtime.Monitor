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

        #region 取得機台清單
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetSrvProd()
        {
            var result = rs.GetSRVPRODList();
            return Content(result.ToJson());
        }
        #endregion

    }


}
