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

namespace CCM.Application
{
    public class CcmServices
    {
        public static string v_EIPContext = "EIPContext";
        public static string v_HRSContext = "HRSContext";
        public static string v_HR_OVRTM = "HRSDBR53.dbo.HR_OVRTM_TEST";    // 測試用，轉正式時將_TEST拿掉 
        public static string v_V_WF_SIGNROUTE = "V_WF_SIGNROUTE_TEST";     // 簽核途程清單
        public static string v_SP_GEN_SIGNROUTE = "SP_GEN_SIGNROUTE_TEST"; // 產生簽核途程
        public static string v_SP_SET_SIGNROUTE = "SP_SET_SIGNROUTE_TEST"; // 設定簽核狀態:撤簽、作廢、退回
        public static string v_SP_SET_SIGN = "SP_SET_SIGN_TEST";           // 主管簽核
        public OperatorModel LoginInfo = OperatorProvider.Provider.GetCurrent();

        #region 產生資料集 , Report 報表使用
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
        #endregion

        #region 檢查公共物件是否被預約
        // 檢查公共物件是否被預約
        public string chkPubObjExistBooking(PO_PUBLIC_OBJECT_BOOKINGEntity tableEntity)
        {
            string SQL = " SELECT A.SID, A.ObjectSID,B.ObjectNM,dbo.SF_EMP_NAME(A.EmployeeID) Empnm,A.Subject,A.BookingStartTime, A.BookingEndTime FROM PO_PUBLIC_OBJECT_BOOKING A,PO_PUBLIC_OBJECT B " +
                         " WHERE A.ObjectSID = B.SID  AND A.ObjectSID = @ObjectSID AND ((@StartTime  BETWEEN  A.BookingStartTime AND A.BookingEndTime ) OR (@EndTime  BETWEEN A.BookingStartTime AND A.BookingEndTime)) "+
                         " AND A.Status = '鎖定' ";
            //string SQL2 = " SELECT A.SID, A.ObjectSID,B.ObjectNM,dbo.SF_EMP_NAME(A.EmployeeID) Empnm,A.Subject,A.BookingStartTime, A.BookingEndTime FROM PO_PUBLIC_OBJECT_BOOKING A,PO_PUBLIC_OBJECT B " +
            //            " WHERE A.ObjectSID = B.SID  AND ObjectSID = '" + tableEntity.ObjectSID + "' AND (('" + tableEntity.BookingStartTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN  BookingStartTime AND BookingEndTime ) OR ('" + tableEntity.BookingEndTime.ToString("yyyy/MM/dd HH:mm") + "'  BETWEEN BookingStartTime AND BookingEndTime))";
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
        #endregion

        #region 取得特約廠商
        public JArray GetVendorList()
        {
            string v_sql = "SELECT SID,Name, Phone  FROM EIP.dbo.BU_ORDERS_SOTRE WHERE Phone IS NOT NULL ORDER BY CreatorTime DESC";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SID = p.Field<string>("SID"),
                             NAME = p.Field<string>("Name"),
                             PHONE = p.Field<string>("Phone")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SID",col.SID },
                    {"NAME",col.NAME },
                    {"PHONE",col.PHONE }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得公佈欄
        public JArray GetBulletinList()
        {
            string v_sql = " SELECT BUSubject,convert(varchar(10), StartDate, 111) +' ~ '+convert(varchar(10), EndDate, 111)  Showdate " +
                           "  FROM BU_BULLETIN " +
                           "  WHERE DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) BETWEEN StartDate AND EndDate " +
                           "  ORDER BY StartDate DESC ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             BUSubject = p.Field<string>("BUSubject"),
                             Showdate = p.Field<string>("Showdate")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"BUSubject",col.BUSubject },
                    {"Showdate",col.Showdate }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得守衛清單
        public string getGuardList()
        {
            string v_sql = "SELECT USR_NO, USR_NM, USR_PW, DEPM_NO, DEPM_NM, E_MAIL  FROM PO_GUARDNO";
            string result = GetJson(v_sql);
            return result;
        }
        #endregion

        #region 取得部門主管清單
        public string getHeadsList()
        {
            string v_sql = "SELECT DEPID,DEPNM,EMPLYID,EMPLYNM,(DEPNM+'/'+EMPLYNM) AS REMARK  FROM V_HR_DEP WHERE EMPLYID <> '' ";
            string result = GetJson(v_sql);
            return result;
        }
        #endregion

        #region 取得個人可建立加班部門
        public JArray getOvertDept()
        {
            var UserId = LoginInfo.UserCode; //A970701
            var UserDep = LoginInfo.DeptId; // H00
            string v_sql = " SELECT EMPLYID, EMPLYNM, DEPID,dbo.SF_GETDEPTBYDEPT(DEPID) DEPNM " +
                            " FROM V_HR_EMPLYM " +
                            " WHERE EMPLYID <> '' AND C_STA = 'A' " +
                            " AND (DEPID = '"+ UserDep + "' " +
                            "   OR  DEPID IN( " +
                            "   SELECT  DEPID " +
                            "    FROM EIP.dbo.WF_EMPADDEPT " +
                            "    WHERE EMPLYID = '"+ UserId + "' " +
                            "    AND Enable = 1 " +
                            " )) ORDER BY 3 ,1 ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             EMPLYID = p.Field<string>("EMPLYID"),
                             EMPLYNM = p.Field<string>("EMPLYNM"),
                             DEPID = p.Field<string>("DEPID"),
                             DEPNM = p.Field<string>("DEPNM")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"EMPLYID",col.EMPLYID },
                    {"EMPLYNM",col.EMPLYNM },
                    {"DEPID",col.DEPID },
                    {"DEPNM",col.DEPNM }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

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
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString))
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
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);

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

