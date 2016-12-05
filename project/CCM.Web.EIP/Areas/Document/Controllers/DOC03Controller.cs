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
using CCM.Web.EIP.App_Start;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.Document.Controllers
{
    public class DOC03Controller : ControllerBase
    {
        private FR_OFFIDOC_RECEApp tableApp = new FR_OFFIDOC_RECEApp();
        private FR_OFFIDOC_RECE_ATTACH_FILEApp tableFileApp = new FR_OFFIDOC_RECE_ATTACH_FILEApp();
        private FR_OFFIDOC_RECE_ATTACH_FILEEntity tableEntity = new FR_OFFIDOC_RECE_ATTACH_FILEEntity();

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
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(FR_OFFIDOC_RECEEntity FR_OFFIDOC_RECEEntity, string keyValue)
        {
            tableApp.SubmitForm(FR_OFFIDOC_RECEEntity, keyValue);
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
                        fileNewName = Common.GuId() + fileExtension;
                        filePath = Path.Combine(directoryPath, fileNewName);
                        file.SaveAs(filePath);

                        count++;

                        //存放檔案路徑
                        tableEntity.SID = Common.GuId();
                        tableEntity.ParentRECEIVEID = guid;
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
            string fullPath = Server.MapPath("~/" + data.UploadPath.ToString());
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
    }


}
