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

    //mapping table name: BU_LUNCH
    public class BU_LUNCHEntity : IEntityCcm<BU_LUNCHEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String LUTYPE { get; set; }

        public String LOCATION { get; set; }

        public DateTime? LUDATE { get; set; }

        public String FROM_YEAR { get; set; }

        public String FROM_MONTH { get; set; }

        public String TO_YEAR { get; set; }

        public String TO_MONTH { get; set; }

        public String EMPLYID { get; set; }

        public String DEPID { get; set; }

        public Int32? MEATPEOPLES { get; set; }

        public Int32? VEGEPEOPLES { get; set; }

        public Int32? AMOUNT { get; set; }

        public String REMK { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}