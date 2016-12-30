﻿using System.Web.Mvc;

namespace CCM.Web.EIP.Areas.WorkflowControl
{
    public class WorkflowControlAreaRegistration : AreaRegistration
    {
        public override string AreaName
        {
            get
            {
                return "WorkflowControl";
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
