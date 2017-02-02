/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版权所有
 * Author: CCM * Description: CCM快速开发平台
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Code;
using CCM.Domain.Entity.SystemManage;
using CCM.Domain.Entity.SystemSecurity;
using CCM.Domain.IRepository.SystemManage;
using CCM.Repository.SystemManage;
using System.Collections.Generic;
using System.Linq;

namespace CCM.Application.SystemManage
{
    public class UserLogOnApp
    {
        private IUserLogOnRepository service1 = new UserLogOnRepository();
        private IUserLogOnRepository service = new UserLogOnRepository();


        public List<UserLogOnEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<UserLogOnEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.F_Id.Contains(keyword));
                expression = expression.Or(t => t.F_UserId.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.F_LastVisitTime).ToList();
        }
        public UserLogOnEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }

        public UserLogOnEntity GetFormInfo(string keyValue)
        {
            string f_id="";
            var expression = ExtLinq.True<UserLogOnEntity>();
            expression = expression.And(t => t.F_UserId == keyValue);
            var data = service1.IQueryable(expression).OrderBy(t => t.F_LastVisitTime).ToList();
            //var result = (from c in data
            //             select new {
            //                 F_Id = c.F_Id,
            //                 F_UserId = c.F_UserId
            //             });
            foreach (var item in data)
            {
                f_id = item.F_Id;
            }
            return service.FindEntity(f_id);
        }

        public void UpdateForm(UserLogOnEntity userLogOnEntity)
        {
            service.Update(userLogOnEntity);
        }
        public void RevisePassword(string userPassword,string keyValue)
        {
            UserLogOnEntity userLogOnEntity = new UserLogOnEntity();
            userLogOnEntity.F_Id = keyValue;
            userLogOnEntity.F_UserSecretkey = Md5.md5(Common.CreateNo(), 16).ToLower();
            userLogOnEntity.F_UserPassword = Md5.md5(DESEncrypt.Encrypt(Md5.md5(userPassword, 32).ToLower(), userLogOnEntity.F_UserSecretkey).ToLower(), 32).ToLower();
            service.Update(userLogOnEntity);
        }
    }
}
