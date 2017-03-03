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

    public class V_HR_TICKETApp
    {
        private IV_HR_TICKETRepository service = new V_HR_TICKETRepository();

        public List<V_HR_TICKETEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_HR_TICKETEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.YYMMDD).ToList();
        }
        public List<V_HR_TICKETEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<V_HR_TICKETEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        #region 打卡時間
        public List<V_HR_TICKETEntity> GetTicketList(string emplyid,DateTime yymmdd)
        {
            var expression = ExtLinq.True<V_HR_TICKETEntity>();
            expression = expression.And(t => t.EMPLYID.Contains(emplyid));
            expression = expression.And(t => t.YYMMDD.Equals(yymmdd));

            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.YYMMDD).ToList();
        }
        #endregion

    }
}