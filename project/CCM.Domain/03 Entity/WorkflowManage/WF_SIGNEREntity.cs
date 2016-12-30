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

    //mapping table name: WF_SIGNER_TEST
    public class WF_SIGNEREntity : IEntityCcm<WF_SIGNEREntity> //, ICreationAuditedCcm, IModificationAuditedCcm
    {
        public String SID { get; set; }
        public String ROLENM { get; set; }

        public String DEP_NO { get; set; }

        public String DEP_NM { get; set; }

        public String EMPLYID8 { get; set; }

        public String EMP8_NM { get; set; }

        public String EMPLYID9 { get; set; }

        public String EMP9_NM { get; set; }

        public String SIGNEMPLYID1 { get; set; }

        public String SIGNEMPLYID1NM { get; set; }

        public String SIGNEMPLYID2 { get; set; }

        public String SIGNEMPLYID2NM { get; set; }

        public String SIGNEMPLYID3 { get; set; }

        public String SIGNEMPLYID3NM { get; set; }

        public String SIGNEMPLYID4 { get; set; }

        public String SIGNEMPLYID4NM { get; set; }

        public String PROXY1ID { get; set; }

        public String PROXY1NM { get; set; }

        public String PROXY2ID { get; set; }

        public String PROXY2NM { get; set; }

        public String PROXY3ID { get; set; }

        public String PROXY3NM { get; set; }

    }
}