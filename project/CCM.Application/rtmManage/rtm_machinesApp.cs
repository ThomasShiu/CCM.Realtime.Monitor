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

    public class rtm_machinesApp
    {
        private Irtm_machinesRepository service = new rtm_machinesRepository();

        public List<rtm_machinesEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<rtm_machinesEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.F_Machine_ID.Contains(keyword));
                expression = expression.Or(t => t.F_Machine_Model.Contains(keyword));
                expression = expression.Or(t => t.F_Machine_Type.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.F_SortCode).ToList();
        }
        public List<rtm_machinesEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<rtm_machinesEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.F_Machine_ID.Contains(keyword));
                expression = expression.Or(t => t.F_Machine_Model.Contains(keyword));
                expression = expression.Or(t => t.F_Machine_Type.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public rtm_machinesEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            if (service.IQueryable().Count(t => t.F_Id.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.F_Id == keyValue);
            }
        }
        public void SubmitForm(rtm_machinesEntity tableEntity, string keyValue)
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
