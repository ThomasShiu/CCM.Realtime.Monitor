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

    public class SRM_ALBUMMTApp
    {
        private ISRM_ALBUMMTRepository service = new SRM_ALBUMMTRepository();
        private ISRM_ALBUMDLRepository servicedl = new SRM_ALBUMDLRepository();

        public List<SRM_ALBUMMTEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<SRM_ALBUMMTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.Descript.Contains(keyword));
                expression = expression.Or(t => t.KindType1.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<SRM_ALBUMMTEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<SRM_ALBUMMTEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.Descript.Contains(keyword));
                expression = expression.Or(t => t.KindType1.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }
        public SRM_ALBUMMTEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {
            SRM_ALBUMMTEntity entity = service.FindEntity(keyValue);
            string v_guid = entity.GUID;

            if (servicedl.IQueryable().Count(t => t.parentId.Equals(v_guid)) > 0)
            {
                throw new Exception("刪除失敗！操作的物件包含了下級資料。");
            }
            else
            {
                service.Delete(t => t.SID == keyValue);
            }
        }
        public void SubmitForm(SRM_ALBUMMTEntity tableEntity, string keyValue)
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