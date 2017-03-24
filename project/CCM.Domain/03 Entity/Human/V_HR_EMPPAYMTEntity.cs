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

    //mapping table name: V_HR_EMPPAYMT
    public class V_HR_EMPPAYMTEntity : IEntityCcm<V_HR_EMPPAYMTEntity> //, ICreationAuditedCcm, IModificationAuditedCcm
    {
        public String SID { get; set; }
        
        public String YYYYMM { get; set; }

        public String EMPLYID { get; set; }

        public String EMPLYNM { get; set; }

        public String DEPNM { get; set; }

        public String FA_NO { get; set; }

        public String COMID { get; set; }

        public Decimal? CP_LIS_EXP { get; set; }

        public Decimal? CP_EIS_EXP { get; set; }

        public Decimal? CP_HIS_EXP { get; set; }

        public Decimal? CP_LPS_EXP { get; set; }

        public Decimal? LIS_SLY { get; set; }

        public Decimal? EIS_SLY { get; set; }

        public Decimal? HIS_SLY { get; set; }

        public Decimal? LPS_SLY { get; set; }

        public Decimal? LIS_EXP { get; set; }

        public Decimal? EIS_EXP { get; set; }

        public Decimal? HIS_EXP { get; set; }

        public Decimal? ADD_EXP { get; set; }

        public Decimal? LPS_EXP { get; set; }

        public Decimal? OVT1_HR { get; set; }

        public Decimal? OVT2_HR { get; set; }

        public Decimal? OVT3_HR { get; set; }

        public Decimal? HLD_HR { get; set; }

        public Decimal? FRL_DAY { get; set; }

        public Decimal? LATE_NN { get; set; }

        public Decimal? LATE_CT { get; set; }

        public Decimal? ALP_RT { get; set; }

        public Decimal? BAS_SLY { get; set; }

        public Decimal? ALP_RWD { get; set; }

        public Decimal? FRE_OVT { get; set; }

        public Decimal? TAX_OVT { get; set; }

        public Decimal? MNS_FRL { get; set; }

        public Decimal? MNS_TAX { get; set; }

        public Decimal? TAX_INC { get; set; }

        public Decimal? AMT { get; set; }

        public String REL_MON_DAY { get; set; }

        public String FIX_MON_DAY { get; set; }

        public String LAK_MON_DAY { get; set; }

        public Decimal? HIS_EXP_PRC { get; set; }

        public Decimal? LAK_MON_AMT { get; set; }

        public Decimal? OVT1_HR_FT { get; set; }

        public Decimal? OVT2_HR_FT { get; set; }

        public Decimal? HLD_HR_FT { get; set; }

        public Decimal? OVT_HR { get; set; }

        public Decimal? HR_AMT1 { get; set; }

        public Decimal? HR_AMT2 { get; set; }

        public Decimal? FT_HLD_AMT { get; set; }

        public Decimal? IT_HLD_AMT { get; set; }

        public Decimal? FFRE_OVT { get; set; }

        public Decimal? FTAX_OVT { get; set; }

        public Decimal? FAMT { get; set; }

        public Decimal? LATE_EXP { get; set; }

        public String REMARK { get; set; }

    }
}