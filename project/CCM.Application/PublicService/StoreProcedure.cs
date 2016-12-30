using CCM.Code;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Configuration;

namespace CCM.Application
{
    public class StoreProcedure
    {
        #region 產生簽核途程
        public string GenSign(string v_type, string v_prefix, int v_count = 1)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);

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

        #region 產生單據號碼
        public string GetOrdNo(string v_type,string v_prefix,int v_count=1)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString );

            SqlCommand cmd = new SqlCommand("SP_GEN_ORDNO", db);
            cmd.CommandType = CommandType.StoredProcedure;

            cmd.Parameters.Add("@TYPE", SqlDbType.VarChar, 12);
            cmd.Parameters["@TYPE"].Value = v_type;
            cmd.Parameters.Add("@PREFIX", SqlDbType.VarChar, 20);
            cmd.Parameters["@PREFIX"].Value = v_prefix;
            cmd.Parameters.Add("@COUNT", SqlDbType.Int);
            cmd.Parameters["@COUNT"].Value = v_count;
            DataTable dt = new DataTable();
            string v_orderNo="";
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
        public string GetDeptByEmplyid(string v_emplyid,string v_mode)
        {
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);

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
            

            String v_sqlstr = " SELECT DDDAY,IFDAY,CLAS,REM FROM HRSDBR53.dbo.GetSFT_HoliDay ( '2016', (SELECT SFT_NO FROM HR_EMPLYM WHERE EMPLYID = @V_EMPLYID)) "
                             + " WHERE DDDAY = CONVERT(DATETIME, @V_YMD, 111)";
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["HRSContext"].ConnectionString);

            SqlCommand cmd = new SqlCommand(v_sqlstr, db);
            //cmd.CommandType = CommandType.StoredProcedure;

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
                if (dr.HasRows) {
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

    }
}