        #region 取得部門資料
        public string GetDeptByEmplyid(string v_emplyid, string v_mode)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);

            SqlCommand cmd = new SqlCommand("SP_DEPT_BY_EMPLYID", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@V_EMPLYID", SqlDbType.VarChar, 12);
            cmd.Parameters["@V_EMPLYID"].Value = v_emplyid;
            DataTable dt = new DataTable();
            string v_DEPT = "";
            //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
            //retValParam.Direction = ParameterDirection.Output;

            try
            {
                db.Open();
                dt.Load(cmd.ExecuteReader());
                switch (v_mode)
                {
                    case "DEPID":
                        v_DEPT = dt.Rows[0]["DEPID"].ToString();
                        break;
                    case "DEPNM":
                        v_DEPT = dt.Rows[0]["DEPNM"].ToString();
                        break;
                }
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

            return v_DEPT;
        }
        #endregion

        #region 取得員工個人資訊
        public JArray getEmpInfo()
        {
            var UserId = LoginInfo.UserCode; //B050502
            var UserDep = LoginInfo.DeptId; // C00

            string v_sql = " SELECT '_0' AS SER,'到職日期' AS ITEM, CONVERT(CHAR(10), REGDT, 120) AS INFO ";
            v_sql += " FROM HRSDBR53..HR_EMPLYM ";
            v_sql += "    WHERE EMPLYID = '" + UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '_1' AS SER,'任職部門' AS ITEM, RTRIM(C.DEPNM)AS INFO ";
            v_sql += "    FROM HRSDBR53..HR_EMPLYM A ";
            v_sql += "    LEFT JOIN HRSDBR53..HR_DEP C ON A.DEPID = C.DEPID ";
            v_sql += "    WHERE A.EMPLYID = '"+ UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '_2' AS SER, '任職職稱' AS ITEM, RTRIM(E.JOBNM) AS INFO ";
            v_sql += "    FROM HRSDBR53..HR_EMPLYM A ";
            v_sql += "    LEFT JOIN HRSDBR53..HR_JOBID E ON A.JOBID = E.JOBID ";
            v_sql += "    WHERE A.EMPLYID = '" + UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '_3' AS SER, '簽核主管' AS ITEM, CASE WHEN F.EMPLYNM = A.EMPLYNM THEN( ";
            v_sql += "        SELECT CASE WHEN F1.EMPLYNM = A.EMPLYNM THEN( ";
            v_sql += "            SELECT F2.EMPLYNM ";
            v_sql += "            FROM HRSDBR53..HR_DEP P1, HRSDBR53..HR_EMPLYM F2 ";
            v_sql += "            WHERE P1.DEPID = P.DPRTID AND P1.EMPLYID = F2.EMPLYID ";
            v_sql += "        ) ELSE F1.EMPLYNM END AS EMPLYNM ";
            v_sql += "        FROM HRSDBR53..HR_DEP P, HRSDBR53..HR_EMPLYM F1 ";
            v_sql += "        WHERE P.DEPID = C.DPRTID AND P.EMPLYID = F1.EMPLYID ";
            v_sql += "    ) ELSE F.EMPLYNM END AS INFO ";
            v_sql += "    FROM HRSDBR53..HR_EMPLYM A ";
            v_sql += "    LEFT JOIN HRSDBR53..HR_DEP C ON A.DEPID = C.DEPID ";
            v_sql += "    LEFT JOIN HRSDBR53..HR_EMPLYM F ON C.EMPLYID = F.EMPLYID ";
            v_sql += "    WHERE A.EMPLYID = '" + UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '_4' AS SER, CASE replicate('0', (2 - len(MONTH(A.MRDT)))) + CONVERT(nchar, MONTH(A.MRDT)) WHEN RIGHT(REPLICATE('0', 2) + CAST(Datepart(MM, DATEADD(MONTH, -1, GETDATE())) as NVARCHAR), 2) THEN '加班時數 (' + RIGHT(REPLICATE('0', 2) + CAST(Datepart(MM, DATEADD(MONTH, -1, GETDATE())) as NVARCHAR), 2) + '月' + E.DESCPT + ')' ";
            v_sql += "    WHEN RIGHT(REPLICATE('0', 2) + CAST(Datepart(MM, GETDATE()) as NVARCHAR), 2) THEN '加班時數 (' + RIGHT(REPLICATE('0', 2) + CAST(Datepart(MM, GETDATE()) as NVARCHAR), 2) + '月' + E.DESCPT + ')' END AS ITEM, ";
            v_sql += "      RTRIM(CONVERT(nchar, SUM(CONVERT(numeric(8, 2), A.REHRS1)))) + ' 時' AS INFO ";
            v_sql += "     FROM HRSDBR53..HR_OVRTM A ";
            v_sql += "     JOIN HRSDBR53..KEYCODE E ON A.STATUS = E.KEY_CODE AND E.TBL_NAME = 'HR_FRLMT2' AND E.KEY_NAME = 'F_CFM' ";
            v_sql += "     WHERE A.EMPLYID = '" + UserId + "' AND CAST(YEAR(A.MRDT) as NVARCHAR) + CAST(replicate('0', (2 - len(MONTH(A.MRDT)))) + CONVERT(nchar, MONTH(A.MRDT)) as NVARCHAR) >= CAST(Datepart(YYYY, DATEADD(MONTH, -1, GETDATE())) as NVARCHAR) + RIGHT(REPLICATE('0', 2) + CAST(Datepart(MM, DATEADD(MONTH, -1, GETDATE())) as NVARCHAR), 2) ";
            v_sql += "     GROUP BY YEAR(A.MRDT), MONTH(A.MRDT), A.EMPLYID, E.DESCPT, A.DEPID ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '_5' AS SER, '年資' AS ITEM, CAST(DATEDIFF(DAY, REGDT, GETDATE()) / 365.0 as NVARCHAR) AS INFO FROM HRSDBR53..HR_EMPLYM  WHERE EMPLYID = '" + UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '15' AS SER, RTRIM(O.FRL_NM) + ' (已使用天數/時數)' AS ITEM, ISNULL(RTRIM(CONVERT(nchar, CONVERT(numeric(8, 2), SUM(L.FRHR) / 8, 1))) + ' 天/ ' + RTRIM(CONVERT(nchar, CONVERT(numeric(8, 2), SUM(L.FRHR)))) + ' 時', '') as FRHR_SUM ";
            v_sql += "    FROM HRSDBR53..HR_FRLDL L ";
            v_sql += "    JOIN HRSDBR53..HR_FRLNO O ON L.FRL_NO = O.FRL_NO ";
            v_sql += "    join HRSDBR53..HR_FRLMT P ON L.FMNO = P.FMNO ";
            v_sql += "    WHERE YEAR(L.BL_DT) = YEAR(GETDATE()) AND L.EMPLYID = '" + UserId + "' and P.STATUS = 'CF'  GROUP BY O.FRL_NM ";
            v_sql += "    UNION ";
            v_sql += "    SELECT '30' AS SER, '遲到次數 (本年累計)' AS ITEM, RTRIM(CONVERT(nchar, CONVERT(numeric(8, 0), SUM(LATE_CT)))) + ' 次' AS INFO FROM HRSDBR53.dbo.HR_EMPMMWRK WHERE YYYY = YEAR(GETDATE()) AND EMPLYID = '" + UserId + "' ";
            v_sql += "    UNION ";
            v_sql += "    SELECT DISTINCT '31' AS SER, '健保扶養人' AS ITEM, ";
            v_sql += "    (SELECT S1.CNAME + ' , ' FROM HRSDBR53..HR_FAHIS S1 WHERE S.EMPLYID = S1.EMPLYID FOR XML PATH('')) AS INFO ";
            v_sql += "    FROM HRSDBR53..HR_FAHIS S WHERE S.EMPLYID = '" + UserId + "' ";
            v_sql += "    ORDER BY SER ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SER = p.Field<string>("SER"),
                             ITEM = p.Field<string>("ITEM"),
                             INFO = p.Field<string>("INFO")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SER",col.SER },
                    {"ITEM",col.ITEM },
                    {"INFO",col.INFO}
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region  取得公務車最近里程
        public string GetCarMile(string keyValue)
        {

            DateTime dt = DateTime.Now;
            String v_sqlstr = " SELECT MAX(Mileage) AS Mileage FROM PO_PUBLIC_OBJECT_BOOKING WHERE ObjectSID = @ObjectSID ";
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);

            SqlCommand cmd = new SqlCommand(v_sqlstr, db);

            cmd.Parameters.Add("@ObjectSID", SqlDbType.VarChar, 50);
            cmd.Parameters["@ObjectSID"].Value = keyValue;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
                if (dr.HasRows)
                { // 休假日、例假日 有另外設定
                    string vMileage = dr["Mileage"].ToString();
                    return vMileage;
                }else
                {
                    return "0";
                }
                //dt.Load(cmd.ExecuteReader());
                //v_DEPT = dt.Rows[0]["DEPID"].ToString();

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

            return "0";
        }
        #endregion

        #region 取得工作班別
        public bool GetSFT_NO(string queryJson)
        {
            var queryParam = queryJson.ToJObject();
            DateTime dt = DateTime.Now;
            String v_sqlstr = " SELECT DDDAY,IFDAY,CLAS,REM FROM HRSDBR53.dbo.GetSFT_HoliDay ( @YYYY, (SELECT SFT_NO FROM HR_EMPLYM WHERE EMPLYID = @V_EMPLYID)) " +
            " WHERE DDDAY = CONVERT(DATETIME, @V_YMD, 111)";
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_HRSContext].ConnectionString);

            SqlCommand cmd = new SqlCommand(v_sqlstr, db);
            //cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@YYYY", SqlDbType.VarChar, 12);
            cmd.Parameters["@YYYY"].Value = dt.Year.ToString();
            cmd.Parameters.Add("@V_EMPLYID", SqlDbType.VarChar, 12);
            cmd.Parameters["@V_EMPLYID"].Value = queryParam["emplyid"].ToString();
            cmd.Parameters.Add("@V_YMD", SqlDbType.VarChar, 30);
            cmd.Parameters["@V_YMD"].Value = queryParam["ymd"].ToString();
            //DataTable dt = new DataTable();
            //string v_DEPT = "";
            //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
            //retValParam.Direction = ParameterDirection.Output;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                dr.Read();
                if (dr.HasRows)
                { // 休假日、例假日 有另外設定
                    string vCLAS = dr["CLAS"].ToString();
                    return true;
                }
                //dt.Load(cmd.ExecuteReader());
                //v_DEPT = dt.Rows[0]["DEPID"].ToString();

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

            return false;
        }
        #endregion

        #region 檢查加班單時段是否有重複
        // 檢查加班單時段是否有重複
        public string chkOverTimeDup(HR_OVRTMEntity tableEntity)
        {
            string v_sql = " SELECT A.EMPLYID,B.EMPLYNM,A.OVRTNO, A.FETB , A.FETE, A.DEREASON, A.DEPID,A.OTTP "
                          + " FROM " + v_HR_OVRTM + " A LEFT OUTER JOIN dbo.HR_EMPLYM B ON A.EMPLYID = B.EMPLYID "
                          + " WHERE A.EMPLYID = @EMPLYID  AND((@StartTime  BETWEEN  FETB AND FETE) OR(@EndTime  BETWEEN FETB AND FETE)) "
                          +"  AND A.STATUS IN ('SN','CF','OP') ";
            //string SQL2 = " SELECT A.EMPLYID,B.EMPLYNM,A.OVRTNO, A.FETB , A.FETE, A.DEREASON, A.DEPID,A.OTTP "
            //              + " FROM dbo.HR_OVRTM_TEST A LEFT OUTER JOIN dbo.HR_EMPLYM B ON A.EMPLYID = B.EMPLYID "
            //              + " WHERE A.EMPLYID = '" + tableEntity.EMPLYID + "'  AND(('" + String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETB) + "'  BETWEEN  FETB AND FETE) OR('" + String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETE) + "'  BETWEEN FETB AND FETE)) ";
            string v_message = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_HRSContext].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(v_sql, conn))
                {
                    command.Parameters.AddWithValue("@EMPLYID", tableEntity.EMPLYID);
                    command.Parameters.AddWithValue("@StartTime", String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETB));
                    command.Parameters.AddWithValue("@EndTime", String.Format("{0:yyyy/MM/dd HH:mm}", tableEntity.FETE));
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
        #endregion

        #region 檢查加班單是否合法
        public string[] chkOverTime(HR_OVRTMEntity tableEntity)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_CHK_OVRTM", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@EMPLYID", SqlDbType.VarChar, 20);
            cmd.Parameters["@EMPLYID"].Value = tableEntity.EMPLYID;
            cmd.Parameters.Add("@FETB", SqlDbType.DateTime);
            cmd.Parameters["@FETB"].Value = tableEntity.FETB;
            cmd.Parameters.Add("@FETE", SqlDbType.DateTime);
            cmd.Parameters["@FETE"].Value = tableEntity.FETE;
            string[] param = { null, null };

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                if (dr.HasRows)
                {
                    dr.Read();
                    param[0] = dr["CODE"].ToString();
                    param[1] = dr["MESSAGE"].ToString();

                }

            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            return param;

        }
        #endregion

        #region 取得待簽核清單
        public JArray getWaitSignList(string keyword)
        {
            var UserId = LoginInfo.UserCode; //A970701
            var UserDep = LoginInfo.DeptId; // H00

            var v_sql = "SELECT DISTINCT B.SID,A.FLOWID,'加班單' FLOWNM,A.DOCID,A.SUBJECT,M.DEPID,A.EMP_ID,U.USR_NM AS EMP_NM,U.DEPM_NM, ";
            v_sql += "         A.STATUS,A.SENDDATE,B.SITEID,B.SIGNDATE,B.EMPLYID,M.MRDT,M.DEMIN,A.OVRT46,M.FILFRL ";
            v_sql += " FROM WF_SIGNM A JOIN WF_SIGND B ON A.SID = B.PSID ";
            v_sql += " JOIN VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS ";
            v_sql += " JOIN " + v_HR_OVRTM + " M ON M.OVRTNO = A.DOCID  ";
            v_sql += " WHERE  ( B.EMPLYID = '" + UserId + "' ";
            v_sql += " OR B.EMPLYID IN ( ";
            v_sql += "   SELECT H.EMPLYID  COLLATE Chinese_Taiwan_Stroke_CI_AS FROM WF_ROLED R ";
            v_sql += "   JOIN HRSDBR53..HR_DEP H ON R.DEP_NO = H.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS ";
            v_sql += "   WHERE ROLEID = 1 AND DEP_NO = '" + UserDep + "' AND(PROXY1 = '" + UserId + "' OR PROXY2 = '" + UserId + "' OR PROXY3 = '" + UserId + "')  )  ) ";
            v_sql += " AND A.STATUS = 'SN' AND B.STATUS = 'SN' ";
            v_sql += " AND B.SITEID = ( SELECT MIN(SITEID) FROM WF_SIGND BB JOIN WF_SIGNM AA ON BB.PSID = AA.SID WHERE AA.DOCID = A.DOCID AND BB.STATUS = 'SN' ) ";
            v_sql += " AND(A.DOCID LIKE '%" + keyword + "%' OR U.USR_NM LIKE '%" + keyword + "%' OR U.DEPM_NM LIKE '%" + keyword + "%') ";
            v_sql += " ORDER BY M.MRDT,A.STATUS DESC ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SID = p.Field<string>("SID"),
                             FLOWID = p.Field<int?>("FLOWID"),
                             FLOWNM = p.Field<string>("FLOWNM"),
                             DOCID = p.Field<string>("DOCID"),
                             SUBJECT = p.Field<string>("SUBJECT"),
                             DEPID = p.Field<string>("DEPID"),
                             EMP_NM = p.Field<string>("EMP_NM"),
                             DEPM_NM = p.Field<string>("DEPM_NM"),
                             STATUS = p.Field<string>("STATUS"),
                             EMPLYID = p.Field<string>("EMPLYID"), // 簽核人員
                             MRDT = p.Field<DateTime?>("MRDT"), // 加班日
                             SENDDATE = p.Field<DateTime?>("SENDDATE"), //送簽日
                             SIGNDATE = p.Field<DateTime?>("SIGNDATE"), // 簽核日
                             DEMIN = p.Field<decimal?>("DEMIN"), // 預計加班
                             OVRT46 = p.Field<string>("OVRT46"), // 超過46小時
                             FILFRL = p.Field<string>("FILFRL") // 加班轉補休
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SID",col.SID },
                    {"FLOWID",col.FLOWID },
                    {"FLOWNM",col.FLOWNM},
                    {"DOCID",col.DOCID },
                    {"SUBJECT",col.SUBJECT },
                    {"DEPID",col.DEPID },
                    {"EMP_NM" ,col.EMP_NM},
                    {"DEPM_NM" ,col.DEPM_NM},
                    {"STATUS" ,col.STATUS},
                    {"EMPLYID" ,col.EMPLYID},
                    {"SENDDATE" ,col.SENDDATE},
                    {"MRDT" ,col.MRDT},
                    {"SIGNDATE" ,col.SIGNDATE},
                    {"DEMIN" ,col.DEMIN},
                    {"OVRT46" ,col.OVRT46},
                    {"FILFRL" ,col.FILFRL}
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 產生簽核途程
        public string GenSign(string v_ovrtno)
        {
            int routeLevel = 0;

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand(v_SP_GEN_SIGNROUTE, db);

            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@OVRTNO", SqlDbType.VarChar, 20);
            cmd.Parameters["@OVRTNO"].Value = v_ovrtno;
            cmd.Parameters.Add("@_j", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
            //DataTable dt = new DataTable();
            //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar,250);
            //retValParam.Direction = ParameterDirection.Output;
            try
            {
                db.Open();
                cmd.ExecuteNonQuery();
                routeLevel = (int)cmd.Parameters["@_j"].Value;

            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            if (routeLevel > 0)
            {
                return "success";
            }
            else
            {
                return "error";
            }
        }
        #endregion

        #region 取得簽核途程列表
        public JArray getSignList(string keyValue)
        {
            string v_sql = " SELECT OVRTNO,SITEID, DEPID, DEPTNM, EMPLYID, EMPLYNM, SIGN_STATUS, SIGNDATE,REPLY " +
                           " FROM " + v_V_WF_SIGNROUTE + "  WHERE OVRTNO = '" + keyValue + "' ORDER BY SITEID";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             OVRTNO = p.Field<string>("OVRTNO"),
                             SITEID = p.Field<int?>("SITEID"),
                             DEPTNM = p.Field<string>("DEPTNM"),
                             EMPLYNM = p.Field<string>("EMPLYNM"),
                             SIGN_STATUS = p.Field<string>("SIGN_STATUS"),
                             SIGNDATE = p.Field<string>("SIGNDATE"),
                             REPLY = p.Field<string>("REPLY")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"OVRTNO",col.OVRTNO },
                    {"SITEID",col.SITEID },
                    {"DEPTNM",col.DEPTNM},
                    {"EMPLYNM",col.EMPLYNM },
                    {"SIGN_STATUS",col.SIGN_STATUS },
                    {"SIGNDATE",col.SIGNDATE },
                    {"REPLY" ,col.REPLY}
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 送出簽核作業
        public string SetSign(string v_ovrtno, string v_action)
        {
            string routeLevel = "";

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand(v_SP_SET_SIGNROUTE, db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@ACTION", SqlDbType.VarChar, 20);
            cmd.Parameters["@ACTION"].Value = v_action;
            cmd.Parameters.Add("@OVRTNO", SqlDbType.VarChar, 20);
            cmd.Parameters["@OVRTNO"].Value = v_ovrtno;
            //cmd.Parameters.Add("@returnval", System.Data.SqlDbType.VarChar, 50).Direction = System.Data.ParameterDirection.ReturnValue;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                //cmd.ExecuteNonQuery();
                //routeLevel = (string)cmd.Parameters["@returnval"].Value;
                if (dr.HasRows)
                {
                    dr.Read();
                    routeLevel = dr["outparam"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            if (!routeLevel.Equals(""))
            {
                return "success";
            }
            else
            {
                return "error";
            }
        }
        #endregion

        #region 主管核准作業
        public string ConfirmSign(string v_signid,string v_reply="")
        {
            string routeLevel = "";
            var UserId = LoginInfo.UserCode; //B050502
            var UserDep = LoginInfo.DeptId; // C00

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand(v_SP_SET_SIGN, db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@SIGNID", SqlDbType.VarChar, 4000);
            cmd.Parameters["@SIGNID"].Value = v_signid;
            cmd.Parameters.Add("@REPLY", SqlDbType.VarChar, 500);
            cmd.Parameters["@REPLY"].Value = v_reply;
            cmd.Parameters.Add("@EMPLYID", SqlDbType.VarChar, 20);
            cmd.Parameters["@EMPLYID"].Value = UserId;
            
            //cmd.Parameters.Add("@returnval", System.Data.SqlDbType.VarChar, 50).Direction = System.Data.ParameterDirection.ReturnValue;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                //cmd.ExecuteNonQuery();
                //routeLevel = (string)cmd.Parameters["@returnval"].Value;
                //dt.Load(cmd.ExecuteReader());
                //routeLevel = int.Parse(dt.Rows[0].ToString());
                if (dr.HasRows)
                {
                    dr.Read();
                    routeLevel = dr["outparam"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            if (!routeLevel.Equals(""))
            {
                return "success";
            }
            else
            {
                return "error";
            }
        }
        #endregion

        #region 送出會簽作業
        public string SetSignWith(string v_ovrtno, string v_emplyid, string v_emplyidwith)
        {
            string routeLevel = "";

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_SET_SIGNWITH", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@OVRTNO", SqlDbType.VarChar, 20);
            cmd.Parameters["@OVRTNO"].Value = v_ovrtno;
            cmd.Parameters.Add("@EMPLYID", SqlDbType.VarChar, 20);
            cmd.Parameters["@EMPLYID"].Value = v_emplyid;
            cmd.Parameters.Add("@EMPLYIDWITH", SqlDbType.VarChar, 20);
            cmd.Parameters["@EMPLYIDWITH"].Value = v_emplyidwith;
            //cmd.Parameters.Add("@returnval", System.Data.SqlDbType.VarChar, 50).Direction = System.Data.ParameterDirection.ReturnValue;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                //cmd.ExecuteNonQuery();
                //routeLevel = (string)cmd.Parameters["@returnval"].Value;
                if (dr.HasRows)
                {
                    dr.Read();
                    routeLevel = dr["outparam"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            if (!routeLevel.Equals(""))
            {
                return "success";
            }
            else
            {
                return "error";
            }
        }
        #endregion


        #region 取得訂便當清單
        public JArray getOrderDetailList(string keyword)
        {
            var v_sql = "SELECT A.SID, A.ParentSID, Convert(char(10),A.OrderDate,120) OrderDate , A.EmpID,dbo.SF_GETEMPNAME(A.EmpID) EMPNM,A.DepID,dbo.SF_GETDEPTBYDEPT(A.DepID) DEPNM, " +
                        "      A.OrderMenuSID,B.MealsName,A.Qty, A.UnitPrice, A.AdjustSID, A.AdjustAmount, A.AdjustQty, A.Amount, A.Remark " +
                        " FROM EIP.dbo.BU_ORDERS_DETAIL A JOIN BU_ORDERS_MENU B ON A.OrderMenuSID = B.SID " +
                        " WHERE A.ParentSID = '" + keyword + "' ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SID = p.Field<string>("SID"),
                             ParentSID = p.Field<string>("ParentSID"),
                             OrderDate = p.Field<string>("OrderDate"),
                             EmpID = p.Field<string>("EmpID"),
                             EMPNM = p.Field<string>("EMPNM"),
                             DepID = p.Field<string>("DepID"),
                             DEPNM = p.Field<string>("DEPNM"),
                             OrderMenuSID = p.Field<string>("OrderMenuSID"),
                             MealsName = p.Field<string>("MealsName"),
                             Qty = p.Field<int?>("Qty"),
                             UnitPrice = p.Field<int?>("UnitPrice"),
                             Amount = p.Field<int?>("Amount"),
                             Remark = p.Field<string>("Remark")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SID",col.SID },
                    {"PARENTSID",col.ParentSID },
                    {"ORDERDATE",col.OrderDate},
                    {"EMPID",col.EmpID },
                    {"EMPNM",col.EMPNM },
                    {"DEPID",col.DepID },
                    {"DEPNM" ,col.DEPNM},
                    {"ORDERMENUSID" ,col.OrderMenuSID},
                    {"MEALSNAME" ,col.MealsName},
                    {"QTY" ,col.Qty},
                    {"UNITPRICE" ,col.UnitPrice},
                    {"AMOUNT" ,col.Amount},
                    {"REMARKRemark" ,col.Remark}
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        private BU_ORDERS_DETAILApp orderDetailapp = new BU_ORDERS_DETAILApp();
        #region 新增訂便當明細
        public bool addOrderDetail(string submitJson)
        {
            bool v_YN = false;
            string v_PID = "";
            var data = submitJson.ToJObject();
            BU_ORDERS_DETAILEntity entity = new BU_ORDERS_DETAILEntity();

            if (data.Count > 0)
            {
                entity.DepID = data["DepID"].ToString();
                entity.EmpID = data["EmpID"].ToString();
                entity.OrderDate = data["OrderDate"].ToDate();
                entity.OrderMenuSID = data["OrderMenuSID"].ToString();
                entity.Qty = data["Qty"].ToInt();
                entity.UnitPrice = data["UnitPrice"].ToInt();
                entity.ParentSID = data["ParentSID"].ToString();
                entity.AdjustAmount = 0;
                entity.AdjustQty = 0;
                entity.Amount = 0;
                orderDetailapp.SubmitForm(entity, "");
                v_YN = true;
                v_PID = data["ParentSID"].ToString();
                //TODO: 更新訂便當主檔加總 v_PID
                refreshOrderDetail(v_PID);
            }


            
            return v_YN;
        }
        #endregion

        #region 更新訂便當主檔
        public void refreshOrderDetail(string keyvalue)
        {
            string v_sql = " UPDATE BU_ORDERS SET Qty = (SELECT ISNULL(SUM(Qty),0) FROM BU_ORDERS_DETAIL WHERE ParentSID = @SID) , " +
                            "Amount = (SELECT ISNULL(SUM(Qty*UnitPrice),0) FROM BU_ORDERS_DETAIL WHERE ParentSID = @SID) WHERE SID = @SID ";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(v_sql, conn))
                {
                    try
                    {
                        command.Parameters.AddWithValue("@SID", keyvalue);
                        command.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        throw ex.GetBaseException();
                    }
                    finally
                    {
                        conn.Close();
                    }
                }
            }
        }
        #endregion

        #region 計算午餐用餐人數
        public string ComputLunchPeople(string lunchdate)
        {
            string routeLevel = "";
            //string LunchDate = String.Format("{0:yyyy-MM-dd}", DateTime.Today);

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand("SP_COMPUTLUNCH", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@LunchDate", SqlDbType.VarChar, 20);
            cmd.Parameters["@LunchDate"].Value = lunchdate;
            //cmd.Parameters.Add("@returnval", System.Data.SqlDbType.VarChar, 50).Direction = System.Data.ParameterDirection.ReturnValue;

            try
            {
                db.Open();
                SqlDataReader dr = cmd.ExecuteReader(CommandBehavior.SingleRow);
                //cmd.ExecuteNonQuery();
                //routeLevel = (string)cmd.Parameters["@returnval"].Value;
                if (dr.HasRows)
                {
                    dr.Read();
                    routeLevel = dr["outparam"].ToString();
                }
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally
            {
                db.Close();
            }
            if (!routeLevel.Equals(""))
            {
                return "success";
            }
            else
            {
                return "error";
            }
        }
        #endregion

        #region 取得公務車、會議室借用狀態
        public JArray getPubObjectList(string keyword)
        {
            var UserId = LoginInfo.UserCode; //B050502
            var UserDep = LoginInfo.DeptId; // C00

            var v_sql = "SELECT B.SID,B.ObjectType, B.ObjectNM,CONVERT(VARCHAR(5),A.BookingStartTime,108) BookingStartTime, CONVERT(VARCHAR(5),A.BookingEndTime,108) BookingEndTime,dbo.SF_GETEMPNAME(A.EmployeeID) Status  ";
            v_sql += " FROM PO_PUBLIC_OBJECT_BOOKING A JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID ";
            v_sql += " WHERE  A.Status = '鎖定' AND B.Enable = 'Y' AND B.ObjectType = '" + keyword + "' AND  B.Enable = 'Y' ";
            v_sql += " AND GETDATE() BETWEEN A.BookingStartTime AND A.BookingEndTime ";
            v_sql += "UNION ";
            v_sql += "SELECT SID, ObjectType, ObjectNM, '' BookingStartTime, '' BookingEndTime, '可借用' Status ";
            v_sql += "FROM PO_PUBLIC_OBJECT WHERE ObjectType = '"+ keyword + "' AND  Enable = 'Y' ";
            v_sql += "AND SID NOT IN( ";
            v_sql += "  SELECT A.ObjectSID ";
            v_sql += "   FROM PO_PUBLIC_OBJECT_BOOKING A ";
            v_sql += "   WHERE A.Status = '鎖定' ";
            v_sql += "   AND GETDATE() BETWEEN A.BookingStartTime AND A.BookingEndTime ) ";
            v_sql += " ORDER BY  Status,ObjectNM";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SID = p.Field<string>("SID"),
                             ObjectType = p.Field<string>("ObjectType"),
                             ObjectNM = p.Field<string>("ObjectNM"),
                             BookingStartTime = p.Field<string>("BookingStartTime"),
                             BookingEndTime = p.Field<string>("BookingEndTime"),
                             Status = p.Field<string>("Status")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SID",col.SID },
                    {"ObjectType",col.ObjectType },
                    {"ObjectNM",col.ObjectNM},
                    {"BookingStartTime",col.BookingStartTime},
                    {"BookingEndTime",col.BookingEndTime},
                    {"Status",col.Status }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得差勤人員
        public JArray getLeaveEmpList()
        {
            var v_sql = "SELECT FMNO, SR, EMPLYID,dbo.SF_GETEMPNAME(EMPLYID) EMPLYNM, AGEMP, FRL_NO,FRL_NM, CONVERT(char(10), BL_DT, 20) AS BL_DT, SFT_NO, FRHR, REMARK, ";
            v_sql += " REPLICATE('0', 2 - LEN(CAST(B_NN AS int))) + RTRIM(CAST(B_NN AS int)) + ':' + ";
            v_sql += " REPLICATE('0', 2 - LEN(CAST(B_MM AS int))) + RTRIM(CAST(B_MM AS int)) BTIME, ";
            v_sql += " REPLICATE('0', 2 - LEN(CAST(E_NN AS int))) + RTRIM(CAST(E_NN AS int)) + ':' + ";
            v_sql += " REPLICATE('0', 2 - LEN(CAST(E_MM AS int))) + RTRIM(CAST(E_MM AS int)) ETIME ";
            v_sql += " FROM V_HR_FRLDL ";
            v_sql += " WHERE cast(BL_DT As Date) = cast(GETDATE() As Date)  ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             FMNO = p.Field<string>("FMNO"),
                             SR = p.Field<decimal?>("SR"),
                             EMPLYID = p.Field<string>("EMPLYID"),
                             EMPLYNM = p.Field<string>("EMPLYNM"),
                             FRL_NM = p.Field<string>("FRL_NM"),
                             BL_DT = p.Field<string>("BL_DT"),
                             BTIME = p.Field<string>("BTIME"),
                             ETIME = p.Field<string>("ETIME"),
                             REMARK = p.Field<string>("REMARK")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"FMNO",col.FMNO },
                    {"SR",col.SR },
                    {"EMPLYID",col.EMPLYID},
                    {"EMPLYNM",col.EMPLYNM },
                    {"FRL_NM",col.FRL_NM },
                    {"BL_DT",col.BL_DT },
                    {"BTIME",col.BTIME },
                    {"ETIME",col.ETIME },
                    {"REMARK",col.REMARK }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 個人資訊
        public JArray getPersonalInfo(string keyword)
        {
            var UserId = LoginInfo.UserCode; //B050502
            var UserDep = LoginInfo.DeptId; // C00

            var v_sql = "SELECT B.SID,B.ObjectType, B.ObjectNM,A.BookingStartTime, A.BookingEndTime,dbo.SF_GETEMPNAME(A.EmployeeID) Status ";
            v_sql += " FROM PO_PUBLIC_OBJECT_BOOKING A JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID ";
            v_sql += " WHERE A.Status = '鎖定' AND B.ObjectType = '" + keyword + "'";
            v_sql += " AND GETDATE() BETWEEN A.BookingStartTime AND A.BookingEndTime ";
            v_sql += "UNION ";
            v_sql += "SELECT SID, ObjectType, ObjectNM, '' BookingStartTime, '' BookingEndTime, '可借用' Status ";
            v_sql += "FROM PO_PUBLIC_OBJECT WHERE ObjectType = '" + keyword + "' ";
            v_sql += "AND SID NOT IN( ";
            v_sql += "  SELECT A.ObjectSID ";
            v_sql += "   FROM PO_PUBLIC_OBJECT_BOOKING A ";
            v_sql += "   WHERE A.Status = '鎖定' ";
            v_sql += "   AND GETDATE() BETWEEN A.BookingStartTime AND A.BookingEndTime ) ";
            v_sql += " ORDER BY  Status,ObjectNM";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             SID = p.Field<string>("SID"),
                             ObjectType = p.Field<string>("ObjectType"),
                             ObjectNM = p.Field<string>("ObjectNM"),
                             Status = p.Field<string>("Status")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"SID",col.SID },
                    {"ObjectType",col.ObjectType },
                    {"ObjectNM",col.ObjectNM},
                    {"Status",col.Status }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 郵寄報表檔
        public void mailReport(string keyValue,string filename) {
            string v_sqlstr = " SELECT ISSUEID, COMPANY, EIP.dbo.SF_TWDATEFORMAT(ISSUEDATE,'yyy/mm/dd') ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate" +
                              " FROM FR_OFFIDOC_ISSUE " +
                              " WHERE  SID = '"+ keyValue + "' ";
            //string paper = "A4";

            //資料集
            DataTable dt = GetDataSet(v_sqlstr);
            //var filename = Server.MapPath("~/Reports/DOC01_R01.rdlc"); //Path.Combine(Path.GetTempPath(), "Reports/DOC01_R01.rdlc");
            //string filename = Path.Combine(Path.GetTempPath(), "Report2.rdlc");
            LocalReport localReport = new LocalReport();
            localReport.ReportPath = filename;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            Warning[] warnings;
            string[] streamids;
            string mimeType;
            string encoding;
            string filenameExtension;

            byte[] bytes = localReport.Render(
               "PDF", null, out mimeType, out encoding, out filenameExtension,
                out streamids, out warnings);

            string tempReport = Path.Combine(Path.GetTempPath(), "ReportTemp.rdlc");
            using (var fs = new FileStream(tempReport, FileMode.Create))
            {
                fs.Write(bytes, 0, bytes.Length);
                fs.Close();
            }

            MemoryStream _ms = new MemoryStream(bytes);
            string[] _mailAddress = { "b050502@ccm3s.com"};
            string _subject, _body;
            ArrayList _AttachfilePathlist = new ArrayList();
            _subject = "寄送報表測試";
            _body = "詳見附件";
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
            mm.Subject = _subject;
            mm.Body = _body;

            mm.BodyEncoding = Encoding.GetEncoding("utf-8");
            mm.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;
            mm.Attachments.Add(new Attachment(_ms, "發文.pdf"));
            //foreach (var item in _PathToAttachmentList)
            //{
            //    mm.Attachments.Add(new Attachment(item.ToString()));

            //}
            try
            {
                client.Send(mm);
            }
            catch (Exception ex)
            {
                throw ex.GetBaseException();
            }
            finally {
                _ms.Close();
                _ms.Flush();
            }

        }

        #endregion

        #region 郵寄報表檔
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
