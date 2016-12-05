using System;
using System.Linq;
using System.Collections.Generic;
using CCM.Code;
using CCM.Domain;
using CCM.Repository;
using CCM.Domain.Entity;
using CCM.Web.Data;
using System.Data.SqlClient;
//todo: 請修改對應的namespace
namespace CCM.Application
{

    public class FR_OFFIDOC_ISSUEApp
    {
        private IFR_OFFIDOC_ISSUERepository service = new FR_OFFIDOC_ISSUERepository();
        private IFR_OFFIDOC_ISSUE_ATTACH_FILERepository service2 = new FR_OFFIDOC_ISSUE_ATTACH_FILERepository();

        private StoreProcedure sp = new StoreProcedure();

        public List<FR_OFFIDOC_ISSUEEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<FR_OFFIDOC_ISSUEEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.ISSUEID.Contains(keyword));
                expression = expression.Or(t => t.SUBJECT.Contains(keyword));
                expression = expression.Or(t => t.DESCR.Contains(keyword));
                expression = expression.Or(t => t.SID.Contains(keyword));
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
            FR_OFFIDOC_ISSUEEntity entity = service.FindEntity(keyValue);
            string v_guid = entity.GUID;
            if (service2.IQueryable().Count(t => t.ParentISSUEID.Equals(v_guid)) > 0)
            {
                throw new Exception("刪除失敗！<br/>發文資料包含附件，請先刪除附件。");
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
                tableEntity.ISSUEID = sp.GetOrdNo("DOC_ISSUE", (tableEntity.COMPANY=="0"?"精湛字第": (tableEntity.COMPANY == "1"?"全盈字第":"全盈(桃)字第")), 1);
                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}