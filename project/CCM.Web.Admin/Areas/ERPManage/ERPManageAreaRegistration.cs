using System.Web.Mvc;

namespace CCM.Web.Admin.Areas.ERPManage
{
    public class ERPManageAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "ERPManage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
               this.AreaName + "_default",
               this.AreaName + "/{controller}/{action}/{id}",
              new { area = this.AreaName, controller = "Home", action = "Index", id = UrlParameter.Optional },
              new string[] { "CCM.Web.Admin.Areas." + this.AreaName + ".Controllers" }
            );
        }
    }
}