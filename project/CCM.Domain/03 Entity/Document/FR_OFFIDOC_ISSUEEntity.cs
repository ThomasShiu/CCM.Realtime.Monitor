/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;

namespace CCM.Domain.Entity
{
    public class FR_OFFIDOC_ISSUEEntity : IEntity<FR_OFFIDOC_ISSUEEntity> , ICreationAudited, IDeleteAudited, IModificationAudited
    {
        public string F_Id { get; set; }

        public string ISSUEID { get; set; }

        public string COMPANY { get; set; }

        public DateTime ISSUEDATE { get; set; }

        public string OFFICIAL_NM { get; set; }

        public string SUBJECT { get; set; }

        public string DESCR { get; set; }

        public string AttachFIle { get; set; }

        public string EMPID { get; set; }

        public string DEPID { get; set; }

        public string STATUS { get; set; }

        public string DOCTYPE { get; set; }

        public string CONTACT { get; set; }

        public string PHONEAREACODE { get; set; }

        public string PHONE { get; set; }

        public string PHONEEXTENSION { get; set; }

        public string FAX { get; set; }

        public string Original { get; set; }

        public string Duplicate { get; set; }

        public DateTime? F_CreatorTime { get; set; }
        public string F_CreatorUserId { get; set; }
        public DateTime? F_LastModifyTime { get; set; }
        public string F_LastModifyUserId { get; set; }
        public bool? F_DeleteMark { get; set; }
        public DateTime? F_DeleteTime { get; set; }
        public string F_DeleteUserId { get; set; }
    }
}
