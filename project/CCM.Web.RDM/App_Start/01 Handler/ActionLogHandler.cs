using CCM.Code;
using CCM.Domain.Entity.SystemSecurity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CCM.Web.RDM.App_Start._01_Handler
{
    public class ActionLogHandler
    {/// <summary>
     /// 寫入日誌
     /// </summary>
     /// <param name="oper">操作人</param>
     /// <param name="mes">操作資訊</param>
     /// <param name="result">結果</param>
     /// <param name="type">類型</param>
     /// <param name="module">操作模組</param>
        public static void WriteServiceLog(string oper, string mes, string result, string type, string module)
        {
            //LogEntity entity = new LogEntity();
            //var LoginInfo = OperatorProvider.Provider.GetCurrent();
            //entity.F_Id = Common.GuId();
            //entity.F_Account = LoginInfo.UserCode;
            //entity.Message = mes;
            //entity.Result = result;
            //entity.Type = type;
            //entity.Module = module;
            //entity.CreateTime = ResultHelper.NowTime;
            //using (cs_syslogRepository logRepository = new cs_syslogRepository())
            //{
            //    logRepository.Create(entity);
            //}

        }

    }
}