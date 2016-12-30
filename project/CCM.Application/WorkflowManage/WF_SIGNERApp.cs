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

    public class WF_SIGNERApp
    {
        private IWF_SIGNERRepository service = new WF_SIGNERRepository();

        public List<WF_SIGNEREntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<WF_SIGNEREntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.DEP_NO.Contains(keyword));
                expression = expression.Or(t => t.DEP_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.DEP_NO).ToList();
        }
        public List<WF_SIGNEREntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<WF_SIGNEREntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.DEP_NO.Contains(keyword));
                expression = expression.Or(t => t.DEP_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public WF_SIGNEREntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
       

    }
}