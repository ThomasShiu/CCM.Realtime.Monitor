using System.Web.Mvc;

namespace CCM.Web.RDM.Areas.RDManage
{
    public class RDManageAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "RDManage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "RDManage_default",
                "RDManage/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
