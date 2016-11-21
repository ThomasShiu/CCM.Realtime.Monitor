using System;
using System.Linq;
using System.Collections.Generic;
using CCM.Code;
using CCM.Domain;
using CCM.Repository;

//todo: 請修改對應的namespace
namespace CCM.Application
{

    public class MisIpAddressApp
        {
        private IMisIpAddressRepository service = new MisIpAddressRepository();

        public List<MisIpAddressEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True < MisIpAddressEntity> ();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.IP_ADDR.Contains(keyword));
                expression = expression.Or(t => t.MAC_ADDR.Contains(keyword));
            }
            //expression = expression.And(t => t.SID == 1);
            return service.IQueryable(expression).OrderBy(t => t.IP_ADDR).ToList();
        }
        public List<MisIpAddressEntity> GetList(Pagination pagination, string keyword = "")
    {
        var expression = ExtLinq.True<MisIpAddressEntity>();
        if (!string.IsNullOrEmpty(keyword))
        {
            expression = expression.And(t => t.IP_ADDR.Contains(keyword));
            expression = expression.Or(t => t.MAC_ADDR.Contains(keyword));
        }
        //expression = expression.And(t => t.F_Category == 2);
        //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
        return service.FindList(expression, pagination);
    }
    public MisIpAddressEntity GetForm(string keyValue)
    {
        return service.FindEntity(keyValue);
    }
    public void DeleteForm(string keyValue)
    {
        service.Delete(t => t.SID == keyValue);
    }
    public void SubmitForm(MisIpAddressEntity tableEntity, string keyValue)
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