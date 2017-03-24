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
    public class SRMService
    {
        public static string v_EIPContext = "EIPContext";
        public static string v_HRSContext = "HRSContext";

       

        #region 取得料件分類
        public JArray GetITCLASList(string keyValue)
        {
            string v_sql = " SELECT CLAS_NO, CLAS_NM,(CLAS_NO+','+CLAS_NM) DESCR  FROM V_ITCLAS_CCM ORDER BY CLAS_NO DESC";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             CLAS_NO = p.Field<string>("CLAS_NO"),
                             CLAS_NM = p.Field<string>("CLAS_NM"),
                             DESCR = p.Field<string>("DESCR")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"CLAS_NO",col.CLAS_NO },
                    {"CLAS_NM",col.CLAS_NM },
                    {"DESCR",col.DESCR }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 取得料件
        public JArray GetITEMList(string keyword)
        {
            string v_sql = "  SELECT ITEM_NO, ITEM_NM, ITEM_SP,CLAS_NO,(ITEM_NO+','+ITEM_NM) DESCR FROM V_ITEM_CCM WHERE (ITEM_NO = '" + keyword + "' OR CLAS_NO= '" + keyword + "') ";
            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
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

        #region 取得 SRVPRODDL 列表
        public JArray getSRVPRODDLList(string keyValue, string company)
        {
            string v_sql = "SELECT PROD_NO, PROD_SR, ENTRY, DSCP_1, DSCP_2,DSCP_3  FROM ";
            switch (company)
            {
                case "CCM":
                    v_sql += " EIP.dbo.V_SRVPRODDL_CCM ";
                    break;
                case "KSC":
                    v_sql += " EIP.dbo.V_SRVPRODDL_KSC  ";
                    break;
                case "NGB":
                    v_sql += " EIP.dbo.V_SRVPRODDL_NGB  ";
                    break;
                case "DAC":
                    v_sql += " EIP.dbo.V_SRVPRODDL_DAC  ";
                    break;
            }
            v_sql += " WHERE PROD_NO = '" + keyValue + "' ORDER BY 2 ";

            //得到一個DataTable物件
            DataTable dt = this.queryDataTable(v_sql);

            JArray MixArray = new JArray();
            var detail = from p in dt.AsEnumerable()
                         select new
                         {
                             PROD_NO = p.Field<string>("PROD_NO"),
                             PROD_SR = p.Field<int?>("PROD_SR"),
                             ENTRY = p.Field<string>("ENTRY"),
                             DSCP_1 = p.Field<string>("DSCP_1"),
                             DSCP_2 = p.Field<string>("DSCP_2"),
                             DSCP_3 = p.Field<string>("DSCP_3")
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {

                var colObject = new JObject
                {
                    {"PROD_NO",col.PROD_NO },
                    {"PROD_SR",col.PROD_SR },
                    {"ENTRY",col.ENTRY},
                    {"DSCP_1",col.DSCP_1 },
                    {"DSCP_2",col.DSCP_2 },
                    {"DSCP_3",col.DSCP_3 }
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
