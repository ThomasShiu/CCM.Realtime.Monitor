
using CCM.Web.Mobile.App_Start;
using Quartz;
using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace CCM.Web.Mobile
{
    public class MvcApplication : System.Web.HttpApplication
    {
        private IScheduler _schedular = null;

        /// <summary>
        /// 启动应用程序
        /// </summary>
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);

            //啟用壓縮
            //BundleTable.EnableOptimizations = true;
            //BundleConfig.RegisterBundles(BundleTable.Bundles);

            
        }

        protected void Application_End(object sender, EventArgs e)
        {
            //_schedular.Shutdown(false);
        }
    }
}