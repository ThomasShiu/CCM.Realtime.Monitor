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

    //mapping table name: V_HR_FRLDL_1
    public class V_HR_FRLDL_1Entity : IEntityCcm<V_HR_FRLDL_1Entity>//, ICreationAuditedCcm, IModificationAuditedCcm
    {
        public String SID { get; set; }
        public String FMNO { get; set; }

        public Decimal SR { get; set; }

        public String EMPLYID { get; set; }

        public String EMPLYNM { get; set; }

        public String FRL_NO { get; set; }

        public String FRL_NM { get; set; }

        public String BL_DT_S { get; set; }

        public String BL_DT_E { get; set; }

        public String STARTTIME { get; set; }

        public String ENDTIME { get; set; }

        public String REMARK { get; set; }

        public String SFT_NO { get; set; }

        public String OWMON { get; set; }

    }
}