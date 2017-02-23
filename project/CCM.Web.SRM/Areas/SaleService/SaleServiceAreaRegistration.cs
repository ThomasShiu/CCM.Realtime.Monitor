using System.Web.Mvc;

namespace CCM.Web.SRM.Areas.SaleService
{
    public class SaleServiceAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "SaleService";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context)
        {
            context.MapRoute(
                "SaleService_default",
                "SaleService/{controller}/{action}/{id}",
                new { action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}
