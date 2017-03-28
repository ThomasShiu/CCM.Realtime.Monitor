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

    public class PO_PUBLIC_OBJECT_ATTEND_EMPApp
    {
        private IPO_PUBLIC_OBJECT_ATTEND_EMPRepository service = new PO_PUBLIC_OBJECT_ATTEND_EMPRepository();

        public List<PO_PUBLIC_OBJECT_ATTEND_EMPEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECT_ATTEND_EMPEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMP_NO.Contains(keyword));
                expression = expression.Or(t => t.DEPID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<PO_PUBLIC_OBJECT_ATTEND_EMPEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<PO_PUBLIC_OBJECT_ATTEND_EMPEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.EMP_NO.Contains(keyword));
                expression = expression.Or(t => t.DEPID.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public PO_PUBLIC_OBJECT_ATTEND_EMPEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue, string keyValue2)
        {
            // 只剩一筆外出人員，則不可再刪除
            if (service.IQueryable().Count(t => t.ParentSID.Equals(keyValue2)) <= 1)
            {
                throw new Exception("<br/>必須有一位外出人員。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }

        }
        public void SubmitForm(PO_PUBLIC_OBJECT_ATTEND_EMPEntity tableEntity, string keyValue)
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