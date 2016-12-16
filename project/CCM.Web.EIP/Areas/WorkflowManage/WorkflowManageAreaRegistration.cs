using System.Web.Mvc;

namespace CCM.Web.EIP.Areas.WorkflowManage
{
    public class WorkflowManageAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "WorkflowManage";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "WorkflowManage_default",
                "WorkflowManage/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
