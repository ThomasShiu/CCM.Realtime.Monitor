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

    public class HR_OVRTM_TESTApp
    {
        private IHR_OVRTM_TESTRepository service = new HR_OVRTM_TESTRepository();
        private StoreProcedure sp = new StoreProcedure();

        public List<HR_OVRTM_TESTEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<HR_OVRTM_TESTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.OVRTNO).ToList();
        }
        public List<HR_OVRTM_TESTEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<HR_OVRTM_TESTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        // 個人加班單
        public List<HR_OVRTM_TESTEntity> GetListEmp(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<HR_OVRTM_TESTEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));

            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public HR_OVRTM_TESTEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {

            service.Delete(t => t.OVRTNO == keyValue);

        }
        public void SubmitForm(HR_OVRTM_TESTEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(keyValue))
            {
                tableEntity.Modify(keyValue);
                service.Update(tableEntity);
            }
            else
            {
                // todo 判斷平日、假日  ， 取得部門代碼、部門名稱
                tableEntity.OVRTNO = sp.GetOrdNo("OVERTIME", "OT", 1);
                tableEntity.DEPID = sp.GetDeptByEmplyid(tableEntity.EMPLYID, "DEPID");
                tableEntity.APPDATE = DateTime.Now;
                tableEntity.EXC_INSDATE= DateTime.Now;

                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}