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

    //mapping table name: SS_CONNECT_COUNT
    public class SS_CONNECT_COUNTEntity : IEntityCcm<SS_CONNECT_COUNTEntity>  //, ICreationAuditedCcm, IModificationAuditedCcm
    {
        public String SID { get; set; }

        public String COMPANY { get; set; }

        public String SYS_NAME { get; set; }

        public DateTime CREATE_DATE { get; set; }

        public Int32? ON_LINE_CNT { get; set; }

        public Int32? ACCOUNT_CNT { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}