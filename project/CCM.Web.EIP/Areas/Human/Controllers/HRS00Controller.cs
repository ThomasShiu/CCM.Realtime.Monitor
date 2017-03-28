/*******************************************************************************
 * Copyright © 2016 CCM.Framework 版權所有
 * Author: CCM.MIS 徐世宇
 * Description: CCM,MIS 快速開發平臺
 * Website：http://www.ccm3s.com
*********************************************************************************/
using CCM.Application;
using CCM.Code;
using System.Web.Mvc;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.Collections;
using System.Collections.Generic;
using System;
using System.Text;
using System.Data.SqlClient;
using System.Configuration;

namespace CCM.Web.EIP.Areas.Human.Controllers
{
    public class HRS00Controller : ControllerBase
    {
        //
        // GET: /Human/HRS00/

        private HR_DEPApp DepApp = new HR_DEPApp();
        private CcmServices cs = new CcmServices();

        // 部門
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHR_DEP(string keyword)
        {
            var data = DepApp.GetList(keyword);
            return Content(data.ToJson());
        }
        private HR_EMPLYMApp EmplyApp = new HR_EMPLYMApp();

        // 員工
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHR_EMPLY(string keyword)
        {
            //var data = EmplyApp.GetList(keyword);
            var data = EmplyApp.GetListActDep(keyword);
            return Content(data.ToJson());
        }

        // 所有員工
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHR_EMPLY_ALL(string keyword)
        {
            //var data = EmplyApp.GetList(keyword);
            var data = EmplyApp.GetListAllEmp(keyword);
            return Content(data.ToJson());
        }

        CCM_Main_EmployeeApp CCM_EmpApp = new CCM_Main_EmployeeApp();
        // 員工
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetCCM_EMP(string keyword)
        {
            //var data = EmplyApp.GetList(keyword);
            var data = CCM_EmpApp.GetList(keyword);
            return Content(data.ToJson());
        }

        WF_RULEMApp rulemApp = new WF_RULEMApp();
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetRULEM(string keyword)
        {
            var data = rulemApp.GetList(keyword);
            return Content(data.ToJson());
        }

        // 部門主管 
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetHeads(string queryJson)
        {
            var data = cs.getHeadsList();

            //var data = tableApp.GetList(keyword);
            return Content(data);
        }

        // 判斷 平日/工作日
        [HttpGet]
        [HandlerAjaxOnly]
        public ActionResult GetSFT_NO(string queryJson)
        {
            bool v_YN = cs.GetSFT_NO(queryJson);
            string result = v_YN ? "Y" : "N";

            //var data = tableApp.GetList(keyword);
            return Content(result);
        }

