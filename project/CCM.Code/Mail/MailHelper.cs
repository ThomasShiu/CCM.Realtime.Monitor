/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM
 * Description: CCM快速開發平臺
 * Website：http://www.ccm3s.com/
*********************************************************************************/
using System;
using System.Net;
using System.Net.Mail;
using System.Text;
using System.Threading;

namespace CCM.Code
{
    public class MailHelper
    {
        /// <summary>
        /// 郵件伺服器地址
        /// </summary>
        public string MailServer { get; set; }
        /// <summary>
        /// 用戶名
        /// </summary>
        public string MailUserName { get; set; }
        /// <summary>
        /// 密碼
        /// </summary>
        public string MailPassword { get; set; }
        /// <summary>
        /// 名稱
        /// </summary>
        public string MailName { get; set; }

        /// <summary>
        /// 同步發送郵件
        /// </summary>
        /// <param name="to">收件人郵箱地址</param>
        /// <param name="subject">主題</param>
        /// <param name="body">內容</param>
        /// <param name="encoding">編碼</param>
        /// <param name="isBodyHtml">是否Html</param>
        /// <param name="enableSsl">是否SSL加密連接</param>
        /// <returns>是否成功</returns>
        public bool Send(string to, string subject, string body, string encoding = "UTF-8", bool isBodyHtml = true, bool enableSsl = false)
        {
            try
            {
                MailMessage message = new MailMessage();
                // 接收人郵箱位址
                message.To.Add(new MailAddress(to));
                message.From = new MailAddress(MailUserName, MailName);
                message.BodyEncoding = Encoding.GetEncoding(encoding);
                message.Body = body;
                //GB2312
                message.SubjectEncoding = Encoding.GetEncoding(encoding);
                message.Subject = subject;
                message.IsBodyHtml = isBodyHtml;

                SmtpClient smtpclient = new SmtpClient(MailServer, 25);
                smtpclient.Credentials = new System.Net.NetworkCredential(MailUserName, MailPassword);
                //SSL連接
                smtpclient.EnableSsl = enableSsl;
                smtpclient.Send(message);
                return true;
            }
            catch (Exception)
            {
                throw;
            }
        }
        /// <summary>
        /// 非同步發送郵件 獨立執行緒
        /// </summary>
        /// <param name="to">郵件接收人</param>
        /// <param name="title">郵件標題</param>
        /// <param name="body">郵件內容</param>
        /// <param name="port">埠號</param>
        /// <returns></returns>
        public void SendByThread(string to, string title, string body, int port = 25)
        {
            new Thread(new ThreadStart(delegate ()
            {
                try
                {
                    SmtpClient smtp = new SmtpClient();
                    //郵箱的smtp地址
                    smtp.Host = MailServer;
                    //埠號
                    smtp.Port = port;
                    //構建寄件者的身份憑據類
                    smtp.Credentials = new NetworkCredential(MailUserName, MailPassword);
                    //構建消息類
                    MailMessage objMailMessage = new MailMessage();
                    //設置優先順序
                    objMailMessage.Priority = MailPriority.High;
                    //消息發送人
                    objMailMessage.From = new MailAddress(MailUserName, MailName, System.Text.Encoding.UTF8);
                    //收件人
                    objMailMessage.To.Add(to);
                    //標題
                    objMailMessage.Subject = title.Trim();
                    //標題字元編碼
                    objMailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
                    //正文
                    objMailMessage.Body = body.Trim();
                    objMailMessage.IsBodyHtml = true;
                    //內容字元編碼
                    objMailMessage.BodyEncoding = System.Text.Encoding.UTF8;
                    //發送
                    smtp.Send(objMailMessage);
                }
                catch (Exception)
                {
                    throw;
                }

            })).Start();
        }
    }
}

