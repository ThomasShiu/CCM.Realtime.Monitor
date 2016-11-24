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

    //mapping table name: HR_DEP
    public class HR_DEPEntity : IEntityCcm<HR_DEPEntity>
    {

        public String DEPID { get; set; }

        public String DEPNM { get; set; }

        public String EMPLYID { get; set; }

        public String SAL { get; set; }

        public String MPS { get; set; }

        public String STK { get; set; }

        public String BUY { get; set; }

        public String FIN { get; set; }

        public String PER { get; set; }

        public String QC { get; set; }

        public String TPATRB { get; set; }

        public String RD { get; set; }

        public String PRJ { get; set; }

        public String DPRTID { get; set; }

        public String COMID { get; set; }

        public String LBRTP { get; set; }

    }
}