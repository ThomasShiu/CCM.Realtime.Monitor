using CCM.Code;
using CCM.Domain;
using CCM.Repository;
using Microsoft.Reporting.WebForms;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net.Mail;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using System.Drawing.Imaging;
using System.Drawing;
using System.Web;
using System.Net.Mime;
using OfficeOpenXml;

namespace CCM.Application
{
    public class CcmServices
    {
        public static string v_RTDBContext = "ccm_rtdb";
       

        #region 把DataTable轉成JSON字串
        //把DataTable轉成JSON字串
        public string GetJson(string sql)
        {
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(sql);
            //將DataTable轉成JSON字串
            string str_json = JsonConvert.SerializeObject(dt, Formatting.Indented);
            //string str_json = JsonConvert.SerializeObject(dt);
            return str_json;

        }
        #endregion

        #region 回傳DataTable物件
        /// <summary>
        /// 依據SQL語句，回傳DataTable物件
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public DataTable queryDataTable(string sql)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_RTDBContext].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.Fill(ds);
            }

            return ds.Tables.Count > 0 ? ds.Tables[0] : new DataTable();

        }
        #endregion

        #region JSON字串轉成DataTable
        //把JSON字串轉成DataTable或Newtonsoft.Json.Linq.JArray
        public DataTable JSONstrToDataTable(string jsonStr)
        {

            //Newtonsoft.Json.Linq.JArray jArray = 
            //    JsonConvert.DeserializeObject<Newtonsoft.Json.Linq.JArray>(li_showData.Text.Trim());
            //或
            DataTable dt = JsonConvert.DeserializeObject<DataTable>(jsonStr);

            return dt;
            //GridView1顯示DataTable的資料
            //GridView1.DataSource = jArray; GridView1.DataBind();
            //GridView1.DataSource = dt; GridView1.DataBind();
        }
        #endregion

        #region 產生單據號碼
        public string GetOrdNo(string v_type, string v_prefix, int v_count = 1)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_RTDBContext].ConnectionString);

            SqlCommand cmd = new SqlCommand("SP_GEN_ORDNO", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@TYPE", SqlDbType.VarChar, 12);
            cmd.Parameters["@TYPE"].Value = v_type;
            cmd.Parameters.Add("@PREFIX", SqlDbType.VarChar, 20);
            cmd.Parameters["@PREFIX"].Value = v_prefix;
            cmd.Parameters.Add("@COUNT", SqlDbType.Int);
            cmd.Parameters["@COUNT"].Value = v_count;
            DataTable dt = new DataTable();
            string v_orderNo = "";
            //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
            //retValParam.Direction = ParameterDirection.Output;

            try
            {
                db.Open();
                dt.Load(cmd.ExecuteReader());
                v_orderNo = dt.Rows[0]["FROM_NO"].ToString();
                //cmd.ExecuteNonQuery();

            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }

            return v_orderNo;
        }
        #endregion

        #region 修改圖片解析度
        public int ImgUploadResize(HttpPostedFileBase file,string directoryPath,string fileNewName)
        {
            string fileName = "";
            string fileExtension = "";
            string filePath = "", fileNewPath="";

            int saveCnt = 0;

            try
            {
                fileName = file.FileName;
                fileExtension = Path.GetExtension(fileName);
                fileNewPath = Path.Combine(directoryPath, fileNewName);
                filePath = Path.Combine(directoryPath, fileName);
                file.SaveAs(filePath);

                System.Drawing.Image image = System.Drawing.Image.FromFile(filePath);
                //必須使用絕對路徑
                ImageFormat thisFormat = image.RawFormat;

            
                //取得影像的格式
                int fixWidth = 0;
                int fixHeight = 0;
                //第一種縮圖用 
                //int maxPx = Convert.ToInt16(ConfigurationManager.AppSettings["maxWidth"]);
                int maxPx = Convert.ToInt16(Configs.GetValue("ImgSize")); // 縮圖
                int maxThumbsPx = Convert.ToInt16(Configs.GetValue("ImgSizeThumbs"));  // 檢視縮圖

                //宣告一個最大值，demo是把該值寫到web.config裡
                if (image.Width > maxPx || image.Height > maxPx)
                //如果圖片的寬大於最大值或高大於最大值就往下執行
                {
                    if (image.Width >= image.Height)
                    //圖片的寬大於圖片的高，橫式照片
                    {
                        fixWidth = maxPx;
                        //設定修改後的圖寬
                        fixHeight = Convert.ToInt32((Convert.ToDouble(fixWidth) / Convert.ToDouble(image.Width)) * Convert.ToDouble(image.Height));
                        //設定修改後的圖高
                    }
                    else
                    {  // 直式照片
                        fixHeight = maxPx;
                        //設定修改後的圖高
                        fixWidth = Convert.ToInt32((Convert.ToDouble(fixHeight) / Convert.ToDouble(image.Height)) * Convert.ToDouble(image.Width));
                        //設定修改後的圖寬
                    }

                }
                else
                //圖片沒有超過設定值，不執行縮圖
                {
                    fixHeight = image.Height;
                    fixWidth = image.Width;
                }
                Bitmap imageOutput = new Bitmap(image, fixWidth, fixHeight);
                if (fixWidth < fixHeight)
                {
                    RotateFlipType rft = RotateFlipType.RotateNoneFlipNone;
                    imageOutput.RotateFlip(rft);
                }
                //輸出一個新圖(就是修改過的圖)
                string fixSaveName = fileNewName;
                //副檔名不應該這樣給，但因為此範例沒有讀取檔案的部份所以demo就直接給啦

                imageOutput.Save(string.Concat(directoryPath, fixSaveName), thisFormat);
                //將修改過的圖存於設定的位子
                imageOutput.Dispose();
                //釋放記憶體
                image.Dispose();
                //釋放掉圖檔 
                System.IO.File.Delete(filePath);
                saveCnt = 1;
            }
            catch (OutOfMemoryException ex)
            {

            }
            catch (FileNotFoundException ex) { }
            catch (AggregateException ex) { }
            catch (Exception ex)
            {
                saveCnt = 0;
                throw ex;
            }

            return saveCnt;
        }
        #endregion

      
    }
}
