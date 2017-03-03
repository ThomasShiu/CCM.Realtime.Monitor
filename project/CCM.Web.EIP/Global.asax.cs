
using CCM.Web.EIP.App_Start;
using Quartz;
using System;
using System.Web.Mvc;
using System.Web.Routing;

namespace CCM.Web.EIP
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
            IJobDetail job2 = JobBuilder.Create<ComputOrderTask>().WithIdentity("ComputOrderJob").Build();

            // 建立觸發器
            // 代表意義	    秒     分      時      周     月    年	       指令
            // 數字範圍    0-59   0-59    0-23    1-7    1-12    ? 2017   Common
            // 周 1=SUN 或 SUN，MON，TUE，WED，THU，FRI，SAT
            ITrigger trigger = TriggerBuilder.Create()
              .WithCronSchedule("0 30 7,16 * * ?")  // 每天七點半、下午四點半執行。
              .WithIdentity("SendMailTrigger")
              .Build();

            ITrigger trigger2 = TriggerBuilder.Create()
              .WithCronSchedule("0 0 16,17 * * ?") //.WithCronSchedule("52-59 7,13 * * * ?")  // 每天七點、下午四點執行。
              .WithIdentity("ComputOrderTrigger")
              .Build();

            // 把工作加入排程
            _schedular.ScheduleJob(job, trigger);
            _schedular.ScheduleJob(job2, trigger2);

            // 啟動排程器
            _schedular.Start();
        }

        protected void Application_End(object sender, EventArgs e)
        {
            _schedular.Shutdown(false);
        }
    }
}