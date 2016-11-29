/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.Linq;
using System.Collections.Generic;
using CCM.Code;
using CCM.Domain;
using CCM.Repository;
//todo: 請修改對應的namespace
namespace CCM.Application
{

    public class FR_OFFIDOC_RECEApp
    {
        private IFR_OFFIDOC_RECERepository service = new FR_OFFIDOC_RECERepository();
        private IFR_OFFIDOC_RECE_ATTACH_FILERepository service2 = new FR_OFFIDOC_RECE_ATTACH_FILERepository();
        private StoreProcedure sp = new StoreProcedure();

        public List<FR_OFFIDOC_RECEEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_RECEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OFFICIAL_NM.Contains(keyword));
                expression = expression.Or(t => t.OFFICIAL_DOCID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.RECEIVEID).ToList();
        }
        public List<FR_OFFIDOC_RECEEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_RECEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OFFICIAL_NM.Contains(keyword));
                expression = expression.Or(t => t.OFFICIAL_DOCID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.RECEIVEID).ToList();
            return service.FindList(expression, pagination);
        }
        public FR_OFFIDOC_RECEEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            FR_OFFIDOC_RECEEntity entity = service.FindEntity(keyValue);
            string v_guid = entity.GUID;
            if (service2.IQueryable().Count(t => t.ParentRECEIVEID.Equals(v_guid)) > 0)
            {
                throw new Exception("刪除失敗！<br/>收文文資料包含附件，請先刪除附件。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
            //if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            //{
            //    throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            //}
            //else
            //{
            service.Delete(t => t.SID == keyValue);
            //}
        }
        public void SubmitForm(FR_OFFIDOC_RECEEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(keyValue))
            {
                tableEntity.Modify(keyValue);
                service.Update(tableEntity);
            }
            else
            {
                tableEntity.RECEIVEID = sp.GetOrdNo("DOC_RECEIVE", "", 1);
                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}