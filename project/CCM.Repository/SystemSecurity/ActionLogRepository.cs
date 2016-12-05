/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Data;
using CCM.Domain;
using CCM.Domain.Entity;
using CCM.Domain.Entity.SystemSecurity;
using CCM.Domain.IRepository.SystemSecurity;

//todo: 請修改對應的namespace
namespace CCM.Repository.SystemSecurity
{

    //mapping table name: Sys_ActionLog
    public class ActionLogRepository : RepositoryBase<ActionLogEntity>, IActionLogRepository
    {
    }
}