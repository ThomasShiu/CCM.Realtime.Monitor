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

    public class V_HR_FRLDLApp
    {
        private IV_HR_FRLDLRepository service = new V_HR_FRLDLRepository();

        public List<V_HR_FRLDLEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_HR_FRLDLEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.FMNO.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.BL_DT).ToList();
        }
        public List<V_HR_FRLDLEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<V_HR_FRLDLEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.FMNO.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public V_HR_FRLDLEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
     

    }
}