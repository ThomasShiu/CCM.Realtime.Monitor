/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using Microsoft.Reporting.WebForms;
using System;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Mvc;

/// <summary>
/// 發文管理
/// </summary>
/// <remarks>
/// 紀錄發佈公文，可附加檔案
/// </remarks>
namespace CCM.Web.EIP.Areas.Document.Controllers
{
    
    public class DOC01Controller : ControllerBase
    {
        private FR_OFFIDOC_ISSUEApp tableApp = new FR_OFFIDOC_ISSUEApp();
        private FR_OFFIDOC_ISSUE_ATTACH_FILEApp tableFileApp = new FR_OFFIDOC_ISSUE_ATTACH_FILEApp();
        private FR_OFFIDOC_ISSUE_ATTACH_FILEEntity tableEntity = new FR_OFFIDOC_ISSUE_ATTACH_FILEEntity();

        private CcmServices cs = new CcmServices();
        private ReportService rs = new ReportService();

        [HttpGet]
        [HandlerAjaxOnly]
        //public ActionResult GetGridJson(string keyword)
        //{
        //    var data = tableApp.GetList(keyword);
        //    return Content(data.ToJson());
        //}
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
        public ActionResult SubmitForm(FR_OFFIDOC_ISSUEEntity FR_OFFIDOC_ISSUEEntity, string keyValue)
        {
            tableApp.SubmitForm(FR_OFFIDOC_ISSUEEntity, keyValue);
            return Success("操作成功。");
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

        #region 批次上傳檔案
        [HttpPost]
        [HandlerAjaxOnly]
        //[ValidateAntiForgeryToken]
        //[HandlerAuthorize]
        public ActionResult BatchUpload(string guid)
        {
            //UploadItemViewModel vm = new UploadItemViewModel();
            //PU_ALBUMS pa = db.PU_ALBUMS.Find(id);
            //FR_OFFIDOC_ISSUE_ATTACH_FILEEntity tableEntity = new FR_OFFIDOC_ISSUE_ATTACH_FILEEntity();

            bool isSavedSuccessfully = true;
            int count = 0;
            string msg = "";

            string fileName = "";
            string fileExtension = "";
            string filePath = "";
            string fileNewName = "";

            //这里是获取隐藏域中的数据
            //int albumId = string.IsNullOrEmpty(Request.Params["hidAlbumId"]) ?
            //    0 : int.Parse(Request.Params["hidAlbumId"]);

            try
            {
                string directoryPath = Server.MapPath("~/EIPContent/Content/FilesCabinet/UploadFiles/");
                if (!Directory.Exists(directoryPath))
                    Directory.CreateDirectory(directoryPath);

                foreach (string f in Request.Files)
                {
                    HttpPostedFileBase file = Request.Files[f];

                    if (file != null && file.ContentLength > 0)
                    {
                        fileName = file.FileName;
                        fileExtension = Path.GetExtension(fileName);
                        fileNewName = CommonCCm.GuId() + fileExtension;
                        filePath = Path.Combine(directoryPath, fileNewName);
                        file.SaveAs(filePath);

                        count++;

                        //存放檔案路徑
                        tableEntity.SID= CommonCCm.GuId(); 
                        tableEntity.ParentISSUEID = guid;
                        tableEntity.Name = fileName;
                        tableEntity.UploadPath = "EIPContent/Content/FilesCabinet/UploadFiles/" + fileNewName; //圖檔路徑
                        tableFileApp.SubmitForm(tableEntity, null);
                    }
                }
                msg = "success";
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                isSavedSuccessfully = false;
            }

            return Json(new
            {
                Result = isSavedSuccessfully,
                Count = count,
                Message = msg
            });
        }
        #endregion

        #region  刪除檔案
        [HttpPost]
        [HandlerAjaxOnly]
        //[ValidateAntiForgeryToken]
        public ActionResult DeleteFile(string keyValue)
        {
            bool isSavedSuccessfully = true;
            int count = 0;
            string msg = "";

            var data = tableFileApp.GetForm(keyValue);

            //刪除主機端照片
            string fullPath = Server.MapPath("~/"+data.UploadPath.ToString());
            try
            {
                if (System.IO.File.Exists(fullPath))
                {
                    System.IO.File.Delete(fullPath);
                    count++;
                }
                //刪除資料庫資料列
                tableFileApp.DeleteForm(keyValue);
                msg = "success";
            }
            catch (Exception ex)
            {
                msg = ex.Message;
                isSavedSuccessfully = false;
            }

            return Json(new
            {
                Result = isSavedSuccessfully,
                Count = count,
                Message = msg
            });
        }
        #endregion

        #region 發文報表列印
        [HttpGet]
        [HandlerAuthorize]
        public ActionResult Print(string keyValue, string type = "PDF")
        {
            var path = Server.MapPath("~/Reports/DOC01_R01.rdlc");
            LocalReport localReport = rs.DOC01_R01(keyValue, type, path);

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
                    "<PageWidth>8.2in</PageWidth>" +
                    "<PageHeight>11.6in</PageHeight>";
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

        #region 寄送報表
        public ActionResult mailReport(string keyValue)
        {
            string filename = Server.MapPath("~/Reports/DOC01_R01.rdlc");
            cs.mailReport(keyValue, filename);
            return Success("寄送完成。");
        }
        #endregion
    }


}
