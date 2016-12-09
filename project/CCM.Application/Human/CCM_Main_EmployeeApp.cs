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

    public class CCM_Main_EmployeeApp
    {
        private ICCM_Main_EmployeeRepository service = new CCM_Main_EmployeeRepository();

        public List<CCM_Main_EmployeeEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<CCM_Main_EmployeeEntity>();
            
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMP_NO.Contains(keyword));
                expression = expression.Or(t => t.EMP_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.EMP_NO).ToList();
        }

        public List<CCM_Main_EmployeeEntity> GetList(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<CCM_Main_EmployeeEntity>();
            var queryParam = queryJson.ToJObject();
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.EMP_NO.Contains(keyword));
                expression = expression.Or(t => t.EMP_NM.Contains(keyword));
            }
            // 日期條件
            if (!queryParam["timeType"].IsEmpty())
            {
                string timeType = queryParam["timeType"].ToString();
                DateTime startTime = DateTime.Now.AddMonths(-3).ToString("yyyy-MM-dd").ToDate();
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
                switch (timeType)
                {
                    case "1":  //到職日，全部
                        startTime = DateTime.Now.AddYears(-100);
                        break;
                    case "2": //到職日，三個月內
                        startTime = DateTime.Now.AddMonths(-3);
                        break;
                    default:
                        startTime = DateTime.Now.AddMonths(-3);
                        break;
                }
                expression = expression.And(t => t.CreatorTime >= startTime && t.CreatorTime <= endTime);
            }

            return service.FindList(expression, pagination);
        }
        public CCM_Main_EmployeeEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        //public void DeleteForm(string keyValue)
        //{
        //    if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
        //    {
        //        throw new Exception("刪除失敗！操作的物件包含了下級資料。");
        //    }
        //    else
        //    {
        //        service.Delete(t => t.SID == keyValue);
        //    }
        //}
        //public void SubmitForm(CCM_Main_EmployeeEntity tableEntity, string keyValue)
        //{
        //    if (!string.IsNullOrEmpty(keyValue))
        //    {
        //        tableEntity.Modify(keyValue);
        //        service.Update(tableEntity);
        //    }
        //    else
        //    {
        //        tableEntity.Create();
        //        service.Insert(tableEntity);
        //    }
        //}

    }
}