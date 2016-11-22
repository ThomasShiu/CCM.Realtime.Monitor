using System;
using System.Linq;
using System.Collections.Generic;
using CCM.Code;
using CCM.Domain;
using CCM.Repository;
using CCM.Domain.Entity;
//todo: 請修改對應的namespace
namespace CCM.Application
{

    public class FR_OFFIDOC_ISSUEApp
    {
        private IFR_OFFIDOC_ISSUERepository service = new FR_OFFIDOC_ISSUERepository();

        public List<FR_OFFIDOC_ISSUEEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_ISSUEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ISSUEID.Contains(keyword));
                expression = expression.Or(t => t.SUBJECT.Contains(keyword));
                expression = expression.Or(t => t.DESCR.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<FR_OFFIDOC_ISSUEEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_ISSUEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ISSUEID.Contains(keyword));
                expression = expression.Or(t => t.OFFICIAL_NM.Contains(keyword));
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
            if (service.IQueryable().Count(t => t.SID.Equals(keyValue)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
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