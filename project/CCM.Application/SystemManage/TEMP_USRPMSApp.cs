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

    public class TEMP_USRPMSApp
    {
        private ITEMP_USRPMSRepository service = new TEMP_USRPMSRepository();

        public List<TEMP_USRPMSEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<TEMP_USRPMSEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.PRG_NO.Contains(keyword));
                expression = expression.Or(t => t.PRG_NM.Contains(keyword));
                expression = expression.Or(t => t.USR_NO.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.PRG_NO).ToList();
        }
        public List<TEMP_USRPMSEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<TEMP_USRPMSEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.PRG_NO.Contains(keyword));
                expression = expression.Or(t => t.PRG_NM.Contains(keyword));
                expression = expression.Or(t => t.USR_NO.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public TEMP_USRPMSEntity GetForm(string keyValue)
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
        public void SubmitForm(TEMP_USRPMSEntity tableEntity, string keyValue)
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