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

    public class RD_MACHINEAUTHApp
    {
        private IRD_MACHINEAUTHRepository service = new RD_MACHINEAUTHRepository();

        public List<RD_MACHINEAUTHEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<RD_MACHINEAUTHEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.CS_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.M_ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.SHORT_NM.Contains(keyword));
                expression = expression.Or(t => t.PROD_NO.Contains(keyword));
                expression = expression.Or(t => t.Remark.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.CreatorTime).ToList();
        }
        public List<RD_MACHINEAUTHEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<RD_MACHINEAUTHEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.CS_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.M_ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.SHORT_NM.Contains(keyword));
                expression = expression.Or(t => t.PROD_NO.Contains(keyword));
                expression = expression.Or(t => t.oldFileName.Contains(keyword));
                expression = expression.Or(t => t.Remark.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        public List<RD_MACHINEAUTHEntity> GetListEnable(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<RD_MACHINEAUTHEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.CS_NO.Contains(keyword));
                expression = expression.Or(t => t.ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.M_ITEM_NO.Contains(keyword));
                expression = expression.Or(t => t.SHORT_NM.Contains(keyword));
                expression = expression.Or(t => t.PROD_NO.Contains(keyword));
                expression = expression.Or(t => t.oldFileName.Contains(keyword));
                expression = expression.Or(t => t.Remark.Contains(keyword));
            }
            expression = expression.And(t => t.Enable == true);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        public RD_MACHINEAUTHEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {

                service.Delete(t => t.SID == keyValue);
        }
        public void SubmitForm(RD_MACHINEAUTHEntity tableEntity, string keyValue)
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

        // 清空認證檔欄位
        public void ResetFile( string keyValue)
        {
            RD_MACHINEAUTHEntity entity = new RD_MACHINEAUTHEntity();
            entity.SID = keyValue;
            entity.Version = "";
            entity.oldFileName = "";
            entity.newFileName = "";
            entity.UploadPath = "";
            entity.DownloadPath = "";
            entity.CPU_SN = "";
            entity.HD_SN = "";
            entity.HD_Moduleno = "";
            entity.HD_Fireware = "";
            //entity.Remark = "";

            service.Update(entity);
        }

    }
}