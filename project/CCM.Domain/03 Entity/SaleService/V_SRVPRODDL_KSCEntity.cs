/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain
{

    //mapping table name: V_SRVPRODDL_CCM
    public class V_SRVPRODDL_KSCEntity : IEntityCcm<V_SRVPRODDL_KSCEntity> //, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String PROD_NO { get; set; }

        public Int32 PROD_SR { get; set; }

        public String ENTRY { get; set; }

        public String DSCP_1 { get; set; }

        public String DSCP_2 { get; set; }

        public String DSCP_3 { get; set; }

    }
}