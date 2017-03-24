using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CCM.Application._02_Services
{
    public class RDService
    {
        public static string v_EIPContext = "EIPContext";
        public static string v_HRSContext = "HRSContext";

        #region 檢查機台編號
        public string chkMachineExists(string keyValue)
        {
            string v_sql = " SELECT  COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO FROM ( "+
                        //"    SELECT 'CCM' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO " +
                        //"     FROM EIP.dbo.V_SRVPRODMT_CCM " +
                        //"    UNION ALL " +
                        "    SELECT 'KSC' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO " +
                        "     FROM EIP.dbo.V_SRVPRODMT_KSC " +
                        "    UNION ALL " +
                        "    SELECT 'NGB' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO " +
                        "     FROM EIP.dbo.V_SRVPRODMT_NGB  ) A "+
                        "  WHERE A.M_ITEM_NO = @M_ITEM_NO ";
       
            string v_message = "";
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings[v_EIPContext].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(v_sql, conn))
                {
                    //command.Parameters.AddWithValue("@SID", tableEntity.SID);
                    command.Parameters.AddWithValue("@M_ITEM_NO", keyValue);
                    //4.搭配SqlCommand物件使用SqlDataReader
                    using (SqlDataReader dr = command.ExecuteReader())
                    {
                        if (!dr.HasRows)
                        {
                            v_message = "查無基台資料!";
                            return v_message;
                        }
                    }

                }

            }
            return v_message;
        }
        #endregion

        #region 取得售服機台資料
        public JArray GetSRVPRODList(string keyValue)
        {
            string v_sql = " SELECT 'CCM' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_NO, '') + ',' +  ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_CCM WHERE ITEM_NO LIKE '%"+ keyValue + "%' " +
                          "  UNION ALL " +
                            " SELECT 'KSC' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_NO, '') + ',' + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_KSC WHERE ITEM_NO LIKE '%" + keyValue + "%'  " +
                          "  UNION ALL " +
                          "  SELECT 'NGB' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_NO, '') + ','  + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_NGB WHERE ITEM_NO LIKE '%" + keyValue + "%'  " +
                          "  UNION ALL " +
                          "  SELECT 'DAC' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_NO, '') + ','  + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_DAC WHERE ITEM_NO LIKE '%" + keyValue + "%'   ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             COMPANY = p.Field<string>("COMPANY"),
                             PROD_NO = p.Field<string>("PROD_NO"),
                             PROD_TY = p.Field<string>("PROD_TY"),
                             ITEM_NO = p.Field<string>("ITEM_NO"),
                             ITEM_NM = p.Field<string>("ITEM_NM"),
                             ITEM_SP = p.Field<string>("ITEM_SP"),
                             M_ITEM_NO = p.Field<string>("M_ITEM_NO"),
                             ITEM_DESCRIPT = p.Field<string>("ITEM_DESCRIPT")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"COMPANY",col.COMPANY },
                    {"PROD_NO",col.PROD_NO },
                    {"PROD_TY",col.PROD_TY },
                    {"ITEM_NO",col.ITEM_NO },
                    {"ITEM_NM",col.ITEM_NM },
                    {"ITEM_SP",col.ITEM_SP },
                    {"M_ITEM_NO",col.M_ITEM_NO },
                    {"ITEM_DESCRIPT",col.ITEM_DESCRIPT }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得售服機台資料與品號
        public JArray GetITEMList(string company)
        {
            string v_sql = "";
            switch (company) {
                case "CCM":
                    v_sql = " SELECT DISTINCT 'CCM' COMPANY,RTRIM(A.ITEM_NO) ITEM_NO,RTRIM(A.ITEM_NM) ITEM_NM,RTRIM(A.ITEM_SP) ITEM_SP,RTRIM(B.M_ITEM_NO) M_ITEM_NO, ";
                    v_sql += "       (RTRIM(A.ITEM_NO) + ',' + RTRIM(A.ITEM_NM) + ',' + ISNULL(RTRIM(A.ITEM_SP), '') + ',' + ISNULL(RTRIM(B.PROD_NO), '')) DESCR ";
                    v_sql += " FROM [192.168.100.19].CCM_Main.dbo.ITEM A LEFT OUTER JOIN [192.168.100.19].CCM_Main.dbo.SRVPRODMT B ";
                    v_sql += " ON A.ITEM_NO = B.ITEM_NO ";
                    v_sql += " WHERE A.ITEM_NO LIKE '6S%' ";
                    break;
                case "KSC":
                    v_sql = " SELECT DISTINCT 'KSC' COMPANY,RTRIM(A.ITEM_NO) ITEM_NO,RTRIM(A.ITEM_NM) ITEM_NM,RTRIM(A.ITEM_SP) ITEM_SP,RTRIM(B.M_ITEM_NO) M_ITEM_NO, ";
                    v_sql += "       (RTRIM(A.ITEM_NO) + ',' + RTRIM(A.ITEM_NM) + ',' + ISNULL(RTRIM(A.ITEM_SP), '') + ',' + ISNULL(RTRIM(B.M_ITEM_NO), '')) DESCR ";
                    v_sql += " FROM [192.168.100.18].KSC_15.dbo.ITEM A LEFT JOIN [192.168.100.18].KSC_15.dbo.SRVPRODMT B ";
                    v_sql += " ON A.ITEM_NO = B.ITEM_NO ";
                    v_sql += " WHERE A.ITEM_NO IS NOT NULL AND(A.ITEM_NO LIKE '7S%' OR A.ITEM_NO LIKE '6S%'  OR A.ITEM_NO LIKE '5S%') ";
                    break;
                case "NGB":
                    v_sql = "SELECT  DISTINCT 'NGB' COMPANY,RTRIM(A.ITEM_NO) ITEM_NO,RTRIM(A.ITEM_NM) ITEM_NM,RTRIM(A.ITEM_SP) ITEM_SP,RTRIM(B.M_ITEM_NO) M_ITEM_NO, ";
                    v_sql += "       (RTRIM(A.ITEM_NO) + ',' + RTRIM(A.ITEM_NM) + ',' + ISNULL(RTRIM(A.ITEM_SP), '') + ',' + ISNULL(RTRIM(B.M_ITEM_NO), '')) DESCR ";
                    v_sql += " FROM [192.168.100.18].NGB_15.dbo.ITEM A LEFT JOIN [192.168.100.18].NGB_15.dbo.SRVPRODMT B ";
                    v_sql += " ON A.ITEM_NO = B.ITEM_NO ";
                    v_sql += " WHERE A.ITEM_NO IS NOT NULL AND(A.ITEM_NO LIKE '7S%' OR A.ITEM_NO LIKE '6S%' OR A.ITEM_NO LIKE '5S%') ";
                    break;
                case "DAC":
                    v_sql = "SELECT DISTINCT 'DAC' COMPANY,RTRIM(A.ITEM_NO) ITEM_NO,RTRIM(A.ITEM_NM) ITEM_NM,RTRIM(A.ITEM_SP) ITEM_SP,RTRIM(B.M_ITEM_NO) M_ITEM_NO, ";
                    v_sql += "       (RTRIM(A.ITEM_NO) + ',' + RTRIM(A.ITEM_NM) + ',' + ISNULL(RTRIM(A.ITEM_SP), '') + ',' + ISNULL(RTRIM(B.M_ITEM_NO), '')) DESCR ";
                    v_sql += " FROM [192.168.100.18].DAC_15.dbo.ITEM A LEFT JOIN [192.168.100.18].DAC_15.dbo.SRVPRODMT B ";
                    v_sql += " ON A.ITEM_NO = B.ITEM_NO ";
                    v_sql += " WHERE A.ITEM_NO IS NOT NULL AND(A.ITEM_NO LIKE '7S%' OR A.ITEM_NO LIKE '6S%' OR A.ITEM_NO LIKE '5S%')  ";
                    break;

            }
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             COMPANY = p.Field<string>("COMPANY"),
                             ITEM_NO = p.Field<string>("ITEM_NO"),
                             ITEM_NM = p.Field<string>("ITEM_NM"),
                             ITEM_SP = p.Field<string>("ITEM_SP"),
                             DESCR = p.Field<string>("DESCR")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"COMPANY",col.COMPANY },
                    {"ITEM_NO",col.ITEM_NO },
                    {"ITEM_NM",col.ITEM_NM },
                    {"ITEM_SP",col.ITEM_SP },
                    {"DESCR",col.DESCR }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得售服資料
        public JArray GetSRVPRODdata()
        {
            string v_sql = " SELECT RTRIM(CS_NO) CS_NO, SHORT_NM,  FULL_NM,(RTRIM(CS_NO)+'-'+RTRIM(SHORT_NM)) CUST_NAME " +
                            " FROM EIP.dbo.V_CUSTOMER " +
                            " WHERE COMPID IN('KSC', 'NGB', 'DAC') " +
                            " ORDER BY COMPID,CS_NO  ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             CS_NO = p.Field<string>("CS_NO"),
                             SHORT_NM = p.Field<string>("SHORT_NM"),
                             FULL_NM = p.Field<string>("FULL_NM"),
                             CUST_NAME = p.Field<string>("CUST_NAME")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"CS_NO",col.CS_NO },
                    {"SHORT_NM",col.SHORT_NM },
                    {"FULL_NM",col.FULL_NM },
                    {"CUST_NAME",col.CUST_NAME }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得客戶資料
        public JArray GetCustList()
        {
            string v_sql = " SELECT RTRIM(CS_NO) CS_NO, SHORT_NM,  FULL_NM,(RTRIM(CS_NO)+'-'+RTRIM(SHORT_NM)) CUST_NAME " +
                            " FROM EIP.dbo.V_CUSTOMER " +
                            " WHERE COMPID IN('CCM','KSC', 'NGB', 'DAC') " +
                            " ORDER BY COMPID,CS_NO  ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             CS_NO = p.Field<string>("CS_NO"),
                             SHORT_NM = p.Field<string>("SHORT_NM"),
                             FULL_NM = p.Field<string>("FULL_NM"),
                             CUST_NAME = p.Field<string>("CUST_NAME")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"CS_NO",col.CS_NO },
                    {"SHORT_NM",col.SHORT_NM },
                    {"FULL_NM",col.FULL_NM },
                    {"CUST_NAME",col.CUST_NAME }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 品號帶出客戶-CCM
        public JArray GetCSNAME(string keyValue)
        {
            //品號代出客戶
            string v_sql = "SELECT RTRIM(A.ITEM_NO) ITEM_NO,RTRIM(B.CS_NO) CS_NO,RTRIM(C.SHORT_NM) SHORT_NM,RTRIM(C.FULL_NM) FULL_NM " +
                         " FROM[192.168.100.19].CCM_Main.dbo.MOMT A LEFT OUTER JOIN[192.168.100.19].CCM_Main.dbo.COMT B ON A.CO_TY = B.VCH_TY AND A.CO_NO = B.VCH_NO " +
                         "     LEFT OUTER JOIN[192.168.100.19].CCM_Main.dbo.CUSTOMER C ON B.CS_NO = C.CS_NO " +
                         " WHERE ITEM_NO = '"+ keyValue + "' ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             ITEM_NO = p.Field<string>("ITEM_NO"),
                             CS_NO = p.Field<string>("CS_NO"),
                             SHORT_NM = p.Field<string>("SHORT_NM"),
                             FULL_NM = p.Field<string>("FULL_NM")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"ITEM_NO",col.ITEM_NO },
                    {"CS_NO",col.CS_NO },
                    {"SHORT_NM",col.SHORT_NM },
                    {"FULL_NM",col.FULL_NM }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
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
    }
}
