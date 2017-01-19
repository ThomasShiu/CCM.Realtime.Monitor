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

    public class BU_BULLETINApp
    {
        private IBU_BULLETINRepository service = new BU_BULLETINRepository();

        public List<BU_BULLETINEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_BULLETINEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.BUSubject.Contains(keyword));
                expression = expression.Or(t => t.BUContent.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_BULLETINEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<BU_BULLETINEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.BUSubject.Contains(keyword));
                expression = expression.Or(t => t.BUContent.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public BU_BULLETINEntity GetForm(string keyValue)
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
            //}
        }
        public void SubmitForm(BU_BULLETINEntity tableEntity, string keyValue)
        {
            try { 
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
            catch(Exception ex)
            {
                throw new Exception(ex.InnerException.ToString());
            }
        }

    }
}