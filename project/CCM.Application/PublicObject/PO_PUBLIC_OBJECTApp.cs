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

    public class PO_PUBLIC_OBJECTApp
    {
        private IPO_PUBLIC_OBJECTRepository service = new PO_PUBLIC_OBJECTRepository();

        public List<PO_PUBLIC_OBJECTEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ObjectNM.Contains(keyword));
                expression = expression.Or(t => t.ObjectType.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            expression = expression.And(t => t.Enable == "Y");
            return service.IQueryable(expression).OrderBy(t => t.ObjectNM).ToList();
        }
        public List<PO_PUBLIC_OBJECTEntity> GetListSID(string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {//有關鍵字，就顯示所有公共物件
                expression = expression.And(t => t.SID.Equals(keyword));
            }else
            {//無關鍵字就只顯示啟用中的公共物件
                expression = expression.And(t => t.Enable == "Y");
            }
            //expression = expression.And(t => t.F_Category == 1);
            
            return service.IQueryable(expression).OrderBy(t => t.ObjectNM).ToList();
        }
        public List<PO_PUBLIC_OBJECTEntity> GetListClient(string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ObjectNM.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }
            
            return service.IQueryable(expression).OrderBy(t => t.ObjectNM).ToList();
        }
        public List<PO_PUBLIC_OBJECTEntity> GetList(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECTEntity>();
            var queryParam = queryJson.ToJObject();
            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.ObjectNM.Contains(keyword));
                expression = expression.Or(t => t.Description.Contains(keyword));
            }
            // 物件分類
            if (!queryParam["objectType"].IsEmpty())
            {
                string timeType = queryParam["objectType"].ToString();
                switch (timeType)
                {
                    case "0":  //全部
                        expression = expression.And(t => t.ObjectType != "");
                        break;
                    case "1":  //公務車
                        expression = expression.And(t => t.ObjectType == "公務車輛");
                        break;
                    case "2": //會議室
                        expression = expression.And(t => t.ObjectType == "會議室");
                        break;
                    case "3": //其他物品
                        expression = expression.And(t => t.ObjectType == "其他物品");
                        break;
                    default:
                        break;
                }
            }
            else {
                expression = expression.And(t => t.ObjectType == "公務車輛");
            }

            //if (!string.IsNullOrEmpty(keyword))
            //{
            //    expression = expression.And(t => t.ObjectNM.Contains(keyword));
            //    expression = expression.Or(t => t.Description.Contains(keyword));
            //}
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public PO_PUBLIC_OBJECTEntity GetForm(string keyValue)
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
        public void SubmitForm(PO_PUBLIC_OBJECTEntity tableEntity, string keyValue)
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