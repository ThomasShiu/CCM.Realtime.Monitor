using System.Web.Mvc;

namespace CCM.Web.SRM.Areas.SRManage
{
    public class SRManageAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "SRManage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "SRManage_default",
                "SRManage/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
