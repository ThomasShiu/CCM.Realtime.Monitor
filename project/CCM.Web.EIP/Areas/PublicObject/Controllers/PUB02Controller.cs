/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Web.EIP.App_Start;
using CCM.Web.EIP.App_Start._01_Handler;
using Microsoft.Reporting.WebForms;
using System.Data;
using System.Web.Mvc;

//公務車預約
namespace CCM.Web.EIP.Areas.PublicObject.Controllers
{
    public class PUB02Controller : ControllerBase
    {
        private PO_PUBLIC_OBJECT_BOOKINGApp tableApp = new PO_PUBLIC_OBJECT_BOOKINGApp();
        private CcmServices cs = new CcmServices();
        private ReportService rs = new ReportService();

        [HttpGet]
        [ActionTraceLog]
        public ActionResult IndexPub()
        {
            return View();
        }

        #region 警衛專用畫面
        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public  ActionResult Form2()
        {
            return View();
        }
        #endregion

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCarGridJson(Pagination pagination, string queryJson)
        {
            var data = new
            {
                rows = tableApp.GetList_BookingCar(pagination, queryJson),
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

        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm( PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(tableEntity.Status) )
            {
                if (string.IsNullOrEmpty(tableEntity.CreatorUserId) | 
                    (!OperatorProvider.Provider.GetCurrent().UserCode.Equals("admin") &
                     !OperatorProvider.Provider.GetCurrent().UserCode.Equals("B051013") & // 吳嘉容
                     !OperatorProvider.Provider.GetCurrent().UserCode.Equals("B030306") & // 林玫儒
                     !OperatorProvider.Provider.GetCurrent().UserCode.Equals("B050502") &
                     !OperatorProvider.Provider.GetCurrent().UserCode.Equals(tableEntity.CreatorUserId)  ))
                {
                    if (tableEntity.Status.Contains("鎖定") | tableEntity.Status.Contains("取消"))
                    {
                        return Error("狀態:[鎖定]or[取消]，不可修改。");
                    }
                }
            }
            if (string.IsNullOrEmpty(keyValue)) //新建模式才判斷時段是否重複
            {
                // 判斷該時段是否已有預約
                string v_message = cs.chkPubObjExistBooking(tableEntity);
                if (!string.IsNullOrEmpty(v_message))
                {
                    return Error(v_message);
                }
            }
            // 判斷起始時間不可大於結束時間
            if (tableEntity.BookingStartTime < tableEntity.BookingEndTime) {
                tableApp.SubmitForm(tableEntity, keyValue);
                return Success("操作成功。");
            }else
            {
                return Error("使用時間:<br/>["+ tableEntity.BookingStartTime.ToString("yyyy-MM-dd HH:mm") + "] 至["+ tableEntity.BookingEndTime.ToString("yyyy-MM-dd HH:mm") + "] <br/>結束時間不可等於或早於開始時間，請重新調整時間再存檔。");
            }
        }

       
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm2(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity, string keyValue)
        {

            if ((string.IsNullOrEmpty(tableEntity.MileageLast.ToString()) | tableEntity.MileageLast == 0) |
                (string.IsNullOrEmpty(tableEntity.Mileage.ToString()) | tableEntity.Mileage == 0))
            {
                return Error("回廠里程或出廠里程不能為空白或是0");
            }
            else
            {
                if (tableEntity.Mileage > 0) { tableEntity.Status = "結束"; }
                tableApp.SubmitForm(tableEntity, keyValue);
                return Success("操作成功。");
            }
         
        }

        [HttpPost]
        [HandlerAjaxOnly]
        [HandlerAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteForm(string keyValue)
        {
            tableApp.DeleteForm(keyValue);
            return Success("删除成功。");
        }

        #region 公務車每日外出人員報表列印
        [HttpGet]
        [HandlerAuthorize]
        public ActionResult Print(string keyValue, string type = "PDF")
        {

            var path = Server.MapPath("~/Reports/PUB02_R01.rdlc");
            LocalReport localReport = rs.PUB01_R01(keyValue,type,path);

            string paper = "A4";
            string reportType = type;
            string mimeType;
            string encoding;
            string fileNameExtension;

            string deviceInfo =
                "<DeviceInfo>" +
                "<OutPutFormat>" + type + "</OutPutFormat>";
            switch (paper)
            {
                case "Letter":// 中一刀
                    deviceInfo +=
                    "<PageWidth>9in</PageWidth>" +
                    "<PageHeight>6in</PageHeight>";
                    break;
                case "A4":// A4
                    deviceInfo +=
                    "<PageWidth>11.6in</PageWidth>" +
                    "<PageHeight>8.2in</PageHeight>";
                    break;
            }
            deviceInfo +=
                "<MarginTop>0.2in</MarginTop>" +
                "<MarginLeft>0.2in</MarginLeft>" +
                "<MarginRight>0.2in</MarginRight>" +
                "<MarginBottom>0.2in</MarginBottom>" +
                "</DeviceInfo>";

            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;
            

            renderedBytes = localReport.Render(
                reportType,
                deviceInfo,
                out mimeType,
                        out encoding,
                        out fileNameExtension,
                        out streams,
                        out warnings
                        );
            return File(renderedBytes, mimeType);

        }
        #endregion

        #region 公務車每月統計表列印
        [HttpGet]
        [HandlerAuthorize]
        public ActionResult Print2(string keyValue, string type = "PDF")
        {
            var path = Server.MapPath("~/Reports/PUB02_R02.rdlc");
            LocalReport localReport = rs.PUB01_R02(keyValue, type, path);

            string paper = "A4";
            string reportType = type;
            string mimeType;
            string encoding;
            string fileNameExtension;

            string deviceInfo =
                "<DeviceInfo>" +
                "<OutPutFormat>" + type + "</OutPutFormat>";
            switch (paper)
            {
                case "Letter":// 中一刀
                    deviceInfo +=
                    "<PageWidth>9in</PageWidth>" +
                    "<PageHeight>6in</PageHeight>";
                    break;
                case "A4":// A4
                    deviceInfo +=
                    "<PageWidth>11.6in</PageWidth>" +
                    "<PageHeight>8.2in</PageHeight>";
                    break;
            }
            deviceInfo +=
                "<MarginTop>0.2in</MarginTop>" +
                "<MarginLeft>0.2in</MarginLeft>" +
                "<MarginRight>0.2in</MarginRight>" +
                "<MarginBottom>0.2in</MarginBottom>" +
                "</DeviceInfo>";

            Warning[] warnings;
            string[] streams;
            byte[] renderedBytes;

            renderedBytes = localReport.Render(
                reportType,
                deviceInfo,
                out mimeType,
                        out encoding,
                        out fileNameExtension,
                        out streams,
                        out warnings
                        );
            return File(renderedBytes, mimeType);

        }
        #endregion
    }


}
