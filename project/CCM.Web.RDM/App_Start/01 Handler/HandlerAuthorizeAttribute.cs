using CCM.Application.SystemManage;
using CCM.Application.SystemSecurity;
using CCM.Code;
using CCM.Domain.Entity.SystemSecurity;
using System;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace CCM.Web.RDM
{
    /// <summary>
    /// 身分驗證
    /// </summary>
    public class HandlerAuthorizeAttribute : ActionFilterAttribute
    {
        public bool Ignore { get; set; }
        public HandlerAuthorizeAttribute(bool ignore = true)
        {
            Ignore = ignore;
        }
        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            ActionLogApp app = new ActionLogApp();
            var LoginInfo = OperatorProvider.Provider.GetCurrent(); // 登錄資訊
            ActionLogEntity NewLog = new ActionLogEntity()
            {
                Refer = filterContext.HttpContext.Request.UrlReferrer.AbsolutePath,
                Destination = filterContext.HttpContext.Request.Url.AbsolutePath,
                Method = filterContext.HttpContext.Request.HttpMethod,
                RequestTime = DateTime.Now,
                IPAddress = filterContext.HttpContext.Request.UserHostAddress,
                Operator = LoginInfo.UserCode,  // 工號
                Browser = filterContext.HttpContext.Request.Browser.Browser
            };
            app.SubmitForm(NewLog, "");

            //ActionLog(filterContext);
            // admin 系統用戶，不檢查
            if (OperatorProvider.Provider.GetCurrent().IsSystem)
            {
                return;
            }
            if (Ignore == false)
            {
                return;
            }
            if (!this.ActionAuthorize(filterContext))
            {
                StringBuilder sbScript = new StringBuilder();
                sbScript.Append("<script type='text/javascript'>alert('很抱歉！您的許可權不足，訪問被拒絕');</script>");
                filterContext.Result = new ContentResult() { Content = sbScript.ToString() };
                return;
            }
        }

       private void ActionLog(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Request.UrlReferrer == null)
                return;

            var LoginInfo = OperatorProvider.Provider.GetCurrent(); // 登陸資訊
            ActionLogEntity NewLog = new ActionLogEntity()
            {
                Refer = filterContext.HttpContext.Request.UrlReferrer.AbsolutePath,
                Destination = filterContext.HttpContext.Request.Url.AbsolutePath,
                Method = filterContext.HttpContext.Request.HttpMethod,
                RequestTime = DateTime.Now,
                IPAddress = filterContext.HttpContext.Request.UserHostAddress,
                Operator = LoginInfo.UserCode,  // 工號
                Browser = filterContext.HttpContext.Request.Browser.Browser
            };
            ActionLogApp app = new ActionLogApp();
            app.SubmitForm(NewLog, "");
        }

        private bool ActionAuthorize(ActionExecutingContext filterContext)
        {
            var operatorProvider = OperatorProvider.Provider.GetCurrent();
            var roleId = operatorProvider.RoleId;
            var moduleId = WebHelper.GetCookie("ccmrdm_currentmoduleid");
            var action = HttpContext.Current.Request.ServerVariables["SCRIPT_NAME"].ToString();
            return new RoleAuthorizeApp().ActionValidate(roleId, moduleId, action);
        }
    }
}