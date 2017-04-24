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
using CCM.Repository.SystemSecurity;
using CCM.Domain.IRepository.SystemSecurity;
using CCM.Domain.Entity.SystemSecurity;
//todo: 請修改對應的namespace
namespace CCM.Application.SystemSecurity
{

    public class ActionLogApp
    {
        private IActionLogRepository service = new ActionLogRepository();
        public List<ActionLogEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<ActionLogEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.F_Operator.Contains(keyword));
                expression = expression.Or(t => t.F_Refer.Contains(keyword));
                expression = expression.Or(t => t.F_Destination.Contains(keyword));
                expression = expression.Or(t => t.F_IPAddress.Contains(keyword));
                // expression = expression.Or(t => t.F_EnCode.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.F_RequestTime).ToList();
        }
        public List<ActionLogEntity> GetList(Pagination pagination, string queryJson)
        {
            var expression = ExtLinq.True<ActionLogEntity>();
            var queryParam = queryJson.ToJObject();
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.F_Operator.Contains(keyword));
                expression = expression.Or(t => t.F_Refer.Contains(keyword));
                expression = expression.Or(t => t.F_Destination.Contains(keyword));
                expression = expression.Or(t => t.F_IPAddress.Contains(keyword));
                //expression = expression.Or(t => t.SUBJECT.Contains(keyword));
            }
            if (!queryParam["timeType"].IsEmpty())
            {
                string timeType = queryParam["timeType"].ToString();
                DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
                switch (timeType)
                {
                    case "1":
                        break;
                    case "2":
                        startTime = DateTime.Now.AddDays(-7);
                        break;
                    case "3":
                        startTime = DateTime.Now.AddMonths(-1);
                        break;
                    case "4":
                        startTime = DateTime.Now.AddMonths(-3);
                        break;
                    default:
                        break;
                }
                expression = expression.And(t => t.F_RequestTime >= startTime && t.F_RequestTime <= endTime);
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public ActionLogEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }

        public void RemoveLog(string keepTime)
        {
            DateTime operateTime = DateTime.Now;
            if (keepTime == "7")            //保留近一周
            {
                operateTime = DateTime.Now.AddDays(-7);
            }
            else if (keepTime == "1")       //保留近一个月
            {
                operateTime = DateTime.Now.AddMonths(-1);
            }
            else if (keepTime == "3")       //保留近三个月
            {
                operateTime = DateTime.Now.AddMonths(-3);
            }
            var expression = ExtLinq.True<ActionLogEntity>();
            expression = expression.And(t => t.F_RequestTime <= operateTime);
            service.Delete(expression);
        }

        public void DeleteForm(string keyValue)
        {
            if (service.IQueryable().Count(t => t.F_Id.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.F_Id == keyValue);
            }
        }
        public void SubmitForm(ActionLogEntity tableEntity, string keyValue)
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