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

    //mapping table name: V_SRVPRODMT_KSC
    public class V_SRVPRODMT_NGBEntity : IEntityCcm<V_SRVPRODMT_NGBEntity>//, ICreationAuditedCcm, IModificationAuditedCcm
    {

        public String PROD_NO { get; set; }

        public String PROD_TY { get; set; }

        public String ITEM_NO { get; set; }

        public String ITEM_NM { get; set; }

        public String ITEM_SP { get; set; }

        public String M_ITEM_NO { get; set; }

        public String M_ITEM_ID { get; set; }

        public DateTime? SO_DT { get; set; }

        public String SO_TY { get; set; }

        public String SO_NO { get; set; }

        public Int32? SO_SR { get; set; }

        public String SO_CS_NO { get; set; }

        public String SO_CS_NM { get; set; }

        public String FA_NO { get; set; }

        public String CS_NO { get; set; }

        public String CS_NM { get; set; }

        public String TO_ADDR { get; set; }

        public Int32? PROD_GUAR_MM { get; set; }

        public DateTime? PROD_GUAR_DT { get; set; }

        public Int32? M_ITEM_GUAR_MM { get; set; }

        public DateTime? M_ITEM_GUAR_DT { get; set; }

        public String REMK { get; set; }

        public String CO_TY { get; set; }

        public String CO_NO { get; set; }

        public Int32? CO_SR { get; set; }

        public String CS_VCH_NO { get; set; }

        public String QT_TY { get; set; }

        public String QT_NO { get; set; }

        public Int32? QT_SR { get; set; }

        public String OWNER_USR_NO { get; set; }

        public String OWNER_GRP_NO { get; set; }

        public DateTime? ADD_DT { get; set; }

        public String IP_NM { get; set; }

        public String CP_NM { get; set; }

    }
}