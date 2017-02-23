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
        // 檢查公共物件是否被預約
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
        public JArray GetSRVPRODList()
        {
            string v_sql = " SELECT 'KSC' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_TY, '') + ',' + ITEM_NO + ',' + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_KSC " +
                          "  UNION ALL " +
                          "  SELECT 'NGB' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_TY, '') + ',' + ITEM_NO + ',' + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_NGB " +
                          "  UNION ALL " +
                          "  SELECT 'DAC' COMPANY,PROD_NO, PROD_TY, ITEM_NO, ITEM_NM, ITEM_SP, M_ITEM_NO,(ISNULL(PROD_TY, '') + ',' + ITEM_NO + ',' + ITEM_NM+','+M_ITEM_NO) ITEM_DESCRIPT " +
                          "  FROM EIP.dbo.V_SRVPRODMT_DAC  ";
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

        #region 取得售服機台資料
        public JArray GetCustList()
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
