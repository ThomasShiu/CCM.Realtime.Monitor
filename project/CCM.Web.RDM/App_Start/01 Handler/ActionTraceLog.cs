using CCM.Application.SystemSecurity;
using CCM.Code;
using CCM.Domain.Entity.SystemSecurity;
using System;
using System.Web.Mvc;

namespace CCM.Web.RDM.App_Start._01_Handler
{
    public class ActionTraceLog : ActionFilterAttribute
    {

        ActionLogApp app = new ActionLogApp();

        public override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (filterContext.HttpContext.Request.UrlReferrer == null)
                return;

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
            base.OnActionExecuting(filterContext);
        }
        public override void OnActionExecuted(ActionExecutedContext filterContext)
        {
            base.OnActionExecuted(filterContext);
        }

        public override void OnResultExecuting(ResultExecutingContext filterContext)
        {
            base.OnResultExecuting(filterContext);
        }

        public override void OnResultExecuted(ResultExecutedContext filterContext)
        {
            base.OnResultExecuted(filterContext);
        }
    }
}