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

    //mapping table name: TEMP_USRPMS
    public class TEMP_USRPMSEntity : IEntityCcm<TEMP_USRPMSEntity> //, ICreationAuditedCcm ,IModificationAuditedCcm                         
    {

        public String SID { get; set; }

        public String USR_NO { get; set; }

        public String PRG_NO { get; set; }

        public String PRG_NM { get; set; }

        public String C_RUN { get; set; }

        public String C_ADD { get; set; }

        public String C_QRY { get; set; }

        public String C_MDY { get; set; }

        public String C_CFM { get; set; }

        public String C_UCF { get; set; }

        public String C_DEL { get; set; }

        public String C_CST { get; set; }

        public String C_CPY { get; set; }

        public String C_EML { get; set; }

        public String C_ATT { get; set; }

        public String C_SIN { get; set; }

    }
}