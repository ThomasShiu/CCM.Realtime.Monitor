﻿/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版权所有
 * Author: CCM
 * Description: CCM快速开发平台
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using CCM.Code;
using CCM.Data;
using CCM.Domain.Entity.SystemManage;
using CCM.Domain.IRepository.SystemManage;
using CCM.Repository.SystemManage;

namespace CCM.Repository.SystemManage
{
    public class UserRepository : RepositoryBase<UserEntity>, IUserRepository
    {
        public void DeleteForm(string keyValue)
        {
            using (var db = new RepositoryBase().BeginTrans())
            {
                db.Delete<UserEntity>(t => t.F_Id == keyValue);  // 帳號主檔
                db.Delete<UserLogOnEntity>(t => t.F_UserId == keyValue);  // 帳號登入設定檔
                db.Commit();
            }
        }
        public void SubmitForm(UserEntity userEntity, UserLogOnEntity userLogOnEntity, string keyValue)
        {
            using (var db = new RepositoryBase().BeginTrans())
            {
                if (!string.IsNullOrEmpty(keyValue))
                {
                    db.Update(userEntity);
                }
                else
                {
                    userLogOnEntity.F_Id = userEntity.F_Id;
                    userLogOnEntity.F_UserId = userEntity.F_Id;
                    userLogOnEntity.F_UserSecretkey = Md5.md5(Common.CreateNo(), 16).ToLower();
                    userLogOnEntity.F_UserPassword = Md5.md5(DESEncrypt.Encrypt(Md5.md5(userLogOnEntity.F_UserPassword, 32).ToLower(), userLogOnEntity.F_UserSecretkey).ToLower(), 32).ToLower();
                    db.Insert(userEntity);
                    db.Insert(userLogOnEntity);
                }
                db.Commit();
            }
        }
    }
}
