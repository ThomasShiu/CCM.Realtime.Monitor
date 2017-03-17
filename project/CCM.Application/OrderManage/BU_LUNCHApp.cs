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

    public class BU_LUNCHApp
    {
        private IBU_LUNCHRepository service = new BU_LUNCHRepository();

        public List<BU_LUNCHEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<BU_LUNCHEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.FROM_YEAR.Contains(keyword));
                expression = expression.Or(t => t.FROM_MONTH.Contains(keyword));
                expression = expression.Or(t => t.TO_YEAR.Contains(keyword));
                expression = expression.Or(t => t.TO_MONTH.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<BU_LUNCHEntity> GetList(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<BU_LUNCHEntity>();
            var queryParam = queryJson.ToJObject();
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.FROM_YEAR.Contains(keyword));
                expression = expression.Or(t => t.FROM_MONTH.Contains(keyword));
                expression = expression.Or(t => t.TO_YEAR.Contains(keyword));
                expression = expression.Or(t => t.TO_MONTH.Contains(keyword));
            }
            // 物件分類
            if (!queryParam["objectType"].IsEmpty())
            {
                string LunchType = queryParam["objectType"].ToString();
                switch (LunchType)
                {
                    case "1":  //單日不用餐
                        expression = expression.And(t => t.LUTYPE == "1");
                        break;
                    case "2":  //整月不用餐
                        expression = expression.And(t => t.LUTYPE == "2");
                        break;
                    case "3": //素食用餐
                        expression = expression.And(t => t.LUTYPE == "3");
                        break;
                    case "4": //訪客用餐
                        expression = expression.And(t => t.LUTYPE == "4");
                        break;
                    default:
                        expression = expression.And(t => t.LUTYPE != "");
                        break;
                }
            }
            else
            {
                expression = expression.And(t => t.LUTYPE != "");
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public List<BU_LUNCHEntity> GetListEmp(Pagination pagination, string queryJson = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<BU_LUNCHEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            var queryParam = queryJson.ToJObject();
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.FROM_YEAR.Contains(keyword));
                expression = expression.Or(t => t.FROM_MONTH.Contains(keyword));
            }
            // 物件分類
            if (!queryParam["objectType"].IsEmpty())
            {
                string LunchType = queryParam["objectType"].ToString();
                switch (LunchType)
                {
                    case "1":  //單日不用餐
                        expression = expression.And(t => t.LUTYPE == "1");
                        break;
                    case "2":  //整月不用餐
                        expression = expression.And(t => t.LUTYPE == "2");
                        break;
                    case "3": //素食用餐
                        expression = expression.And(t => t.LUTYPE == "3");
                        break;
                    case "4": //訪客用餐
                        expression = expression.And(t => t.LUTYPE == "4");
                        break;
                    default:
                        expression = expression.And(t => t.LUTYPE != "");
                        break;
                }
            }
            else
            {
                expression = expression.And(t => t.LUTYPE != "");
            }
            return service.FindList(expression, pagination);
        }
        public BU_LUNCHEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            service.Delete(t => t.SID == keyValue);
        }
        public void SubmitForm(BU_LUNCHEntity tableEntity, string keyValue)
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