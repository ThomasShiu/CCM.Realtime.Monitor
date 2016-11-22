/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.ComponentModel.DataAnnotations;

//todo: 請修改對應的namespace
namespace CCM.Domain
{

    //mapping table name: FR_OFFIDOC_ISSUE
    public class FR_OFFIDOC_ISSUEEntity : IEntityCcm<FR_OFFIDOC_ISSUEEntity>, ICreationAuditedCcm , IModificationAuditedCcm
    {

        public String SID { get; set; }
        public String ISSUEID { get; set; }
        public String COMPANY { get; set; }

        public DateTime ISSUEDATE { get; set; }

        public String OFFICIAL_NM { get; set; }

        public String SUBJECT { get; set; }

        public String DESCR { get; set; }

        public String AttachFIle { get; set; }

        public String EMPID { get; set; }

        public String DEPID { get; set; }

        public String STATUS { get; set; }

        public String DOCTYPE { get; set; }

        public String CONTACT { get; set; }

        public String PHONEAREACODE { get; set; }

        public String PHONE { get; set; }

        public String PHONEEXTENSION { get; set; }

        public String FAX { get; set; }

        public String Original { get; set; }

        public String Duplicate { get; set; }

        public String GUID { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}