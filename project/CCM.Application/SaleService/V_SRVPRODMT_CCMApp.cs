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

    public class V_SRVPRODMT_CCMApp
    {
        private IV_SRVPRODMT_CCMRepository service = new V_SRVPRODMT_CCMRepository();

        public List<V_SRVPRODMT_CCMEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_SRVPRODMT_CCMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NM.Contains(keyword));
                expression = expression.Or(t => t.ITEM_SP.Contains(keyword));
                expression = expression.Or(t => t.M_ITEM_NO.Contains(keyword)); 
                expression = expression.Or(t => t.M_ITEM_ID.Contains(keyword));
                expression = expression.Or(t => t.PROD_NO.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.SO_DT).ToList();
        }
        public List<V_SRVPRODMT_CCMEntity> GetList(Pagination pagination, string keyword = "")
        {
            try
            {
                var expression = ExtLinq.True<V_SRVPRODMT_CCMEntity>();
                if (!string.IsNullOrEmpty(keyword))
                {
                    expression = expression.And(t => t.ITEM_NO.Contains(keyword));
                    expression = expression.Or(t => t.ITEM_NM.Contains(keyword));
                    expression = expression.Or(t => t.ITEM_SP.Contains(keyword));
                    expression = expression.Or(t => t.M_ITEM_NO.Contains(keyword));
                    expression = expression.Or(t => t.M_ITEM_ID.Contains(keyword));
                    expression = expression.Or(t => t.PROD_NO.Contains(keyword));
                }
                //expression = expression.And(t => t.F_Category == 2);
                //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
                return service.FindList(expression, pagination);
            }
            catch (Exception ex ) {
                var vstr = ex.ToString();
                return null;
            }
        }
        public V_SRVPRODMT_CCMEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }


    }
}