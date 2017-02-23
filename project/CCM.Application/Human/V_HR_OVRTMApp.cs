﻿/*******************************************************************************
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

    public class V_HR_OVRTMApp
    {
        private IV_HR_OVRTMRepository service = new V_HR_OVRTMRepository();
        private CcmServices cs = new CcmServices();

        public List<V_HR_OVRTMEntity> GetList(string keyword = "")
        {
            var expression = ExtLinq.True<V_HR_OVRTMEntity>();
            if (!string.IsNullOrEmpty(keyword))
            {
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }
            //expression = expression.And(t => t.F_Category == 1);
            return service.IQueryable(expression).OrderBy(t => t.OVRTNO).ToList();
        }
        public List<V_HR_OVRTMEntity> GetList(Pagination pagination, string queryJson = "")
        {
            var expression = ExtLinq.True<V_HR_OVRTMEntity>();
            var queryParam = queryJson.ToJObject();

            if (!queryParam["keyword"].IsEmpty())
            {
                string keyword = queryParam["keyword"].ToString();
                expression = expression.And(t => t.OVRTNO.Contains(keyword));
                expression = expression.Or(t => t.EMPLYID.Contains(keyword));
                expression = expression.Or(t => t.EMPLYNM.Contains(keyword));
                expression = expression.Or(t => t.DEREASON.Contains(keyword));
            }

            // 簽核狀態
            if (!queryParam["statusType"].IsEmpty())
            {
                string statusType = queryParam["statusType"].ToString();
                switch (statusType)
                {
                    case "SN":  
                        expression = expression.And(t => t.STATUS == "SN");
                        break;
                    case "OP":
                        expression = expression.And(t => t.STATUS == "OP");
                        break;
                    case "CL":
                        expression = expression.And(t => t.STATUS == "CL");
                        break;
                    case "NL": 
                        expression = expression.And(t => t.STATUS == "NL");
                        break;
                    case "PB": 
                        expression = expression.And(t => t.STATUS == "PB");
                        break;
                    case "CF": 
                        expression = expression.And(t => t.STATUS == "CF");
                        break;
                    case "ALL":
                        expression = expression.And(t => t.STATUS != "");
                        break;
                    default:
                        
                        break;
                }
            }else {
                expression = expression.And(t => t.STATUS == "SN");
            }

            //expression = expression.And(t => t.STATUS == "SN");
            //return service.IQueryable(expression).OrderBy(t => t.ISSUEID).ToList();
            return service.FindList(expression, pagination);
        }

        // 個人加班單
        public List<V_HR_OVRTMEntity> GetListEmp(Pagination pagination, string keyword = "")
        {
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var expression = ExtLinq.True<V_HR_OVRTMEntity>();
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
        public V_HR_OVRTMEntity GetForm(string keyValue)
        {
            return service.FindEntity(keyValue);
        }
       

    }
}