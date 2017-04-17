using CCM.Code;
using CCM.Domain.Entity.SystemManage;
using CCM.Domain.IRepository.SystemManage;
using CCM.Repository.SystemManage;
using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using CCM.Domain.Entity.SystemSecurity;

namespace CCM.RTM.PORTAL.App_Start
{
    public class SyncErpPwTask : IJob
    {

        public IUserLogOnRepository service = new UserLogOnRepository();

        public void Execute(IJobExecutionContext context)
        {
            //DoSendMail();
            SyncErpPw();
        }

        #region 同步ERP密碼
        public void SyncErpPw()
        {
            
            string SQL = "  SELECT F_Id,F_Account,F_RealName FROM Sys_User "+
                        "   WHERE  1=1 " +
                        "   AND F_Account IN( " +
                        "    SELECT SID COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                        "     FROM EIP.dbo.V_USRNO ) ";
            //string SQL2 = " SELECT A.SID, A.ObjectSID,B.ObjectNM,dbo.SF_EMP_NAME(A.EmployeeID) Empnm,A.Subject,A.BookingStartTime, A.BookingEndTime FROM PO_PUBLIC_OBJECT_BOOKING A,PO_PUBLIC_OBJECT B " +
            //            " WHERE A.ObjectSID = B.SID  AND ObjectSID = '" + tableEntity.ObjectSID + "' AND (('" + tableEntity.BookingStartTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN  BookingStartTime AND BookingEndTime ) OR ('" + tableEntity.BookingEndTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN BookingStartTime AND BookingEndTime))";
            string v_message = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            { 
                                var f_id = dr["F_Id"].ToString();
                                var v_usercode = dr["F_Account"].ToString();  // 工號
                                var userPassword = GetErpPW(v_usercode);      // 密碼

                                UserLogOnEntity userLogOnEntity = new UserLogOnEntity();
                                userLogOnEntity.F_Id = f_id;
                                userLogOnEntity.F_UserSecretkey = Md5.md5(CreateNo(), 16).ToLower();
                                userLogOnEntity.F_UserPassword = Md5.md5(DESEncrypt.Encrypt(Md5.md5(userPassword, 32).ToLower(), userLogOnEntity.F_UserSecretkey).ToLower(), 32).ToLower();
                                service.Update(userLogOnEntity);                                
                            }
                            string msg = String.Format("SyncErpPw() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
                            Log(msg);
                        }
                    }
                }
            }


        }
        #endregion

        public string GetErpPW(string v_usercode)
        {
            string SQL = " SELECT SID,RTRIM(USR_NO) AS USR_NO,RTRIM(USR_PW) AS USR_PW  FROM  V_USRNO WHERE SID = '"+ v_usercode + "' ";
           
            string v_password = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                              v_password = dr["USR_PW"].ToString();
                            }
                        }
                    }

                }
            }
            return v_password;
        }

        /// <summary>
        /// 自動生成編號  201008251145409865
        /// </summary>
        /// <returns></returns>
        public static string CreateNo()
        {
            Random random = new Random();
            string strRandom = random.Next(1000, 10000).ToString(); //生成編號 
            string code = DateTime.Now.ToString("yyyyMMddHHmmss") + strRandom;//形如
            return code;
        }

        private void Log(string msg)
        {
            System.IO.File.AppendAllText(@"C:\Temp\log.txt", msg + Environment.NewLine);
        }
    }
}