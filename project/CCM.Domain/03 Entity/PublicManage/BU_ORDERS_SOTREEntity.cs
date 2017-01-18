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

    //mapping table name: BU_ORDERS_SOTRE
    public class BU_ORDERS_SOTREEntity : IEntityCcm<BU_ORDERS_SOTREEntity>, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String SID { get; set; }

        public String Name { get; set; }

        public String Phone { get; set; }

        public String Fax { get; set; }

        public String Address { get; set; }

        public String Contact { get; set; }

        public Int32? SubsidizeAmount { get; set; }

        public String ContributingVendor { get; set; }

        public String WebSiteURL { get; set; }

        public String Offer { get; set; }

        public String Remark { get; set; }

        public Int32? SortCode { get; set; }

        public String OrganizeId { get; set; }

        public DateTime? CreatorTime { get; set; }

        public String CreatorUserId { get; set; }

        public DateTime? LastModifyTime { get; set; }

        public String LastModifyUserId { get; set; }

    }
}