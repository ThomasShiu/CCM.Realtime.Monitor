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

    //mapping table name: HR_OVRTM_TEST
    public class V_HR_OVRTMEntity //: IEntityHrs<HR_OVRTMEntity> ,ICreationAuditedHrs, IModificationAuditedHrs
    {

        public String OVRTNO { get; set; }

        public DateTime? APPDATE { get; set; }

        public DateTime? MRDT { get; set; }

        public DateTime? FETB { get; set; }

        public DateTime? FETE { get; set; }

        public DateTime? DETB { get; set; }

        public DateTime? DETE { get; set; }

        public Decimal? DEMIN { get; set; }

        public Decimal? REHRS { get; set; }

        public Decimal? LNO { get; set; }

        public String OVRTP { get; set; }

        public String DEREASON { get; set; }

        public String STATUS { get; set; }

        public String REM { get; set; }

        public String DEPID { get; set; }

        public String OTTP { get; set; }

        public Decimal? OVT1 { get; set; }

        public Decimal? OVT2 { get; set; }

        public Decimal? OVT3 { get; set; }

        public String OWMON { get; set; }

        public String EMPLYID { get; set; }

        public String EMPLYNM { get; set; }

        public String C_HLD { get; set; }

        public String C_SOURCE { get; set; }

        public Decimal? REHRS1 { get; set; }

        public String DEPIDAPP { get; set; }

        public String FILFRL { get; set; }

    }
}