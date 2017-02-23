/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/

using CCM.Code;
using System;

namespace CCM.Domain
{
    public class IEntityCcm<TEntity>
    {
        public void Create()
        {
            var entity = this as ICreationAuditedCcm;
            entity.SID = Common.GuId();
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            if (LoginInfo != null)
            {
                entity.CreatorUserId = LoginInfo.UserCode;
            }
            entity.CreatorTime = DateTime.Now;
            entity.OrganizeId = "CCM";
        }
        public void Modify(string keyValue)
        {
            var entity = this as IModificationAuditedCcm;
            entity.SID = keyValue;
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            if (LoginInfo != null)
            {
                entity.LastModifyUserId = LoginInfo.UserCode;
            }
            entity.LastModifyTime = DateTime.Now;
        }
        public void Remove()
        {
            var entity = this as IDeleteAuditedCcm;
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            if (LoginInfo != null)
            {
                entity.DeleteUserId = LoginInfo.UserCode;
            }
            entity.DeleteTime = DateTime.Now;
            entity.DeleteMark = true;
        }
    }
}