        #region 匯出PDF薪資單
        public ActionResult GetPdfFile(string keyValue)
        {
            string SQL = " SELECT SID, YYYYMM, EMPLYID, EMPLYNM, PIDNO, DEPID, DEPNM, FA_NO, COMID,0 CP_LIS_EXP,0 CP_EIS_EXP,0 CP_HIS_EXP,0 CP_LPS_EXP, "+
                "    0 LIS_SLY,0 EIS_SLY,0 HIS_SLY,0 LPS_SLY,0 LIS_EXP,0 EIS_EXP,0 HIS_EXP,0 ADD_EXP,0 LPS_EXP,0 OVT1_HR,0 OVT2_HR,0 OVT3_HR,0 HLD_HR,0 FRL_DAY,0 LATE_NN, "+
                "    0 LATE_CT,0 ALP_RT,0 BAS_SLY,0 ALP_RWD,0 FRE_OVT,0 TAX_OVT,0 MNS_FRL,0 MNS_TAX,0 TAX_INC,0 AMT,0 REL_MON_DAY,0 FIX_MON_DAY,0 LAK_MON_DAY,0 HIS_EXP_PRC, "+
                "    0 LAK_MON_AMT,0 OVT1_HR_FT,0 OVT2_HR_FT,0 HLD_HR_FT,0 OVT_HR,0 HR_AMT1,0 HR_AMT2,0 FT_HLD_AMT,0 IT_HLD_AMT,0 FFRE_OVT,0 FTAX_OVT,0 FAMT,0 LATE_EXP "+
                " FROM EIP.dbo.V_HR_EMPPAYMT "+
                " WHERE SID = @SID ";
            string YYYYMM = "", EMPLYID = "", EMPLYNM = "", PIDNO = "", DEPNM = "", AMT = "", CP_LIS_EXP = "", CP_EIS_EXP = "", CP_HIS_EXP = "", CP_LPS_EXP = "",
                LIS_SLY = "", EIS_SLY = "", HIS_SLY = "", LPS_SLY = "", LIS_EXP = "", EIS_EXP = "", HIS_EXP = "", ADD_EXP = "";//, OVT1_HR="", OVT2_HR="", OVT3_HR="", HLD_HR="";

            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    command.Parameters.AddWithValue("@SID", keyValue);
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                YYYYMM = dr["YYYYMM"].ToString();
                                EMPLYID = dr["EMPLYID"].ToString();
                                EMPLYNM = dr["EMPLYNM"].ToString();
                                PIDNO = dr["PIDNO"].ToString();
                                DEPNM = dr["DEPNM"].ToString();
                                AMT = string.Format("{0:n0}", dr["AMT"]);
                                CP_LIS_EXP = string.Format("{0:n0}", dr["CP_LIS_EXP"]); //公司勞保費
                                CP_EIS_EXP = string.Format("{0:n0}", dr["CP_EIS_EXP"]); //公司就保費
                                CP_HIS_EXP = string.Format("{0:n0}", dr["CP_HIS_EXP"]); //公司健保費
                                CP_LPS_EXP = string.Format("{0:n0}", dr["CP_LPS_EXP"]); //提撥退休金

                                LIS_SLY = string.Format("{0:n0}", dr["LIS_SLY"]); 
                                EIS_SLY = string.Format("{0:n0}", dr["EIS_SLY"]); 
                                HIS_SLY = string.Format("{0:n0}", dr["HIS_SLY"]); 
                                LPS_SLY = string.Format("{0:n0}", dr["LPS_SLY"]); 

                                LIS_EXP = string.Format("{0:n0}", dr["LIS_EXP"]); 
                                EIS_EXP = string.Format("{0:n0}", dr["EIS_EXP"]); 
                                HIS_EXP = string.Format("{0:n0}", dr["HIS_EXP"]);
                                ADD_EXP = string.Format("{0:n0}", dr["ADD_EXP"]);
                            }

                        }
                    }

                }

            }

            string filename = CommonCCm.GuId();
            // 實體檔案
            Document doc1 = new Document(PageSize.A4, 50, 50, 80, 50);
            string path = Server.MapPath("~/EIPContent/Content/FilesCabinet/EmpPayrollPdf/");
            PdfWriter pdfWriter = PdfWriter.GetInstance(doc1, new FileStream(path + filename + ".pdf", FileMode.Create));

            // 存在記憶體
            MemoryStream workStream = new MemoryStream();
            PdfWriter.GetInstance(doc1, workStream).CloseStream = false;

            // 字型設定
            BaseFont bfChinese = BaseFont.CreateFont(@"C:\WINDOWS\Fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
            Font chFont = new Font(bfChinese, 12);
            Font chFont_title = new Font(bfChinese, 18);
            Font chFont_blue = new Font(bfChinese, 20, Font.NORMAL, new BaseColor(0, 102, 255));
            Font chFont_red = new Font(bfChinese, 20, Font.NORMAL, new BaseColor(255, 0, 0));
            Font chFont_msg = new Font(bfChinese, 12, Font.ITALIC, BaseColor.RED);

            //取得圖檔
            string image_url = "http://192.168.100.13/Content/img/LOGOs-1.png";
            Image jpg = Image.GetInstance(new Uri(image_url));
            // 設定圖檔的縮放大小
            jpg.ScaleToFit(95f, 47f);
            Paragraph para = new Paragraph();
            para.Leading = 15;
            iTextSharp.text.Image logoJPG = iTextSharp.text.Image.GetInstance(jpg);
            // 調整圖片大小
            logoJPG.ScalePercent(50f);
            // 圖片位置
            logoJPG.SetAbsolutePosition(150, 800);
          

            // 建立表格
            PdfPTable table = new PdfPTable(new float[] { 2,1,2,1});
            table.TotalWidth = 550f;
            table.LockedWidth = true;
            PdfPCell header = new PdfPCell(new Phrase("薪資年月:" + YYYYMM + "               姓名:" + EMPLYID + " - " + EMPLYNM+
                                        "              製表日期:" + DateTime.Now.ToString("yyyy-MM-dd HH:mm"), chFont));
            header.Colspan = 4;
            header.FixedHeight = 28.0f;
            header.HorizontalAlignment = Element.ALIGN_LEFT;
            header.VerticalAlignment = Element.ALIGN_MIDDLE;
            table.AddCell(header);

            table.AddCell(new Phrase("公司健保費", chFont));
            PdfPCell cell_1 = new PdfPCell(new Phrase(CP_HIS_EXP));
            cell_1.FixedHeight = 24.0f;
            cell_1.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_1);

            table.AddCell(new Phrase("公司勞保費", chFont));
            PdfPCell cell_2 = new PdfPCell(new Phrase(CP_LIS_EXP));
            cell_2.FixedHeight = 24.0f;
            cell_2.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_2);

            table.AddCell(new Phrase("公司就保費", chFont));
            PdfPCell cell_3 = new PdfPCell(new Phrase(CP_EIS_EXP));
            cell_3.FixedHeight = 24.0f;
            cell_3.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_3);

            table.AddCell(new Phrase("提撥退休金", chFont));
            PdfPCell cell_4 = new PdfPCell(new Phrase(CP_LPS_EXP));
            cell_4.FixedHeight = 24.0f;
            cell_4.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_4);

            table.AddCell(new Phrase("勞保費", chFont));
            PdfPCell cell_5 = new PdfPCell(new Phrase(LIS_EXP));
            cell_5.FixedHeight = 24.0f;
            cell_5.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_5);

            table.AddCell(new Phrase("就保費", chFont));
            PdfPCell cell_6 = new PdfPCell(new Phrase(EIS_EXP));
            cell_6.FixedHeight = 24.0f;
            cell_6.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_6);

            table.AddCell(new Phrase("健保費", chFont));
            PdfPCell cell_7 = new PdfPCell(new Phrase(HIS_EXP));
            cell_7.FixedHeight = 24.0f;
            cell_7.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_7);

            table.AddCell(new Phrase("補充保費", chFont));
            PdfPCell cell_8 = new PdfPCell(new Phrase(ADD_EXP));
            cell_8.FixedHeight = 24.0f;
            cell_8.HorizontalAlignment = Element.ALIGN_RIGHT;
            table.AddCell(cell_8);

            //table.AddCell(new Phrase("DEMO", chFont));
            PdfPCell cell_9 = new PdfPCell(new Phrase("僅供測試...(略)", chFont_red));
            cell_9.Colspan = 4;
            cell_9.FixedHeight = 24.0f;
            cell_9.HorizontalAlignment = Element.ALIGN_CENTER;
            table.AddCell(cell_9);

            table.AddCell(new Phrase("實領薪資", chFont));
            PdfPCell content_amt = new PdfPCell(new Phrase(AMT));
            content_amt.Colspan = 5;
            content_amt.FixedHeight = 24.0f;
            content_amt.HorizontalAlignment = Element.ALIGN_CENTER;
            content_amt.VerticalAlignment = Element.ALIGN_MIDDLE;
            table.AddCell(content_amt);

            doc1.Open();
            // 標題
            Phrase content_title = new Phrase("精湛光學 - 員工薪資單", chFont_title);
            PdfContentByte ConByte_Up = pdfWriter.DirectContent;
            ColumnText.ShowTextAligned(ConByte_Up, Element.ALIGN_LEFT, content_title, 220, 805, 0);
            Phrase content_title2 = new Phrase("感謝您的辛勞~", chFont_title);
            PdfContentByte ConByte_Up2 = pdfWriter.DirectContent;
            ColumnText.ShowTextAligned(ConByte_Up2, Element.ALIGN_LEFT, content_title2, 250, 780, 0);
            //doc1.Add(pg1);  // 插入段落
            doc1.Add(table); //插入表格
            doc1.Add(logoJPG);
            doc1.Close();

            byte[] byteInfo = workStream.ToArray();
            workStream.Write(byteInfo, 0, byteInfo.Length);
            workStream.Position = 0;

            // 浮水印
            string oldFile = Server.MapPath("~/EIPContent/Content/FilesCabinet/EmpPayrollPdf/" + filename + ".pdf"); //"oldFile.pdf";
            string newFile = oldFile.Replace(".pdf", "_New.pdf");
            PdfReader PDFReader = new PdfReader(oldFile);
            FileStream Stream = new FileStream(newFile, FileMode.Create, FileAccess.Write);

            PdfStamper PDFStamper = new PdfStamper(PDFReader, Stream);

            for (int iCount = 0; iCount < PDFStamper.Reader.NumberOfPages; iCount++)
            {
                PdfContentByte PDFData = PDFStamper.GetOverContent(iCount + 1);
                PdfGState gs1 = new PdfGState();
                gs1.FillOpacity = 0.25f;
                
                //BaseFont baseFont = BaseFont.CreateFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.EMBEDDED);
                BaseFont baseFont = BaseFont.CreateFont(@"C:\WINDOWS\Fonts\kaiu.ttf", BaseFont.IDENTITY_H, BaseFont.NOT_EMBEDDED);
                PDFData.BeginText();
                PDFData.SetGState(gs1);
                PDFData.SetColorFill(CMYKColor.LIGHT_GRAY);
                PDFData.SetFontAndSize(baseFont, 50);
                PDFData.ShowTextAligned(PdfContentByte.ALIGN_CENTER, "精湛光學機密資料", 260, 400 + 240f, 45);
                PDFData.ShowTextAligned(PdfContentByte.ALIGN_CENTER, "製表:"+ EMPLYNM, 340, 400 + 240f, 45);
                PDFData.EndText();
            }
            
            PDFStamper.Close();
            PDFReader.Close();

            // 重新讀取實體PDF
            MemoryStream ms = new MemoryStream();
            using (FileStream fs = System.IO.File.OpenRead(newFile))
            {
                fs.CopyTo(ms);
            }
            // 加密，預設為身分字號
            PDFReader = new PdfReader(newFile);
            PdfEncryptor.Encrypt(PDFReader, ms, true, "6937937", PIDNO, 1);
            PDFReader.Close();

            // 下載
            Response.Clear();
            Response.AddHeader("Content-Disposition","attactment;filename="+ filename+ ".pdf");
            Response.ContentType = "application/octet-stream";
            Response.OutputStream.Write(ms.GetBuffer(),0, ms.GetBuffer().Length);
            //Response.OutputStream.Write(Stream.GetBuffer(),0, Stream.GetBuffer().Length);
            Response.OutputStream.Flush();
            Response.OutputStream.Close();
            Response.Flush();
            Response.End();

            return View("test");
            //return File(doc1.ToDate,doc1.con);
        }
        #endregion
    }
}
