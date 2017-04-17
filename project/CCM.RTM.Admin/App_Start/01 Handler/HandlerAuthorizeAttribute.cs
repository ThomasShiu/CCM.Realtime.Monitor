using CCM.Application.SystemManage;
using CCM.Application.SystemSecurity;
using CCM.Code;
using CCM.Domain.Entity.SystemSecurity;
using System;
using System.Text;
using System.Web;
using System.Web.Mvc;

namespace CCM.RTM.Admin
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
                F_Refer = filterContext.HttpContext.Request.UrlReferrer.AbsolutePath,
                F_Destination = filterContext.HttpContext.Request.Url.AbsolutePath,
                F_Method = filterContext.HttpContext.Request.HttpMethod,
                F_RequestTime = DateTime.Now,
                F_IPAddress = filterContext.HttpContext.Request.UserHostAddress,
                F_Operator = LoginInfo.UserCode,  // 工號
                F_Browser = filterContext.HttpContext.Request.Browser.Browser
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
                sbScript.Append("<script type='text/javascript'>alert('很抱歉！您的許可權不足，訪問被拒絕！');</script>");
                filterContext.Result = new ContentResult() { Content = sbScript.ToString() };
                return;
            }
        }
        private bool ActionAuthorize(ActionExecutingContext filterContext)
        {
            var operatorProvider = OperatorProvider.Provider.GetCurrent();
            var roleId = operatorProvider.RoleId;
            var moduleId = WebHelper.GetCookie("rtmadmin_currentmoduleid");
            var action = HttpContext.Current.Request.ServerVariables["SCRIPT_NAME"].ToString();
            return new RoleAuthorizeApp().ActionValidate(roleId, moduleId, action);
        }
    }
}
