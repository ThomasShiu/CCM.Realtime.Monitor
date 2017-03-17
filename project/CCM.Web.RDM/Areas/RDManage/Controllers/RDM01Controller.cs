/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
 * Features:機台認證檔產生-一般申請認證使用
 * Table: HR_OVRTM
*********************************************************************************/
using CCM.Application;
using CCM.Application._02_Services;
using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Web.RDM.App_Start._01_Handler;
using Newtonsoft.Json.Linq;
using System;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.RDM.Areas.RDManage.Controllers
{
    public class RDM01Controller : ControllerBase
    {
        private RD_MACHINEAUTHApp tableApp = new RD_MACHINEAUTHApp();
        private RDService rs = new RDService();

        [HttpGet]
        [HandlerAuthorize]
        [ActionTraceLog]
        public virtual ActionResult Form2()
        {
            return View();
        }

        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetGridJson(Pagination pagination, string keyword)
        {
            var data = new
            {
                rows = tableApp.GetListEnable(pagination, keyword),
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

        #region 送出資料
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm(RD_MACHINEAUTHEntity entity, string keyValue)
        {
            tableApp.SubmitForm(entity, keyValue);
            return Success("操作成功。");
        }
        #endregion

        #region 送出資料-含上傳檔案
        [HttpPost]
        [HandlerAjaxOnly]
        [ValidateAntiForgeryToken]
        public ActionResult SubmitForm2(RD_MACHINEAUTHEntity entity, string keyValue,string newold)
        {
            // 取出temp檔資訊
            MHDI.IAuthorized m_IAU = new MHDI.PSP();
            string exactPath = Server.MapPath("~/" + entity.UploadPath).Replace("RDManage\\RDM01\\", "");
            //exactPath = exactPath.Replace("RDManage\\RDM01\\","");
            var DeviceInfo = "";
            var Version = m_IAU.GetVersion();
            var vFilename = Path.GetFileNameWithoutExtension(exactPath);
            var vPath = Path.GetDirectoryName(exactPath);

            // 產生存檔路徑
            var TransPath = vPath + Path.DirectorySeparatorChar + vFilename + Path.DirectorySeparatorChar;
            if (!Directory.Exists(TransPath))
            {
                Directory.CreateDirectory(TransPath);
            }

            if (newold == "new")
            {
                // 截取DLL內的機台資訊
                DeviceInfo = m_IAU.GetDeviceInfo(exactPath, "CCM");
                // 產生認証檔(新版)
                var transNew = m_IAU.Transform(exactPath, TransPath, 1, "CCM");
                entity.DownloadPath = "EIPContent/Content/PublicObject/MachineAuth/" + vFilename + "/CCM.dll";
            }
            else {
                // 截取DLL內的機台資訊
                DeviceInfo = m_IAU.GetDeviceInfo(exactPath, "");
                // 產生認証檔(舊版)
                var transOld = m_IAU.Transform(exactPath, TransPath, 1, "");
                entity.DownloadPath = "EIPContent/Content/PublicObject/MachineAuth/" + vFilename + "/CCM.dll";
            }
            JObject json = JObject.Parse(DeviceInfo);
            entity.Version = Version;
            entity.newFileName = Path.GetFileName(exactPath);
            entity.CPU_SN = json["CPU Serial Number"].ToString();
            entity.HD_SN = json["HD Serial Number"].ToString();
            entity.HD_Fireware = json["HD Firmware"].ToString();
            entity.HD_Moduleno = json["HD Module Number"].ToString();

            tableApp.SubmitForm(entity, keyValue);
            return Success("操作成功。");
        }
        #endregion

        [HttpPost]
        [HandlerAjaxOnly]
        [HandlerAuthorize]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteForm(string keyValue)
        {
            tableApp.DeleteForm(keyValue);
            return Success("删除成功。");
        }

       

        #region 單檔上傳
        [HttpPost]
        public ActionResult UploadFiles()
        {
            string fname = "", oldfilename="";
            string newfilename = Common.GuId();
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
                        oldfilename = Path.GetFileName(Request.Files[i].FileName);  

                        HttpPostedFileBase file = files[i];

                        // Checking for Internet Explorer  
                        if (Request.Browser.Browser.ToUpper() == "IE" || Request.Browser.Browser.ToUpper() == "INTERNETEXPLORER")
                        {
                            string[] testfiles = file.FileName.Split(new char[] { '\\' });
                            //vfilename = testfiles[testfiles.Length - 1];
                            newfilename += Path.GetExtension(file.FileName);
                        }
                        else
                        {
                            //vfilename = file.FileName;
                            newfilename += Path.GetExtension(file.FileName);
                        }

                        // Get the complete folder path and store the file inside it.  
                        fname = Path.Combine(Server.MapPath("~/EIPContent/Content/PublicObject/MachineAuth/"), newfilename);
                        file.SaveAs(fname);

                        newfilename = "EIPContent/Content/PublicObject/MachineAuth/" + newfilename;
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
                oldFileName = oldfilename,
                newFileName = newfilename
            });
        }
        #endregion
    }


}
