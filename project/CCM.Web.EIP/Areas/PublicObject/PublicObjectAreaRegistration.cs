using System.Web.Mvc;

namespace CCM.Web.EIP.Areas.PublicObject
{
    public class PublicObjectAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "PublicObject";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "PublicObject_default",
                "PublicObject/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
