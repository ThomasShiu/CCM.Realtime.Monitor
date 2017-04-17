
using CCM.RTM.PORTAL.App_Start;
using Hangfire;
using Quartz;
using System;
using System.Configuration;
using System.Web.Mvc;
using System.Web.Routing;

namespace CCM.RTM.PORTAL
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

            //GlobalConfiguration.Configuration
            //.UseSqlServerStorage(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);

            // 建立簡單的、以 RAM 為儲存體的排程器
            var schedulerFactory = new Quartz.Impl.StdSchedulerFactory();
            _schedular = schedulerFactory.GetScheduler();

            // 建立工作
            IJobDetail job = JobBuilder.Create<SendMailTask>().WithIdentity("SendMailJob").Build();        // 未簽核加班單mail通知
            IJobDetail job2 = JobBuilder.Create<ComputOrderTask>().WithIdentity("ComputOrderJob").Build(); // 計算午餐用餐人數
            IJobDetail job3 = JobBuilder.Create<SyncErpPwTask>().WithIdentity("SyncErpPwJob").Build();     // 同步ERP 密碼
            IJobDetail job4 = JobBuilder.Create<BookingCarTask>().WithIdentity("BookingCarJob").Build();     // 自動預約公務車-楊登雄使用

            // 建立觸發器
            // 代表意義	    秒     分      時      日     月    周     年	   指令
            // 數字範圍    0-59   0-59    0-23    1-7    1-12   1-7  ? 2017   Common
            //          周 1=SUN 或 SUN，MON，TUE，WED，THU，FRI，SAT
            ITrigger trigger = TriggerBuilder.Create()
              .WithCronSchedule("0 30 16 ? * 2-7")  // 每天七點半、下午四點半執行。
              //.WithCronSchedule("0 52 9 * * ?")
              .WithIdentity("SendMailTrigger")
              .Build();

            ITrigger trigger2 = TriggerBuilder.Create()
              .WithCronSchedule("0 0 9 * * ?")  // 9:00 執行
              .WithIdentity("ComputOrderTrigger")
              .Build();

            ITrigger trigger3 = TriggerBuilder.Create()
             .WithCronSchedule("0 30 9-16 * * ?") 
             .WithIdentity("SyncErpTrigger")
             .Build();

            ITrigger trigger4 = TriggerBuilder.Create()
             .WithCronSchedule("0 0 9 * * ?")  // 9:00 執行
             .WithIdentity("BookingCarTrigger")
             .Build();

            // 把工作加入排程
            _schedular.ScheduleJob(job, trigger);    // 未簽核加班單mail通知
            _schedular.ScheduleJob(job2, trigger2);  // 計算午餐用餐人數
            _schedular.ScheduleJob(job3, trigger3);  // 同步ERP 密碼
            _schedular.ScheduleJob(job4, trigger4);  // 自動預約公務車-楊登雄使用

            // 啟動排程器
            _schedular.Start();
        }

        protected void Application_End(object sender, EventArgs e)
        {
            _schedular.Shutdown(false);
        }
    }
}