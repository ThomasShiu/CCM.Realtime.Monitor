using CCM.Code;
using CCM.Domain;
using CCM.Repository;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

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
                         " WHERE A.ObjectSID = B.SID  AND A.ObjectSID = @ObjectSID AND ((@StartTime  BETWEEN  A.BookingStartTime AND A.BookingEndTime ) OR (@EndTime  BETWEEN A.BookingStartTime AND A.BookingEndTime))";
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

        #region 取得特約廠商，只取前8筆
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
                          + " WHERE A.EMPLYID = @EMPLYID  AND((@StartTime  BETWEEN  FETB AND FETE) OR(@EndTime  BETWEEN FETB AND FETE)) ";
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
            var LoginInfo = OperatorProvider.Provider.GetCurrent();
            var UserId = LoginInfo.UserCode; //A970701
            var UserDep = LoginInfo.DeptId; // H00

            var v_sql = "SELECT DISTINCT B.SID,A.FLOWID,'加班單' FLOWNM,A.DOCID,A.SUBJECT,M.DEPID,A.EMP_ID,U.USR_NM AS EMP_NM,U.DEPM_NM, " +
                          " A.STATUS,A.SENDDATE,B.SITEID,B.SIGNDATE,B.EMPLYID,M.MRDT,M.DEMIN,A.OVRT46 " +
                          " FROM WF_SIGNM A JOIN WF_SIGND B ON A.SID = B.PSID " +
                          " JOIN VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                          " JOIN " + v_HR_OVRTM + " M ON M.OVRTNO = A.DOCID COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                          " WHERE B.STATUS = 'SN'  AND B.EMPLYID = '" + UserId + "'  AND(A.DOCID LIKE '%" + keyword + "%' OR U.USR_NM LIKE '%" + keyword + "%') " +
                          " AND A.STATUS = 'SN' " +
                          " AND B.SITEID = ( SELECT MIN(SITEID) FROM WF_SIGND BB JOIN WF_SIGNM AA ON BB.PSID = AA.SID WHERE AA.DOCID = A.DOCID AND BB.STATUS = 'SN' ) " +
                          " OR B.EMPLYID IN ( " +
                          "   SELECT H.EMPLYID  COLLATE Chinese_Taiwan_Stroke_CI_AS FROM WF_ROLED R " +
                          "   JOIN HRSDBR53..HR_DEP H ON R.DEP_NO = H.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS " +
                          "   WHERE ROLEID = 1 AND DEP_NO = '" + UserDep + "' AND(PROXY1 = '" + UserId + "' OR PROXY2 = '" + UserId + "' OR PROXY3 = '" + UserId + "')  )  " +
                          " AND B.STATUS = 'SN' " +
                          " ORDER BY M.MRDT,A.STATUS DESC ";

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
                             OVRT46 = p.Field<string>("OVRT46") // 超過46小時
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
        public string ConfirmSign(string v_signid, string v_emplyid)
        {
            string routeLevel = "";

            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString);
            SqlCommand cmd = new SqlCommand(v_SP_SET_SIGN, db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@SIGNID", SqlDbType.VarChar, 500);
            cmd.Parameters["@SIGNID"].Value = v_signid;
            cmd.Parameters.Add("@EMPLYID", SqlDbType.VarChar, 20);
            cmd.Parameters["@EMPLYID"].Value = v_emplyid;
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

    }
}
