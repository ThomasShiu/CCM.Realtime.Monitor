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

    public class V_HR_EMPPAYMTApp
    {
        private IV_HR_EMPPAYMTRepository service = new V_HR_EMPPAYMTRepository();

        public List<V_HR_EMPPAYMTEntity> GetList(string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_EMPPAYMTEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.Or(t => t.YYYYMM.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.YYYYMM).ToList();
        }
        public List<V_HR_EMPPAYMTEntity> GetList(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_EMPPAYMTEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.Or(t => t.YYYYMM.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        public List<V_HR_EMPPAYMTEntity> GetListEmp(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_EMPPAYMTEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));

            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.Or(t => t.YYYYMM.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
            }

            return service.FindList(expression, pagination);
        }
        public V_HR_EMPPAYMTEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
      

    }
}