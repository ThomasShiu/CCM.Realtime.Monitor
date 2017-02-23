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
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.SRM.Areas.SaleService.Controllers
{
    public class SRM01Controller : ControllerBase
    {
        private SRM_ALBUMMTApp tableApp = new SRM_ALBUMMTApp();
        private SRM_ALBUMDLApp tableFileApp = new SRM_ALBUMDLApp();
        private SRM_ALBUMDLEntity tableFileEntity = new SRM_ALBUMDLEntity();
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
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(SRM_ALBUMMTEntity SRM_ALBUMMTEntity, string keyValue)
        {
            tableApp.SubmitForm(SRM_ALBUMMTEntity, keyValue);
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

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJsonUpload(string keyword)
        {
            //var data = tableApp.GetList(keyword); 
            var data = new
            {
                current = 1,
                rowCount = 1000,
                rows = tableFileApp.GetList(keyword),
                total = tableFileApp.GetList(keyword).Count
            };
            return Content(data.ToJson());
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJsonUpload2(string keyword)
        {
            var result = tableFileApp.GetList(keyword);
            var data = new
            {
                ImgList = result
            };
            return Content(data.ToJson());
        }

        #region 批次上傳檔案
        [HttpPost]
        [HandlerAjaxOnly]
        //[ValidateAntiForgeryToken]
        //[HandlerAuthorize]
        public ActionResult BatchUpload(string guid)
        {
            string fileName = "";
            string fileExtension = "";
            string filePath = "", fileNewPath = "";
            string fileNewName = "";

            //UploadItemViewModel vm = new UploadItemViewModel();
            //PU_ALBUMS pa = db.PU_ALBUMS.Find(id);
            //FR_OFFIDOC_ISSUE_ATTACH_FILEEntity tableEntity = new FR_OFFIDOC_ISSUE_ATTACH_FILEEntity();
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            bool isSavedSuccessfully = true;
            int count = 0;
            string msg = "";

            //這裡是獲取隱藏域中的資料
            //int albumId = string.IsNullOrEmpty(Request.Params["hidAlbumId"]) ?
            //    0 : int.Parse(Request.Params["hidAlbumId"]);

            try
            {
                string directoryPath = Server.MapPath("~/EIPContent/Content/PublicShare/VibrationPlate/");
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
                        //file.SaveAs(filePath);
                        int savefile = cs.ImgUploadResize(file, directoryPath, fileNewName);
                        count+= savefile;

                        //存放檔案路徑
                        tableFileEntity.SID = CommonCCm.GuId();
                        tableFileEntity.parentId = guid;
                        tableFileEntity.FileName = fileName;
                        tableFileEntity.Size = file.ContentLength;
                        tableFileEntity.ImgPath = "EIPContent/Content/PublicShare/VibrationPlate/" + fileNewName; //圖檔路徑
                        tableFileEntity.OrganizeId = "CCM";
                        tableFileEntity.CreatorTime = DateTime.Now;
                        tableFileEntity.CreatorUserId = LoginInfo.UserCode;
                        tableFileApp.SubmitForm(tableFileEntity, null);
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
            string fullPath = Server.MapPath("~/" + data.ImgPath.ToString());
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
