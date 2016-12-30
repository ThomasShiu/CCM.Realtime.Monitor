using CCM.Code;
using CCM.Domain;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCM.Application
{
    public class CcmServices
    {
        public static string v_EIPContext = "EIPContext";
        public static string v_HRSContext = "HRSContext";
        // 產生資料集 , Report 報表使用
        public DataTable GetDataSet(string SQL)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = conn.CreateCommand();
            cmd.CommandText = SQL;
            da.SelectCommand = cmd;
            //DataSet ds = new DataSet();

            DataTable dt = new DataTable();


            conn.Open();
            da.Fill(dt);
            conn.Close();

            return dt;
        }

        // 檢查公共物件是否被預約
        public string chkPubObjExistBooking(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity) {
            string SQL = " SELECT A.SID, A.ObjectSID,B.ObjectNM,dbo.SF_EMP_NAME(A.EmployeeID) Empnm,A.Subject,A.BookingStartTime, A.BookingEndTime FROM PO_PUBLIC_OBJECT_BOOKING A,PO_PUBLIC_OBJECT B " +
                         " WHERE A.ObjectSID = B.SID  AND A.ObjectSID = @ObjectSID AND ((@StartTime  BETWEEN  A.BookingStartTime AND A.BookingEndTime ) OR (@EndTime  BETWEEN A.BookingStartTime AND A.BookingEndTime))";
            string SQL2 = " SELECT A.SID, A.ObjectSID,B.ObjectNM,dbo.SF_EMP_NAME(A.EmployeeID) Empnm,A.Subject,A.BookingStartTime, A.BookingEndTime FROM PO_PUBLIC_OBJECT_BOOKING A,PO_PUBLIC_OBJECT B " +
                        " WHERE A.ObjectSID = B.SID  AND ObjectSID = '" + tableEntity.ObjectSID + "' AND (('" + tableEntity.BookingStartTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN  BookingStartTime AND BookingEndTime ) OR ('" + tableEntity.BookingEndTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN BookingStartTime AND BookingEndTime))";
            string v_message = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    //command.Parameters.AddWithValue("@SID", tableEntity.SID);
                    command.Parameters.AddWithValue("@ObjectSID", tableEntity.ObjectSID);
                    command.Parameters.AddWithValue("@StartTime", tableEntity.BookingStartTime);
                    command.Parameters.AddWithValue("@EndTime", tableEntity.BookingEndTime);
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                v_message = "公務車輛:[" + dr["ObjectNM"].ToString() + "]已有:<br/>" + dr["Empnm"].ToString() +
                                    "申請使用[" + dr["Subject"].ToString() + "]<br/>使用時間:[" + dr["BookingStartTime"].ToString() + "]至[" +
                                    dr["BookingEndTime"].ToString() + "]<br/>請重新調整時間再存檔。";
                            }
                            return v_message;
                        }
                    }

                }
                
            }
            return v_message;
        }

        // 檢查加班單時段是否有重複
        public string chkOverTimeDup(HR_OVRTM_TESTEntity tableEntity)
        {
            string SQL = " SELECT A.EMPLYID,B.EMPLYNM,A.OVRTNO, A.FETB , A.FETE, A.DEREASON, A.DEPID,A.OTTP "
                          + " FROM dbo.HR_OVRTM_TEST A LEFT OUTER JOIN dbo.HR_EMPLYM B ON A.EMPLYID = B.EMPLYID "
                          + " WHERE A.EMPLYID = @EMPLYID  AND((@StartTime  BETWEEN  FETB AND FETE) OR(@EndTime  BETWEEN FETB AND FETE)) ";
            string SQL2 = " SELECT A.EMPLYID,B.EMPLYNM,A.OVRTNO, A.FETB , A.FETE, A.DEREASON, A.DEPID,A.OTTP "
                          + " FROM dbo.HR_OVRTM_TEST A LEFT OUTER JOIN dbo.HR_EMPLYM B ON A.EMPLYID = B.EMPLYID "
                          + " WHERE A.EMPLYID = '" + tableEntity.EMPLYID + "'  AND(('" + String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETB) + "'  BETWEEN  FETB AND FETE) OR('" + String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETE) + "'  BETWEEN FETB AND FETE)) ";
            string v_message = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_HRSContext].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    command.Parameters.AddWithValue("@EMPLYID", tableEntity.EMPLYID);
                    command.Parameters.AddWithValue("@StartTime", String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETB) );
                    command.Parameters.AddWithValue("@EndTime"  , String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETE) );
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (dr.HasRows)
                        {
                            while (dr.Read())
                            {
                                v_message = "加班時段重疊，已有加班單!!<br/> 人員:[" + dr["EMPLYNM"].ToString() + "] <br/>申請時間從 [" +
                                             String.Format("{0:yyyy/MM/dd HH:mm}", dr["FETB"].ToDate()) + "]至[" + String.Format("{0:yyyy/MM/dd HH:mm}", dr["FETE"].ToDate()) + "]<br/>請重新確認加班時間再存檔。";
                            }
                            return v_message;
                        }
                    }

                }

            }
            return v_message;
        }
        //把DataTable轉成JSON字串
        public string GetJson(string sql)
        {
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(sql);
            //將DataTable轉成JSON字串
            string str_json = JsonConvert.SerializeObject(dt, Formatting.Indented);

            return str_json;

        }

        /// <summary>
        /// 依據SQL語句，回傳DataTable物件
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        private DataTable queryDataTable(string sql)
        {
            //DB連線字串
            //string connStr = @"Data Source=.\sqlexpress;Initial Catalog=NorthwindChinese;Integrated Security=True";
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString))
            {
                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.Fill(ds);
            }

            return ds.Tables.Count > 0 ? ds.Tables[0] : new DataTable();

        }

        //把JSON字串轉成DataTable或Newtonsoft.Json.Linq.JArray
        protected DataTable JSONstrToDataTable(string jsonStr)
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
    }
}
