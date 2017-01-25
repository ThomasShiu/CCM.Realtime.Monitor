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

    public class BU_ORDERS_DETAILApp
    {
        private IBU_ORDERS_DETAILRepository service = new BU_ORDERS_DETAILRepository();
        
        public List<BU_ORDERS_DETAILEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_ORDERS_DETAILEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EmpID.Contains(keyword));
                //expression = expression.Or(t => t.F_EnCode.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_ORDERS_DETAILEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<BU_ORDERS_DETAILEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EmpID.Contains(keyword));
                //expression = expression.Or(t => t.SUBJECT.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public List<BU_ORDERS_DETAILEntity> GetDetailList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_ORDERS_DETAILEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ParentSID.Equals(keyword));
                //expression = expression.Or(t => t.F_EnCode.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_ORDERS_DETAILEntity> GetJsonList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_ORDERS_DETAILEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EmpID.Contains(keyword));
                expression = expression.Or(t => t.ParentSID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_ORDERS_DETAILEntity> GetForm2(string keyValue)
        {
            var expression = ExtLinq.True<BU_ORDERS_DETAILEntity>();
            expression = expression.And(t => t.ParentSID == keyValue);
            return service.IQueryable(expression).OrderBy(t => t.OrderDate).ToList();
        }

        public BU_ORDERS_DETAILEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }

        public void DeleteForm(string keyValue)
        {
            //if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            //{
            //    throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            //}
            //else
            //{
            service.Delete(t => t.SID == keyValue);
            
            //
            //}
        }
        public void SubmitForm(BU_ORDERS_DETAILEntity tableEntity, string keyValue)
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