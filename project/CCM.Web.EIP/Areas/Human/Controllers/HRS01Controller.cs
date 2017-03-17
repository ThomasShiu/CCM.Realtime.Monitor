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
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.Human.Controllers
{
    public class HRS01Controller : ControllerBase
    {
        private CCM_Main_EmployeeApp tableApp = new CCM_Main_EmployeeApp();

        [HttpGet]
        public virtual ActionResult Details2()
        {
            return View();
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJson(Pagination pagination, string queryJson)
        {
            var data = new
            {
                rows = tableApp.GetList(pagination, queryJson),
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

        //[HttpPost]
        //[HandlerAjaxOnly]
        //[ValidateAntiForgeryToken]
        //public ActionResult SubmitForm(CCM_Main_EmployeeEntity CCM_Main_EmployeeEntity, string keyValue)
        //{
        //    tableApp.SubmitForm(CCM_Main_EmployeeEntity, keyValue);
        //    return Success("操作成功。");
        //}

        //[HttpPost]
        //[HandlerAjaxOnly]
        //[HandlerAuthorize]
        //[ValidateAntiForgeryToken]
        //public ActionResult DeleteForm(string keyValue)
        //{
        //    tableApp.DeleteForm(keyValue);
        //    return Success("删除成功。");
        //}

        #region 單張上傳照片
        /// <summary>
        /// 上傳單一照片
        /// </summary>
        /// <param name="vm"></param>
        /// <param name="myFile"></param>
        [HttpPost]
        public ActionResult UploadFiles()
        {
            string fname = "";
            string vfilename = CommonCCm.GuId();
            bool isSavedSuccessfully = true;
            int count = 0;
            string msg = "";

            // Checking no of files injected in Request object  
            if (Request.Files.Count > 0)
            {
                try
                {
                    //  Get all files from Request object  
                    HttpFileCollectionBase files = Request.Files;
                    for (int i = 0; i < files.Count; i++)
                    {
                        //string path = AppDomain.CurrentDomain.BaseDirectory + "Uploads/";  
                        //string filename = Path.GetFileName(Request.Files[i].FileName);  

                        HttpPostedFileBase file = files[i];

                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            fname = testfiles[testfiles.Length - 1];
                           //vfilename = Path.GetExtension(file.FileName);
                        }
                        else
                        {
                            //fname = file.FileName;
                            //vfilename = Path.GetExtension(file.FileName);
                            vfilename = file.FileName; ;
                        }

                        // Get the complete folder path and store the file inside it.  
                        fname = Path.Combine(Server.MapPath("~/EIPContent/Content/PublicShare/Family/"), vfilename);
                        file.SaveAs(fname);

                        vfilename = "EIPContent/Content/PublicShare/Family/" + vfilename;
                        count++;
                    }
                    // Returns message that successfully uploaded  
                    //return Json("File Uploaded Successfully!");
                    msg = "success";

                }
                catch (Exception ex)
                {
                    msg = ex.Message;
                    isSavedSuccessfully = false;
                }
            }
            else
            {
                msg = "請選擇要上傳的檔案!";
                isSavedSuccessfully = false;
                //return Json("No files selected.");
            }

            return Json(new
            {
                Result = isSavedSuccessfully,
                Count = count,
                Message = msg,
                FileUrl = vfilename
            });
        }
        #endregion
    }


}
