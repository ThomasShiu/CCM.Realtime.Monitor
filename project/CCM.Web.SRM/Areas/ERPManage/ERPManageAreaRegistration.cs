using System.Web.Mvc;

namespace CCM.Web.SRM.Areas.ERPManage
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
                "ERPManage_default",
                "ERPManage/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
