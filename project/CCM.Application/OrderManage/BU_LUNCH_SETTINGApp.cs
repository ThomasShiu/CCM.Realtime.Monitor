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

    public class BU_LUNCH_SETTINGApp
    {
        private IBU_LUNCH_SETTINGRepository service = new BU_LUNCH_SETTINGRepository();

        public List<BU_LUNCH_SETTINGEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_LUNCH_SETTINGEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.DEPID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_LUNCH_SETTINGEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<BU_LUNCH_SETTINGEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.DEPID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public BU_LUNCH_SETTINGEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
             service.Delete(t => t.SID == keyValue);
        }
        public void SubmitForm(BU_LUNCH_SETTINGEntity tableEntity, string keyValue)
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