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

    public class ERP_ITEM_ATTACHFILEApp
    {
        private IERP_ITEM_ATTACHFILERepository service = new ERP_ITEM_ATTACHFILERepository();
        private IPU_ATTACH_FILERepository service2 = new PU_ATTACH_FILERepository();

        public List<ERP_ITEM_ATTACHFILEEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<ERP_ITEM_ATTACHFILEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NM.Contains(keyword));
                expression = expression.Or(t => t.ITEM_SP.Contains(keyword));
                expression = expression.Or(t => t.CLAS_NO.Contains(keyword));
                expression = expression.Or(t => t.CLAS_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<ERP_ITEM_ATTACHFILEEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<ERP_ITEM_ATTACHFILEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NM.Contains(keyword));
                expression = expression.Or(t => t.ITEM_SP.Contains(keyword));
                expression = expression.Or(t => t.CLAS_NO.Contains(keyword));
                expression = expression.Or(t => t.CLAS_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public ERP_ITEM_ATTACHFILEEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            ERP_ITEM_ATTACHFILEEntity entity = service.FindEntity(keyValue);
            string v_guid = entity.GUID;

            if (service2.IQueryable().Count(t => t.ParentSID.Equals(v_guid)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
        }
        public void SubmitForm(ERP_ITEM_ATTACHFILEEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(keyValue))
            {
                tableEntity.Modify(keyValue);
                service.Update(tableEntity);
            }
            else
            {
                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}