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
        //#region 產生簽核途程
        //public string GenSign(string v_ovrtno)
        //{
        //    int routeLevel = 0;

        //    SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);
        //    SqlCommand cmd = new SqlCommand("SP_GEN_SIGNROUTE_TEST", db);
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@OVRTNO", SqlDbType.VarChar, 20);
        //    cmd.Parameters["@OVRTNO"].Value = v_ovrtno; 
        //    cmd.Parameters.Add("@_j", System.Data.SqlDbType.Int).Direction = System.Data.ParameterDirection.ReturnValue;
        //    //DataTable dt = new DataTable();
        //    //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar,250);
        //    //retValParam.Direction = ParameterDirection.Output;
        //    try
        //    {
        //        db.Open();
        //        cmd.ExecuteNonQuery();
        //        routeLevel = (int)cmd.Parameters["@_j"].Value;

        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        db.Close();
        //    }
        //    if (routeLevel > 0)
        //    {
        //        return "success";
        //    }
        //    else {
        //        return "error";
        //    }
        //}
        //#endregion

        //#region 簽核作業
        //public string SetSign(string v_ovrtno,string v_action)
        //{
        //    string routeLevel = "";

        //    SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);
        //    SqlCommand cmd = new SqlCommand("SP_SET_SIGNROUTE_TEST", db);
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@ACTION", SqlDbType.VarChar, 20);
        //    cmd.Parameters["@ACTION"].Value = v_action;
        //    cmd.Parameters.Add("@OVRTNO", SqlDbType.VarChar, 20);
        //    cmd.Parameters["@OVRTNO"].Value = v_ovrtno;
        //    cmd.Parameters.Add("@returnval", System.Data.SqlDbType.VarChar,50).Direction = System.Data.ParameterDirection.ReturnValue;

        //    try
        //    {
        //        db.Open();
        //        cmd.ExecuteNonQuery();
        //        routeLevel = (string)cmd.Parameters["@returnval"].Value;
        //        //dt.Load(cmd.ExecuteReader());
        //        //routeLevel = int.Parse(dt.Rows[0].ToString());
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        db.Close();
        //    }
        //    if (!routeLevel.Equals(""))
        //    {
        //        return "success";
        //    }
        //    else
        //    {
        //        return "error";
        //    }
        //}
        //#endregion

        //#region 產生單據號碼
        //public string GetOrdNo(string v_type,string v_prefix,int v_count=1)
        //{
        //    SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString );

        //    SqlCommand cmd = new SqlCommand("SP_GEN_ORDNO", db);
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@TYPE", SqlDbType.VarChar, 12);
        //    cmd.Parameters["@TYPE"].Value = v_type;
        //    cmd.Parameters.Add("@PREFIX", SqlDbType.VarChar, 20);
        //    cmd.Parameters["@PREFIX"].Value = v_prefix;
        //    cmd.Parameters.Add("@COUNT", SqlDbType.Int);
        //    cmd.Parameters["@COUNT"].Value = v_count;
        //    DataTable dt = new DataTable();
        //    string v_orderNo="";
        //    //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
        //    //retValParam.Direction = ParameterDirection.Output;

        //    try
        //    {
        //        db.Open();
        //        dt.Load(cmd.ExecuteReader());
        //        v_orderNo = dt.Rows[0]["FROM_NO"].ToString();
        //        //cmd.ExecuteNonQuery();
             
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        db.Close();
        //    }

        //    return v_orderNo;
        //}
        //#endregion

        //#region 取得部門資料
        //public string GetDeptByEmplyid(string v_emplyid,string v_mode)
        //{
        //    SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);

        //    SqlCommand cmd = new SqlCommand("SP_DEPT_BY_EMPLYID", db);
        //    cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@V_EMPLYID", SqlDbType.VarChar, 12);
        //    cmd.Parameters["@V_EMPLYID"].Value = v_emplyid;
        //    DataTable dt = new DataTable();
        //    string v_DEPT = "";
        //    //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
        //    //retValParam.Direction = ParameterDirection.Output;

        //    try
        //    {
        //        db.Open();
        //        dt.Load(cmd.ExecuteReader());
        //        switch (v_mode)
        //        {
        //            case "DEPID":
        //                v_DEPT = dt.Rows[0]["DEPID"].ToString();
        //                break;
        //            case "DEPNM":
        //                v_DEPT = dt.Rows[0]["DEPNM"].ToString();
        //                break;
        //        }
        //        //cmd.ExecuteNonQuery();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        db.Close();
        //    }

        //    return v_DEPT;
        //}
        //#endregion

        //#region 取得工作班別
        //public bool GetSFT_NO(string queryJson)
        //{
        //    var queryParam = queryJson.ToJObject();
        //    DateTime dt = DateTime.Now;
        //    String v_sqlstr = " SELECT DDDAY,IFDAY,CLAS,REM FROM HRSDBR53.dbo.GetSFT_HoliDay ( @YYYY, (SELECT SFT_NO FROM HR_EMPLYM WHERE EMPLYID = @V_EMPLYID)) "+
        //    " WHERE DDDAY = CONVERT(DATETIME, @V_YMD, 111)";
        //    SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["HRSContext"].ConnectionString);

        //    SqlCommand cmd = new SqlCommand(v_sqlstr, db);
        //    //cmd.CommandType = CommandType.StoredProcedure;

        //    cmd.Parameters.Add("@YYYY", SqlDbType.VarChar, 12);
        //    cmd.Parameters["@YYYY"].Value = dt.Year.ToString();
        //    cmd.Parameters.Add("@V_EMPLYID", SqlDbType.VarChar, 12);
        //    cmd.Parameters["@V_EMPLYID"].Value = queryParam["emplyid"].ToString();
        //    cmd.Parameters.Add("@V_YMD", SqlDbType.VarChar, 30);
        //    cmd.Parameters["@V_YMD"].Value = queryParam["ymd"].ToString();
        //    //DataTable dt = new DataTable();
        //    //string v_DEPT = "";
        //    //SqlParameter retValParam = cmd.Parameters.Add("@OutputData", SqlDbType.VarChar, 250);
        //    //retValParam.Direction = ParameterDirection.Output;

        //    try
        //    {
        //        db.Open();
        //        SqlDataReader dr = cmd.ExecuteReader();
        //        dr.Read();
        //        if (dr.HasRows) { // 休假日、例假日 有另外設定
        //            string vCLAS = dr["CLAS"].ToString();
        //            return true;
        //        }
        //        //dt.Load(cmd.ExecuteReader());
        //        //v_DEPT = dt.Rows[0]["DEPID"].ToString();

        //        //cmd.ExecuteNonQuery();
        //    }
        //    catch (Exception ex)
        //    {
        //        throw ex.GetBaseException();
        //    }
        //    finally
        //    {
        //        db.Close();
        //    }

        //    return false;
        //}
        //#endregion

    }
}
