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

    public class PU_ATTACH_FILEApp
    {
        private IPU_ATTACH_FILERepository service = new PU_ATTACH_FILERepository();

        public List<PU_ATTACH_FILEEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<PU_ATTACH_FILEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ParentSID.Contains(keyword));
                expression = expression.Or(t => t.OldFileName.Contains(keyword));
                expression = expression.Or(t => t.FileType.Contains(keyword));
                expression = expression.Or(t => t.Module.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<PU_ATTACH_FILEEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<PU_ATTACH_FILEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ParentSID.Contains(keyword));
                expression = expression.Or(t => t.OldFileName.Contains(keyword));
                expression = expression.Or(t => t.FileType.Contains(keyword));
                expression = expression.Or(t => t.Module.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public PU_ATTACH_FILEEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            service.Delete(t => t.SID == keyValue);
        }
        public void SubmitForm(PU_ATTACH_FILEEntity tableEntity, string keyValue)
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