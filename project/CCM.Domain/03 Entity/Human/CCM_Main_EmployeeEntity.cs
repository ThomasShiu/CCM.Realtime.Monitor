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

    //mapping table name: CCM_Main_Employee
    public class CCM_Main_EmployeeEntity : IEntityCcm<CCM_Main_EmployeeEntity>
    {
        public String SID { get; set; }
        public String EMP_NO { get; set; }

        public String EMP_NM { get; set; }

        public String BRD_DT { get; set; }

        public String BRD_DT1 { get; set; }

        public String ARV_DT { get; set; }

        public String DEPM_NO { get; set; }

        public String SEX { get; set; }

        public String ID_NO { get; set; }

        public String LEV_DT { get; set; }

        public String JOB_NO { get; set; }

        public String TEL_NO2 { get; set; }

        public String JOB_NM { get; set; }

        public String DEPM_NM { get; set; }

        public String DEPM_NM1 { get; set; }

        public String PhotoUrl { get; set; }

    }
}