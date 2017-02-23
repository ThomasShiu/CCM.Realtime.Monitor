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

    //mapping table name: SRM_ALBUMMT
    public class SRM_ALBUMMTEntity : IEntityCcm<SRM_ALBUMMTEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String ImgType { get; set; }

        public String Prod_no { get; set; }

        public DateTime? Pdate { get; set; }

        public String Descript { get; set; }

        public String KindType1 { get; set; }

        public String KindType2 { get; set; }

        public String GUID { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }
    }
}