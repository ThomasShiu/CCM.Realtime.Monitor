using System.Web.Mvc;

namespace CCM.Web.SRM.Areas.ReportManage
{
    public class ReportManageAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "ReportManage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
              this.AreaName + "_EIP",
              this.AreaName + "/{controller}/{action}/{id}",
              new { area = this.AreaName, controller = "Home", action = "Index", id = UrlParameter.Optional },
              new string[] { "CCM.Web.SRM.Areas." + this.AreaName + ".Controllers" }
            );
        }
    }
}
