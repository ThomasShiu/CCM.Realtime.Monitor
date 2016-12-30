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
    public class IEntityHrs<TEntity>
    {
        public void Create()
        {
            var entity = this as ICreationAuditedHrs;
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
        }
        public void Modify(string keyValue)
        {
            var entity = this as IModificationAuditedHrs;
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
        }
        public void Remove()
        {
            var entity = this as IDeleteAuditedHrs;
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
        }
    }
}
