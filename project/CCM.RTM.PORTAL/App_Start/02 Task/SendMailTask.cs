using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Text;
using System.Threading;
using System.Web;

namespace CCM.RTM.PORTAL
{
    public class SendMailTask : IJob
    {
        private bool vDebug = false;
        public void Execute(IJobExecutionContext context)
        {
            //DoSendMail();
            DoSendMail_WaitSign();
            DoSendMail_OverTime();
        }


        #region 寄送未簽核通知
        public void DoSendMail_WaitSign() {
            string v_sql = "SELECT B.EMPLYID,dbo.SF_EMP_NAME(B.EMPLYID) EMPLYNM,B.EMPLYID + '@ccm3s.com' EMAIL,COUNT(*) WAITSIGN "+
                         "  FROM WF_SIGNM A JOIN WF_SIGND B ON A.SID = B.PSID " +
                         " JOIN VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                         " JOIN HRSDBR53.dbo.HR_OVRTM M ON M.OVRTNO = A.DOCID " +
                         " AND A.STATUS = 'SN' AND B.STATUS = 'SN' " +
                         " AND B.SITEID = (SELECT MIN(SITEID) FROM WF_SIGND BB JOIN WF_SIGNM AA ON BB.PSID = AA.SID WHERE AA.DOCID = A.DOCID AND BB.STATUS = 'SN' )  " +
                         " GROUP BY B.EMPLYID ORDER BY 4 DESC ";
           
            string v_message = "", v_message_all = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(v_sql, conn))
                {
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {

                            v_message_all = "您好:<BR/>底下為未簽核清單。" +
                                "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>主管</td>" +
                                "<td style='width:150px;text-align:center;border: 1px solid black'>未簽核加班單</td></tr>";

                            var vSubject = "[通知] 未簽核清單 " + DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                            while (dr.Read())
                            {
                                v_message_all += "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["EMPLYNM"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["WAITSIGN"].ToString() + "</td></tr>";
                                v_message = "您好:<BR/>底下為未簽核清單，請上EIP作簽核  <a href='http://192.168.100.13/Home/Index'>點我進入EIP</a><br>" +
                                     "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>主管</td>" +
                                     "<td style='width:150px;text-align:center;border: 1px solid black'>未簽核加班單</td></tr>" +
                                     "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["EMPLYNM"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["WAITSIGN"].ToString() + "</td></tr>" +
                                     "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。<a href='http://192.168.100.13/Home/Index'>EIP</a><br>";
                                var mailto = dr["EMAIL"].ToString();
                                // 通知各部門主管
                                if (!vDebug) SendMail(mailto,vSubject, v_message);    
                            }
                            v_message_all += "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。 <a href='http://192.168.100.13/Home/Index'>點我進入EIP</a>";
                            SendMail("b050502@ccm3s.com", vSubject, v_message_all);
                            if (!vDebug) SendMail("a970202@ccm3s.com", vSubject, v_message_all);  // 黃淑慧
                            if (!vDebug) SendMail("b060207 @ccm3s.com", vSubject, v_message_all); // 劉珊妤
                            
                            string msg = String.Format("DoSendMail_WaitSign() at {0:yyyy/MM/dd HH:mm:ss} - 192.168.100.13", DateTime.Now);
                            Log(msg);
                            Thread.Sleep(500);
                        }
                    }

                }

            }
        }
        #endregion

        #region 寄送加班統計
        public void DoSendMail_OverTime()
        {
            string v_sql = "  SELECT A.OWMON,A.DEPID,A.DEPNM,A.REHRS1,(B.EMPLYID+'@CCM3S.COM') EMAIL "+
                            " FROM( " +
                            "   SELECT A.OWMON, A.DEPID, dbo.SF_GETDEPTBYDEPT(A.DEPID) DEPNM, SUM(A.REHRS1) REHRS1 " +
                            "   FROM HRSDBR53.dbo.HR_OVRTM A " +
                            "   WHERE 1 = 1 " +
                            "   AND A.STATUS IN('CF', 'SN') " +
                            "   AND  OWMON = CONVERT(VARCHAR(6), GETDATE(), 112) " +
                            "   GROUP BY A.OWMON, A.DEPID, dbo.SF_GETDEPTBYDEPT(A.DEPID) " +
                            " ) A,HRSDBR53.dbo.HR_DEP B " +
                            " WHERE A.DEPID = B.DEPID " +
                            " ORDER BY 4 DESC ";

            string v_message = "", v_message_all = "", mailto = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(v_sql, conn))
                {
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {

                            v_message_all = "您好:<BR/>底下為加班申請統計表。" +
                                "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>部門代碼</td>" +
                                "<td style='width:250px;text-align:center;border: 1px solid black'>部門名稱</td>" +
                                "<td style='width:150px;text-align:center;border: 1px solid black'>加班時數</td></tr>";

                            while (dr.Read())
                            {
                                v_message_all += "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["DEPID"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["DEPNM"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["REHRS1"].ToString() + "</td></tr>";
                                v_message = "您好:<BR/>底下為加班申請統計表  " +
                                        "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>部門代碼</td>" +
                                        "<td style='width:150px;text-align:center;border: 1px solid black'>部門名稱</td>" +
                                        "<td style='width:150px;text-align:center;border: 1px solid black'>加班時數</td></tr>"+
                                        "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["DEPID"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["DEPNM"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["REHRS1"].ToString() + "</td></tr>" +
                                        "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。";
                                mailto = dr["EMAIL"].ToString();
                            }
                            v_message_all += "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。 <a href='http://192.168.100.13/Home/Index'>點我進入EIP</a>";
                            var vSubject = "[通知] 加班時數統計 " + DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                            if (!vDebug) SendMail("b020503@ccm3s.com", vSubject, v_message_all); // 陳雅平
                            SendMail("b050502@ccm3s.com", vSubject, v_message_all);

                            string msg = String.Format("DoSendMail_OverTime() at {0:yyyy/MM/dd HH:mm:ss} - 192.168.100.13", DateTime.Now);
                            Log(msg);
                            Thread.Sleep(500);
                        }
                    }

                }

            }

            DateTime FirstDay = DateTime.Now.AddDays(-DateTime.Now.Day + 1);
            DateTime LastDay = DateTime.Now.AddMonths(1).AddDays(-DateTime.Now.AddMonths(1).Day);
            string lastday = LastDay.ToString("yyyy-MM-dd");
            string today = DateTime.Now.ToString("yyyy-MM-dd");
            string day = DateTime.Now.DayOfWeek.ToString("d"); //day 0=日 ,1=1,2=2,3=3,4=4,5=5,6=6 
            //if (today.Equals("lastday"))
            if (day.Equals("5"))  // 每周五寄發
            {
                // 每月加班統計表，通知各部門主管
                // 有加班時數的各部門主管清單
                v_sql = " SELECT DISTINCT B.EMPLYID,dbo.SF_EMP_NAME(B.EMPLYID) EMPLYNM,(B.EMPLYID+'@CCM3S.COM') EMAIL " +
                        " FROM( " +
                        "    SELECT A.OWMON, A.DEPID, dbo.SF_GETDEPTBYDEPT(A.DEPID) DEPNM, SUM(A.REHRS1) REHRS1 " +
                        "    FROM HRSDBR53.dbo.HR_OVRTM A " +
                        "    WHERE 1 = 1 " +
                        "    AND A.STATUS IN('CF', 'SN') " +
                        "    AND  OWMON = CONVERT(VARCHAR(6), GETDATE(), 112) " +
                        "    GROUP BY A.OWMON, A.DEPID, dbo.SF_GETDEPTBYDEPT(A.DEPID) " +
                        "  ) A,HRSDBR53.dbo.HR_DEP B " +
                        "  WHERE A.DEPID = B.DEPID " +
                        "  ORDER BY 1 DESC ";
                //1.引用SqlConnection物件連接資料庫
                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
                {
                    //2.開啟資料庫
                    conn.Open();
                    //3.引用SqlCommand物件
                    using (SqlCommand command = new SqlCommand(v_sql, conn))
                    {
                        //4.搭配SqlCommand物件使用SqlDataReader
                        using (SqlDataReader dr = command.ExecuteReader())
                        {
                            if (dr.HasRows)
                            {
                                while (dr.Read())
                                {
                                    v_sql = "  SELECT A.OWMON,A.DEPID,A.DEPNM,A.REHRS1,A.EMPLYID,A.EMPLYNM,B.EMPLYID MEMPLYID,dbo.SF_EMP_NAME(B.EMPLYID) MEMPLYNM,(B.EMPLYID+'@CCM3S.COM') EMAIL  " +
                                            "  FROM( " +
                                            "    SELECT A.OWMON, A.DEPID, dbo.SF_GETDEPTBYDEPT(A.DEPID) DEPNM, A.EMPLYID, dbo.SF_EMP_NAME(A.EMPLYID) EMPLYNM, SUM(A.REHRS1) REHRS1 " +
                                            "    FROM HRSDBR53.dbo.HR_OVRTM A " +
                                            "    WHERE 1 = 1 " +
                                            "    AND A.STATUS IN('CF', 'SN') " +
                                            "    AND  OWMON = CONVERT(VARCHAR(6), GETDATE(), 112) " +
                                            "    GROUP BY A.OWMON, A.DEPID, A.EMPLYID, dbo.SF_GETDEPTBYDEPT(A.DEPID) " +
                                            "  ) A,HRSDBR53.dbo.HR_DEP B " +
                                            "  WHERE A.DEPID = B.DEPID " +
                                            "  AND B.EMPLYID = '"+ dr["EMPLYID"].ToString() + "' " +
                                            "  ORDER BY 4 DESC ";
                                    //1.引用SqlConnection物件連接資料庫
                                    using (SqlConnection conn2 = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
                                    {
                                        //2.開啟資料庫
                                        conn2.Open();
                                        //3.引用SqlCommand物件
                                        using (SqlCommand command2 = new SqlCommand(v_sql, conn2))
                                        {
                                            //4.搭配SqlCommand物件使用SqlDataReader
                                            using (SqlDataReader dr2 = command2.ExecuteReader())
                                            {
                                                if (dr2.HasRows)
                                                {
                                                    v_message = "您好:<BR/>底下為截至目前為止，加班申請時數統計表  " +
                                                                "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>部門代碼</td>" +
                                                                "<td style='width:250px;text-align:center;border: 1px solid black'>部門名稱</td>" +
                                                                "<td style='width:150px;text-align:center;border: 1px solid black'>加班人員</td>" +
                                                                "<td style='width:150px;text-align:center;border: 1px solid black'>加班時數</td></tr>";
                                                    while (dr2.Read())
                                                    {
                                                        v_message += "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr2["DEPID"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr2["DEPNM"].ToString() + 
                                                            "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr2["EMPLYNM"].ToString() + "</td>" + "<td style='width:100px;text-align:center;border: 1px solid black'>" + dr2["REHRS1"].ToString() + "</td></tr>";

                                                        mailto = dr2["EMAIL"].ToString();
                                                    }
                                                    v_message += "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。";
                                                }

                                                var vSubject = "[通知] 每月加班時數統計 " + DateTime.Now.ToString("yyyy-MM-dd HH:mm");
                                                if (!vDebug) SendMail(mailto, vSubject, v_message);
                                                SendMail("b050502@ccm3s.com", vSubject, v_message);

                                                string msg = String.Format("DoSendMail_OverTime() at {0:yyyy/MM/dd HH:mm:ss} - 192.168.100.13", DateTime.Now);
                                                Log(msg);
                                                Thread.Sleep(500);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        #endregion

        public void SendMail(string mailto,string vSubject,string vBody) {
            string[] _mailAddress = { mailto  };
            //string[] _mailBcc = { "b050502@ccm3s.com" };
            string _subject, _body;
            //ArrayList _AttachfilePathlist = new ArrayList();
            _subject = vSubject; // "[通知] 加班時數統計 " +  DateTime.Now.ToString("yyyy-MM-dd HH:mm");
            _body = vBody;
            //MailReport(_ms, _mailAddress, _subject, _body, _AttachfilePathlist);
            SmtpClient client = new SmtpClient();
            client.Port = 25;
            client.Host = "ccm-ad.ccm3s.com";
            client.EnableSsl = true;
            client.Timeout = 60000;//1分鐘
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential("erpsys@ccm3s.com", "manager");

            MailMessage mm = new MailMessage();
            mm.IsBodyHtml = true;
            mm.From = new MailAddress("erpsys@ccm3s.com");

            foreach (string s in _mailAddress)
            {
                if (s != null)
                    mm.To.Add(new MailAddress(s));
               
            }
            //foreach (string s in _mailBcc)
            //{
            //    if (s != null)
            //        mm.Bcc.Add(new MailAddress(s));
            //}

            mm.Subject = _subject;
            mm.Body = _body;

            mm.BodyEncoding = Encoding.GetEncoding("utf-8");
            mm.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;

            try
            {
                client.Send(mm);
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {

            }
        }
       

        public void DoSendMailReport()
        {
            Log("Entering DoSendMail() at " + DateTime.Now.ToString());
            // 發送 email。這裡只固定輸出一筆文字訊息至 log 檔案，方便觀察測試。
            // 每發送一封 email 就檢查一次 IntervalTask.Current.SuttingDown 以配合外部的終止事件。
            string msg = String.Format("DoSendMail() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
            Log(msg);
            Thread.Sleep(2000);
        }

        private void Log(string msg)
        {
            System.IO.File.AppendAllText(@"C:\Temp\log.txt", msg + Environment.NewLine);
        }
    }
}