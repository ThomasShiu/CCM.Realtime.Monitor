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

    //mapping table name: Sys_Order_Seq
    public class OrderSeqEntity : IEntityCcm<OrderSeqEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String NAME { get; set; }

        public String TYPE { get; set; }

        public String PREFIX { get; set; }

        public String CODEFORMAT { get; set; }

        public Int32? NO_LENGTH { get; set; }

        public Int32? CURRENT_NO { get; set; }

        public String CURRENT_ORDNO { get; set; }

        public String CURRENT_YM { get; set; }

        public String RESETFLAG { get; set; }

        public String STATUS { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}