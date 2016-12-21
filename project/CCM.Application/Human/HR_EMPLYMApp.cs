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

    public class HR_EMPLYMApp
    {
        private IHR_EMPLYMRepository service = new HR_EMPLYMRepository();

        public List<HR_EMPLYMEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<HR_EMPLYMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.EMPLYID).ToList();
        }
        // 還在職的員工
        public List<HR_EMPLYMEntity> GetListActive(string keyword = "")
        {
            var expression = ExtLinq.True<HR_EMPLYMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
                expression = expression.Or(t => t.DEPID.Contains(keyword));
            }
            expression = expression.And(t => t.C_STA == "A");  // 在職員工 C_STA='A'  離職 C_STA='D'
            return service.IQueryable(expression).OrderBy(t => t.EMPLYID).ToList();
        }
        // 還在職的員工 by 部門別
        public List<HR_EMPLYMEntity> GetListActDep(string keyword = "")
        {
            var expression = ExtLinq.True<HR_EMPLYMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.DEPID.Contains(keyword));
            }
            expression = expression.And(t => t.C_STA == "A");  // 在職員工 C_STA='A'  離職 C_STA='D'
            return service.IQueryable(expression).OrderBy(t => t.EMPLYID).ToList();
        }
        public List<HR_EMPLYMEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<HR_EMPLYMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public HR_EMPLYMEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            if (service.IQueryable().Count(t => t.EMPLYID.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.EMPLYID == keyValue);
            }
        }
        public void SubmitForm(HR_EMPLYMEntity tableEntity, string keyValue)
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