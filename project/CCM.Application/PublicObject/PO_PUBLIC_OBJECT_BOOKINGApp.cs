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

    public class PO_PUBLIC_OBJECT_BOOKINGApp
    {
        private IPO_PUBLIC_OBJECT_BOOKINGRepository service = new PO_PUBLIC_OBJECT_BOOKINGRepository();

        public List<PO_PUBLIC_OBJECT_BOOKINGEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECT_BOOKINGEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.Subject.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }

        // 公務車
        public List<PO_PUBLIC_OBJECT_BOOKINGEntity> GetList_BookingCar(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECT_BOOKINGEntity>();
            var queryParam = queryJson.ToJObject();
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.Subject.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }

            // 關鍵字2
            if (!queryParam["keyword2"].IsEmpty())
            {
                string keyword = queryParam["keyword2"].ToString();
                expression = expression.And(t => t.ObjectSID.Contains(keyword));
            }
            // 日期條件
            if (!queryParam["timeType"].IsEmpty())
            {
                string timeType = queryParam["timeType"].ToString();
                DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(7);
                switch (timeType)
                {
                    case "1":  //今日內
                        startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddHours(-12);
                        break;
                    case "2": //一周內
                        startTime = DateTime.Now.AddDays(-7);
                        break;
                    case "3": //一月內
                        startTime = DateTime.Now.AddMonths(-1);
                        break;
                    default:
                        startTime = DateTime.Now.AddYears(-100);
                        break;
                }
                expression = expression.And(t => t.BookingEndTime >= startTime && t.BookingEndTime <= endTime);
            }
            else {
                DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddHours(-12);
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
                //startTime = DateTime.Now.AddDays(-1);
                expression = expression.And(t => t.BookingEndTime >= startTime);
            }
            expression = expression.And(t => t.ObjectType == "公務車輛");
            return service.FindList(expression, pagination);
        }

        // 會議室
        public List<PO_PUBLIC_OBJECT_BOOKINGEntity> GetList_BookingRoom(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECT_BOOKINGEntity>();
            var queryParam = queryJson.ToJObject();
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.Subject.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }
            // 日期條件
            if (!queryParam["timeType"].IsEmpty())
            {
                string timeType = queryParam["timeType"].ToString();
                DateTime startTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate();
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(7);
                switch (timeType)
                {
                    case "1":  //今日內
                        startTime = (DateTime.Now.ToString("yyyy-MM-dd")+" 01:00").ToDate();
                        expression = expression.And(t => t.BookingStartTime >= startTime);
                        break;
                    case "2": //一周內
                        startTime = DateTime.Now.AddDays(-7);
                        expression = expression.And(t => t.BookingStartTime >= startTime && t.BookingEndTime <= endTime);
                        break;
                    case "3": //一月內
                        startTime = DateTime.Now.AddMonths(-1);
                        expression = expression.And(t => t.BookingStartTime >= startTime && t.BookingEndTime <= endTime);
                        break;
                    default:
                        startTime = DateTime.Now.AddYears(-100);
                        expression = expression.And(t => t.BookingStartTime >= startTime && t.BookingEndTime <= endTime);
                        break;
                }
               
            }
            else
            {  // 預設:今日內
                DateTime startTime = (DateTime.Now.ToString("yyyy-MM-dd") + " 01:00").ToDate();
                DateTime endTime = DateTime.Now.ToString("yyyy-MM-dd").ToDate().AddDays(1);
                //startTime = DateTime.Now.AddDays(-1);
                expression = expression.And(t => t.BookingStartTime >= startTime);
            }
            expression = expression.And(t => t.ObjectType == "會議室");
            return service.FindList(expression, pagination);
        }
        public PO_PUBLIC_OBJECT_BOOKINGEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            //if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            //{
            //    throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            //}
            //else
            //{
                service.Delete(t => t.SID == keyValue);
            //}
        }
        public void SubmitForm(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(keyValue))
            {//編輯
                tableEntity.Modify(keyValue);
                service.Update(tableEntity);
            }
            else
            {//新建
                tableEntity.Status = "鎖定";
                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}