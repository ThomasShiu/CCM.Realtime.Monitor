﻿/*******************************************************************************
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

    public class RD_DWG_EXMANAGE_MTApp
    {
        private IRD_DWG_EXMANAGE_MTRepository service = new RD_DWG_EXMANAGE_MTRepository();

        public List<RD_DWG_EXMANAGE_MTEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<RD_DWG_EXMANAGE_MTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ORD_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NO.Contains(keyword)); 
                expression = expression.Or(t => t.ITEM_NM.Contains(keyword)); 
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<RD_DWG_EXMANAGE_MTEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<RD_DWG_EXMANAGE_MTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ORD_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NM.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public RD_DWG_EXMANAGE_MTEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            // 偵測有無附件
            if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
        }
        public void SubmitForm(RD_DWG_EXMANAGE_MTEntity tableEntity, string keyValue)
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