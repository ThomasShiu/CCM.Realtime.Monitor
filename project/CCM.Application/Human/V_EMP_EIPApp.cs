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

    public class V_EMP_EIPApp
    {
        private IV_EMP_EIPRepository service = new V_EMP_EIPRepository();

        public List<V_EMP_EIPEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_EMP_EIPEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.EMPLYID).ToList();
        }
        public List<V_EMP_EIPEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<V_EMP_EIPEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public V_EMP_EIPEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }

       

    }
}