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
               this.AreaName + "_Default",
                this.AreaName + "/{controller}/{action}/{id}",
                new { area = this.AreaName, controller = "Home", action = "Index", id = UrlParameter.Optional },
                new string[] { "CCM.Web.EIP.Areas." + this.AreaName + ".Controllers" }
            );
        }
    }
}
