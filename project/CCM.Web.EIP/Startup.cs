using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;
using Hangfire;
using System.Configuration;

[assembly: OwinStartup(typeof(CCM.Web.EIP.Startup))]

namespace CCM.Web.EIP
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {

            GlobalConfiguration.Configuration.UseSqlServerStorage("EIPContext");

            //BackgroundJob.Enqueue(() => Console.WriteLine("Fire-and-forget!"));

            //BackgroundJob.Enqueue(() => StartMyTask("", "", ""));


            app.UseHangfireDashboard();
            app.UseHangfireServer();

        }

        //使用 Hangfire 去執行的話， nested obj 會 parse 不出來，所以用字串傳遞
        public void StartMyTask(string arg1, string arg2, string arg3)
        {
            // 要執行的事項
            string msg = String.Format("hangfire() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
            Log(msg);
        }

        private void Log(string msg)
        {
            System.IO.File.AppendAllText(@"C:\Temp\log.txt", msg + Environment.NewLine);
        }
    }
}
