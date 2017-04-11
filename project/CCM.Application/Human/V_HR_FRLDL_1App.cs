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

    public class V_HR_FRLDL_1App
    {
        private IV_HR_FRLDL_1Repository service = new V_HR_FRLDL_1Repository();

        public List<V_HR_FRLDL_1Entity> GetList(string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_FRLDL_1Entity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.REMARK.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.FMNO.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            }
            
            return service.IQueryable(expression).OrderBy(t => t.BL_DT_S).ToList();
        }
        public List<V_HR_FRLDL_1Entity> GetList(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_FRLDL_1Entity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.REMARK.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.FMNO.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));

            }
            
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public V_HR_FRLDL_1Entity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
       

    }
}