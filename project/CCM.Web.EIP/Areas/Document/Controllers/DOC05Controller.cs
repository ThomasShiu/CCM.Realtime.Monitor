/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using CCM.Domain;
using CCM.Web.EIP.App_Start._01_Handler;
using CCM.Web.EIP.Areas.Document.Models;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Web;
using System.Web.Mvc;

//todo: 請修改對應的namespace
namespace CCM.Web.EIP.Areas.Document.Controllers
{

    public class DOC05Controller : ControllerBase
    {
        private FR_OFFIDOC_ISSUEApp tableApp = new FR_OFFIDOC_ISSUEApp();
        private FR_OFFIDOC_ISSUE_ATTACH_FILEApp tableFileApp = new FR_OFFIDOC_ISSUE_ATTACH_FILEApp();
        private FR_OFFIDOC_ISSUE_ATTACH_FILEEntity tableEntity = new FR_OFFIDOC_ISSUE_ATTACH_FILEEntity();

        private CcmServices cs = new CcmServices();
        private ReportService rs = new ReportService();

        [HttpGet]
        [ActionTraceLog]
        public virtual ActionResult Index2()
        {
            return View();
        }


        [HttpPost]
        public virtual ActionResult GetFiles2(string dir, bool onlyFolders, bool onlyFiles, string rootFolders) //引数"rootFolders"を追加
        {
            // 受け取ったフォルダパスをURLデコードのみして、そのまま使う。
            string realDir = Server.UrlDecode(dir).Replace("/", "\\");

            List<FileTreeViewModel> files = new List<FileTreeViewModel>();

            DirectoryInfo di = new DirectoryInfo(realDir);

            // 【今回追加した部分】表示するフォルダがルートフォルダの時には、配下の情報を返さず、ルートフォルダの情報のみ返す
            if (realDir == rootFolders)
            {
                files.Add(new FileTreeViewModel() { Name = di.Name, Path = String.Format("{0}\\", realDir), IsDirectory = true });
                return PartialView(files);
            }


            if (!onlyFiles)
            {
                foreach (DirectoryInfo dc in di.GetDirectories())
                {
                    files.Add(new FileTreeViewModel() { Name = dc.Name, Path = String.Format("{0}\\{1}\\", realDir, dc.Name), IsDirectory = true });
                    //↑【注意】{0}と{1}の間に"\\"を入れておきます。
                }
            }

            if (!onlyFolders)
            {
                foreach (FileInfo fi in di.GetFiles())
                {
                    files.Add(new FileTreeViewModel() { Name = fi.Name, Ext = fi.Extension.Substring(1).ToLower(), Path = realDir + fi.Name, IsDirectory = false });
                }
            }

            return PartialView(files);
        }

        [HttpPost]
        public virtual ActionResult GetFiles(string dir)
        {
            // 基底フォルダ＋相対パスでアクセス先を設定する元々のプログラムはコメントアウト。
            //const string baseDir = @"/App_Data/userfiles/";

            //dir = Server.UrlDecode(dir);
            //string realDir = Server.MapPath(baseDir + dir);

            ////validate to not go above basedir
            //if (!realDir.StartsWith(Server.MapPath(baseDir)))
            //{
            //    realDir = Server.MapPath(baseDir);
            //    dir = "/";
            //}


            string realDir = Server.UrlDecode(dir).Replace("/", "\\");

            List<FileTreeViewModel> files = new List<FileTreeViewModel>();

            DirectoryInfo di = new DirectoryInfo(realDir);

            foreach (DirectoryInfo dc in di.GetDirectories())
            {
                files.Add(new FileTreeViewModel() { Name = dc.Name, Path = String.Format("{0}\\{1}\\", realDir, dc.Name), IsDirectory = true });
            }

            foreach (FileInfo fi in di.GetFiles())
            {
                files.Add(new FileTreeViewModel() { Name = fi.Name, Ext = fi.Extension.Substring(1).ToLower(), Path = realDir + fi.Name, IsDirectory = false });
            }

            return PartialView(files);
        }

      

    
    }


}
