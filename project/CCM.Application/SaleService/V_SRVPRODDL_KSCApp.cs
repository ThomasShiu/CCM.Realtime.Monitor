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

    public class V_SRVPRODDL_KSCApp
    {
        private IV_SRVPRODDL_KSCRepository service = new V_SRVPRODDL_KSCRepository();

        public List<V_SRVPRODDL_KSCEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_SRVPRODDL_KSCEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.PROD_NO.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.PROD_SR).ToList();
        }
        public List<V_SRVPRODDL_KSCEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<V_SRVPRODDL_KSCEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.PROD_NO.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public V_SRVPRODDL_KSCEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }


    }
}