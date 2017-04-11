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

    public class HR_OVRTMApp
    {
        private IHR_OVRTMRepository service = new HR_OVRTMRepository();
        private CcmServices cs = new CcmServices();

        public List<HR_OVRTMEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<HR_OVRTMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.OVRTNO).ToList();
        }
        public List<HR_OVRTMEntity> GetList(Pagination pagination, string keyword = "")
        {
            var expression = ExtLinq.True<HR_OVRTMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                //expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            expression = expression.And(t => t.STATUS == "SN");
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        // 個人加班單
        public List<HR_OVRTMEntity> GetListEmp(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<HR_OVRTMEntity>();
            expression = expression.And(t => t.EMPLYID.Trim().Equals(LoginInfo.UserCode));

            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.DEREASON.Contains(keyword) & t.EMPLYID.Trim().Equals(LoginInfo.UserCode));
            }
            //expression = expression.And(t => t.F_Category == 2);
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        // 加班單-BY建立人員
        public List<HR_OVRTMEntity> GetListEMPADD(Pagination pagination, string queryJson = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<HR_OVRTMEntity>();
            expression = expression.And(t => t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));

            var queryParam = queryJson.ToJObject();

            // 關鍵字
            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.OVRTNO.Contains(keyword) & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                expression = expression.Or(t => t.DEREASON.Contains(keyword) & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
            }
            // 關鍵字2
            if (!queryParam["statusType"].IsEmpty())
            {
                string statusType = queryParam["statusType"].ToString();
                switch (statusType)
                {

                    case "SN":
                        expression = expression.And(t => t.STATUS == "SN" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "OP":
                        expression = expression.And(t => t.STATUS == "OP" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "CL":
                        expression = expression.And(t => t.STATUS == "CL" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "NL":
                        expression = expression.And(t => t.STATUS == "NL" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "PB":
                        expression = expression.And(t => t.STATUS == "PB" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "CF":
                        expression = expression.And(t => t.STATUS == "CF" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    case "ALL":
                        expression = expression.And(t => t.STATUS != "" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                    default:
                        expression = expression.And(t => t.STATUS == "OP" & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
                        break;
                }
            }
            else
            {
                expression = expression.And(t => t.STATUS.Trim().Equals("OP") & t.EXC_INSDBID.Trim().Equals(LoginInfo.UserCode));
            }
            return service.FindList(expression, pagination);
        }

        public HR_OVRTMEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
        public void DeleteForm(string keyValue)
        {

            service.Delete(t => t.OVRTNO == keyValue);

        }
        public void SubmitForm(HR_OVRTMEntity tableEntity, string keyValue)
        {
            if (!string.IsNullOrEmpty(keyValue))
            {
                // 修改
                tableEntity.Modify(keyValue);
                service.Update(tableEntity);
            }
            else
            {
                // 新建
                tableEntity.OVRTNO = cs.GetOrdNo("OVERTIME", "OT", 1);
                tableEntity.DEPID = cs.GetDeptByEmplyid(tableEntity.EMPLYID, "DEPID");
                //tableEntity.APPDATE = DateTime.Now;
                tableEntity.EXC_INSDATE= DateTime.Now;

                tableEntity.Create();
                service.Insert(tableEntity);
            }
        }

    }
}