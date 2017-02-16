
using CCM.Web.SRM.App_Start;
using Quartz;
using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace CCM.Web.SRM
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

            // 建立簡單的、以 RAM 為儲存體的排程器
            var schedulerFactory = new Quartz.Impl.StdSchedulerFactory();
            _schedular = schedulerFactory.GetScheduler();

            // 建立工作
            IJobDetail job = JobBuilder.Create<SendMailTask>().WithIdentity("SendMailJob").Build();

            // 建立觸發器
            // 代表意義	    分鐘	  小時	    日期	  月份	     週	   指令
            // 數字範圍    0 - 59    0 - 23    1 - 31    1 - 12    0 - 7   Common
            ITrigger trigger = TriggerBuilder.Create()
              .WithCronSchedule("0 0/1 * * * ?")  // 每一分鐘觸發一次。
              .WithIdentity("SendMailTrigger")
              .Build();

            // 把工作加入排程
            _schedular.ScheduleJob(job, trigger);

            // 啟動排程器
            _schedular.Start();
        }

        protected void Application_End(object sender, EventArgs e)
        {
            _schedular.Shutdown(false);
        }
    }
}