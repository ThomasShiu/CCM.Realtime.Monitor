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

    //mapping table name: V_HR_FRLDL
    public class V_HR_FRLDLEntity : IEntityCcm<V_HR_FRLDLEntity>//, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String FMNO { get; set; }

        public Decimal SR { get; set; }

        public String EMPLYID { get; set; }

        public String AGEMP { get; set; }

        public String FRL_NO { get; set; }

        public String FRL_NM { get; set; }

        public DateTime BL_DT { get; set; }

        public String SFT_NO { get; set; }

        public Decimal B_NN { get; set; }

        public Decimal B_MM { get; set; }

        public Decimal E_NN { get; set; }

        public Decimal E_MM { get; set; }

        public Decimal FRHR { get; set; }

        public String REMARK { get; set; }

        public String OWMON { get; set; }

        public String C_SOURCE { get; set; }

        public String FRCL_NO { get; set; }

        public DateTime CDATE { get; set; }

        public String EXC_INSDBID { get; set; }

        public DateTime EXC_INSDATE { get; set; }

        public String EXC_UPDDBID { get; set; }

        public DateTime EXC_UPDDATE { get; set; }

    }
}