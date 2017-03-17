using Hangfire;
using Hangfire.MemoryStorage;
using Microsoft.Owin;
using Owin;
using System;
using System.Threading.Tasks;

[assembly: OwinStartup(typeof(CCM.Web.EIP.App_Start))]

namespace CCM.Web.EIP.App_Start
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // 指定Hangfire使用記憶體儲存任務
            GlobalConfiguration.Configuration.UseMemoryStorage();
            // 啟用HanfireServer
            app.UseHangfireServer();
            // 啟用Hangfire的Dashboard
            app.UseHangfireDashboard();
        }
    }
}