using CCM.Code;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Repository.DocumentManage;
using System;
using System.Collections.Generic;
using System.Linq;

namespace CCM.Application.Document
{
    public class FR_OFFIDOC_ISSUEApp
    {
        private IFR_OFFIDOC_ISSUERepository service = new FR_OFFIDOC_ISSUERepository();

        //public List<FR_OFFIDOC_ISSUE_Entity> GetList()
        //{
        //    return service.IQueryable().ToList();
        //}
        public List<FR_OFFIDOC_ISSUEEntity> GetList(Pagination pagination, string  keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_ISSUEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OFFICIAL_NM.Contains(keyword));
                expression = expression.Or(t => t.SUBJECT.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public FR_OFFIDOC_ISSUEEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            service.Delete(t => t.F_Id == keyValue);
        }
        public void SubmitForm(FR_OFFIDOC_ISSUEEntity tableEntity, string keyValue)
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

