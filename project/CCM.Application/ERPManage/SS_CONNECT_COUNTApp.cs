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

    public class SS_CONNECT_COUNTApp
    {
        private ISS_CONNECT_COUNTRepository service = new SS_CONNECT_COUNTRepository();

        public List<SS_CONNECT_COUNTEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<SS_CONNECT_COUNTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.SYS_NAME.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CREATE_DATE).ToList();
        }
        public List<SS_CONNECT_COUNTEntity> GetListERP(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<SS_CONNECT_COUNTEntity>();
            var queryParam = queryJson.ToJObject();
            expression = expression.And(t => t.SYS_NAME.Equals("ERP"));
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.Or(t => t.COMPANY.Contains(keyword));
            }
            
            return service.FindList(expression, pagination);
        }
        public List<SS_CONNECT_COUNTEntity> GetListPDM(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<SS_CONNECT_COUNTEntity>();
            var queryParam = queryJson.ToJObject();
            expression = expression.And(t => t.SYS_NAME.Equals("PDM"));
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();  
                expression = expression.Or(t => t.COMPANY.Contains(keyword));
            }

            return service.FindList(expression, pagination);
        }
        public List<SS_CONNECT_COUNTEntity> GetList(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<SS_CONNECT_COUNTEntity>();
            var queryParam = queryJson.ToJObject();
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.COMPANY.Contains(keyword));
            }

            // 日期條件
            if (!queryParam["moduleType"].IsEmpty())
            {
                string moduleType = queryParam["moduleType"].ToString();
                switch (moduleType)
                {
                    case "1":  // ERP
                        expression = expression.And(t => t.SYS_NAME.Equals("ERP"));
                        break;
                    case "2": //PDM
                        expression = expression.And(t => t.SYS_NAME.Equals("PDM"));
                        break;
                    default:
                        expression = expression.And(t => t.SYS_NAME.Equals("ERP"));
                        break;
                }

            }else
            {
                expression = expression.And(t => t.SYS_NAME.Equals("ERP"));
            }
            return service.FindList(expression, pagination);
        }
        public SS_CONNECT_COUNTEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
        }
        public void SubmitForm(SS_CONNECT_COUNTEntity tableEntity, string keyValue)
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