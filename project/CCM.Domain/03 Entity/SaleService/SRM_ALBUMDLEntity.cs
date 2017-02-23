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

    //mapping table name: SRM_ALBUMDL
    public class SRM_ALBUMDLEntity : IEntityCcm<SRM_ALBUMDLEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String parentId { get; set; }

        public String FileName { get; set; }

        public Int32? Size { get; set; }

        public String Descript { get; set; }

        public String ImgPath { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}