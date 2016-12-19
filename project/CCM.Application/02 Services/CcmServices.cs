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
        // 產生資料集
        public DataTable GetDataSet(string SQL)
        {
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["CCMDbContext"].ConnectionString);
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
    }
}
