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

    public class realtime_sortingApp
    {
        private Irealtime_sortingRepository service = new realtime_sortingRepository();

        public List<realtime_sortingEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<realtime_sortingEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.Machine.Contains(keyword));
                expression = expression.Or(t => t.Status.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.StartingTime).ToList();
        }
        public List<realtime_sortingEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<realtime_sortingEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.Machine.Contains(keyword));
                expression = expression.Or(t => t.Status.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public realtime_sortingEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }


    }
}
