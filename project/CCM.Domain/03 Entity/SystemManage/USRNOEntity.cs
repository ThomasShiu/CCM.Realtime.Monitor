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

    //mapping table name: USRNO ERP使用者帳密
    public class USRNOEntity : IEntityCcm<USRNOEntity>
    {

        public String SID { get; set; }

        public String USR_NO { get; set; }

        public String USR_NM { get; set; }

        public String GRP_NO { get; set; }

        public String EMP_NO { get; set; }

        public String USR_PW { get; set; }

        public String C_SUPER { get; set; }

        public String USR_DIR { get; set; }

        public String CUS_DW1 { get; set; }

        public String CUS_DW2 { get; set; }

        public String CUS_DW3 { get; set; }

        public DateTime EFF_DT { get; set; }

        public DateTime EXP_DT { get; set; }

        public DateTime PW_DT { get; set; }

        public Int32 VLD_DAY { get; set; }

    }
}