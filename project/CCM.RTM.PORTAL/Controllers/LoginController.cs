/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Domain.Entity.SystemSecurity;
using CCM.Application.SystemSecurity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CCM.Domain.Entity.SystemManage;
using CCM.Application.SystemManage;
using CCM.Code;
using CCM.Application;

namespace CCM.RTM.PORTAL.Controllers
{
    public class LoginController : Controller
    {
        //private StoreProcedure sp = new StoreProcedure();
       // private CcmServices cs = new CcmServices();

        [HttpGet]
        public virtual ActionResult Index()
        {
            var test = string.Format("{0:E2}", 1);
            return View();
        }
        [HttpGet]
        public ActionResult GetAuthCode()
        {
            return File(new VerifyCode().GetVerifyCode(), @"image/Gif");
        }
        [HttpGet]
        public ActionResult OutLogin()
        {
            new LogApp().WriteDbLog(new LogEntity
            {
                F_ModuleName = "系統登入",
                F_Type = DbLogType.Exit.ToString(),
                F_Account = OperatorProvider.Provider.GetCurrent().UserCode,
                F_NickName = OperatorProvider.Provider.GetCurrent().UserName,
                F_Result = true,
                F_Description = "安全退出系統",
            });
            Session.Abandon();
            Session.Clear();
            OperatorProvider.Provider.RemoveCurrent();
            return RedirectToAction("Index", "Login");
        }
        [HttpPost]
        [HandlerAjaxOnly]
        public ActionResult CheckLogin(string username, string password, string code)
        {
            LogEntity logEntity = new LogEntity();
            logEntity.F_ModuleName = "系統登入";
            logEntity.F_Type = DbLogType.Login.ToString();
            try
            {
                if (Session["ccm_session_verifycode"].IsEmpty() || Md5.md5(code.ToLower(), 16) != Session["ccm_session_verifycode"].ToString())
                {
                    throw new Exception("驗證碼錯誤，請重新輸入");
                }

                UserEntity userEntity = new UserApp().CheckLogin(username, password);
                
                if (userEntity != null)
                {
                    UserLogOnEntity userLogOnEntity = new UserLogOnApp().GetForm(userEntity.F_Id);

                    OperatorModel operatorModel = new OperatorModel();
                    operatorModel.UserId = userEntity.F_Id;
                    operatorModel.UserCode = userEntity.F_Account;
                    operatorModel.UserName = userEntity.F_RealName;
                    operatorModel.CompanyId = userEntity.F_OrganizeId;
                    operatorModel.DepartmentId = userEntity.F_DepartmentId;
                    operatorModel.DeptId = "";
                    operatorModel.DeptName = "";
                    operatorModel.RoleId = userEntity.F_RoleId;
                    operatorModel.LoginIPAddress = Net.Ip;
                    operatorModel.LoginIPAddressName = Net.GetLocation(operatorModel.LoginIPAddress);
                    operatorModel.LoginTime = DateTime.Now;
                    operatorModel.LoginToken = DESEncrypt.Encrypt(Guid.NewGuid().ToString());
                    operatorModel.Language = userLogOnEntity.F_Language;
                    operatorModel.Theme = userLogOnEntity.F_Theme;
                    //operatorModel.IsSystem = true;

                    if (userEntity.F_Account == "admin")
                    {
                        operatorModel.IsSystem = true;
                    }
                    else
                    {
                        operatorModel.IsSystem = false;
                    }

                    OperatorProvider.Provider.AddCurrent(operatorModel);
                    logEntity.F_Account = userEntity.F_Account;
                    logEntity.F_NickName = userEntity.F_RealName;
                    logEntity.F_Result = true;
                    logEntity.F_Description = "登入成功";
                    new LogApp().WriteDbLog(logEntity);
                }
                return Content(new AjaxResult { state = ResultType.success.ToString(), message = "登入成功。" }.ToJson());
            }
            catch (Exception ex)
            {
                logEntity.F_Account = username;
                logEntity.F_NickName = username;
                logEntity.F_Result = false;
                logEntity.F_Description = "登入失敗，" + ex.Message;
                new LogApp().WriteDbLog(logEntity);
                return Content(new AjaxResult { state = ResultType.error.ToString(), message = ex.Message }.ToJson());
            }
        }

        [HttpPost]
        [HandlerAjaxOnly]
        public ActionResult ChangePW(string username, string password)
        {
            try
            {
                UserEntity userEntity = new UserApp().CheckLogin(username, password);

                if (userEntity != null)
                {
                    UserLogOnEntity userLogOnEntity = new UserLogOnApp().GetForm(userEntity.F_Id);

                    userLogOnEntity.F_UserPassword = "";

                }
                return Content(new AjaxResult { state = ResultType.success.ToString(), message = "登入成功。" }.ToJson());
            }
            catch (Exception ex)
            {
                return Content(new AjaxResult { state = ResultType.error.ToString(), message = ex.Message }.ToJson());
            }
        }
    }
}

