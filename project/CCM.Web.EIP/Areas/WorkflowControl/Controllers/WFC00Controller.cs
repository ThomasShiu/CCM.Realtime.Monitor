/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.WorkflowControl.Controllers
{
    public class WFC00Controller : ControllerBase
    {
        private WF_SIGNERApp tableApp = new WF_SIGNERApp();
        //private StoreProcedure sp = new StoreProcedure();
        private CcmServices cs = new CcmServices();

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

        #region 送簽
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult SendSign(string keyValue)
        {
            var data = cs.GenSign(keyValue);
            if (data == "success")
            {
                return Success("送簽成功。");
            }
            else
            {
                return Error("送簽失敗。");
            }
            //return Content(data.ToJson());
        }
        #endregion

        #region 撤簽
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult RejectSign(string keyValue, string act)
        {
            var data = cs.SetSign(keyValue, act);
            if (data == "success")
            {
                return Success("撤簽成功。");
            }
            else
            {
                return Error("撤簽失敗。");
            }
            //return Content(data.ToJson());
        }
        #endregion

        #region 簽核途程
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult getSignList(string keyValue)
        {
            var rows = cs.getSignList(keyValue);
            //rows = rows.Replace("\r\n", "").Replace(" ", "").Replace("\\", "\"").Trim();

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
