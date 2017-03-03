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

namespace CCM.Web.EIP
{
    public class SendMailTask : IJob
    {

        public void Execute(IJobExecutionContext context)
        {
            //DoSendMail();
            DoSendMail_WaitSign();
        }

        public void DoSendMail()
        {
            //SELECT B.EMPLYID,dbo.SF_EMP_NAME(B.EMPLYID) EMPLYNM,B.EMPLYID + '@ccm3s.com' EMAIL,COUNT(*) WAITSIGN
            //   FROM WF_SIGNM A JOIN WF_SIGND B ON A.SID = B.PSID
            // JOIN VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
            // JOIN HRSDBR53.dbo.HR_OVRTM M ON M.OVRTNO = A.DOCID
            // AND A.STATUS = 'SN' AND B.STATUS = 'SN'
            // AND B.SITEID = (SELECT MIN(SITEID) FROM WF_SIGND BB JOIN WF_SIGNM AA ON BB.PSID = AA.SID WHERE AA.DOCID = A.DOCID AND BB.STATUS = 'SN' ) 
            //GROUP BY B.EMPLYID

            Log("Entering DoSendMail() at " + DateTime.Now.ToString());
            // 發送 email。這裡只固定輸出一筆文字訊息至 log 檔案，方便觀察測試。
            // 每發送一封 email 就檢查一次 IntervalTask.Current.SuttingDown 以配合外部的終止事件。
            string msg = String.Format("DoSendMail() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
            Log(msg);
            Thread.Sleep(2000);
        }

        #region 寄送未簽核通知
        public void DoSendMail_WaitSign() {
            string v_sql = "SELECT B.EMPLYID,dbo.SF_EMP_NAME(B.EMPLYID) EMPLYNM,B.EMPLYID + '@ccm3s.com' EMAIL,COUNT(*) WAITSIGN "+
                         "  FROM WF_SIGNM A JOIN WF_SIGND B ON A.SID = B.PSID " +
                         " JOIN VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                         " JOIN HRSDBR53.dbo.HR_OVRTM M ON M.OVRTNO = A.DOCID " +
                         " AND A.STATUS = 'SN' AND B.STATUS = 'SN' " +
                         " AND B.SITEID = (SELECT MIN(SITEID) FROM WF_SIGND BB JOIN WF_SIGNM AA ON BB.PSID = AA.SID WHERE AA.DOCID = A.DOCID AND BB.STATUS = 'SN' )  " +
                         " GROUP BY B.EMPLYID ";
           
            string v_message = "";
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
                            //v_message = "您好:<BR/>底下為未簽核清單，請上EIP作簽核 <a href='http://192.168.100.13/Home/Index'>點我進入EIP</a>"+
                            //    "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>主管</td>"+
                            //    "<td style='width:150px;text-align:center;border: 1px solid black'>未簽核加班單</td></tr>";
                            //while (dr.Read())
                            //{
                            //    v_message += "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["EMPLYNM"].ToString()+ "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["WAITSIGN"].ToString() + "</td></tr>";
                            //}
                            //v_message += "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。";
                            //SendMail(v_message);

                            while (dr.Read())
                            {
                                v_message = "您好:<BR/>底下為未簽核清單，請上EIP作簽核  <a href='http://192.168.100.13/Home/Index'>點我進入EIP</a><br>" +
                                     "<table style='border-collapse:collapse'><tr><td style='width:150px;text-align:center;border: 1px solid black'>主管</td>" +
                                     "<td style='width:150px;text-align:center;border: 1px solid black'>未簽核加班單</td></tr>" +
                                     "<tr><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["EMPLYNM"].ToString() + "</td><td style='width:100px;text-align:center;border: 1px solid black'>" + dr["WAITSIGN"].ToString() + "</td></tr>" +
                                     "</table><br><br> 注意:此郵件由系統自動發送，請勿直接回覆。";
                                var mailto = dr["EMAIL"].ToString();
                                SendMail(mailto, v_message);
                            }
                            Thread.Sleep(2000);
                        }
                    }

                }

            }
        }
        #endregion

        public void SendMail(string mailto,string vBody) {
            string[] _mailAddress = { mailto };
            string[] _mailBcc = { "b050502@ccm3s.com"};
            string _subject, _body;
            //ArrayList _AttachfilePathlist = new ArrayList();
            _subject = "[通知] 您有未簽核單據 "+  DateTime.Now.ToString("yyyy-MM-dd HH:mm");
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
            foreach (string s in _mailBcc)
            {
                if (s != null)
                    mm.Bcc.Add(new MailAddress(s));
            }
            
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