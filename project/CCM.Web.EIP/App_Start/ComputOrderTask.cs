using CCM.Application;
using Quartz;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Threading;
using System.Web;
using System.Web.Configuration;

namespace CCM.Web.EIP
{
    public class ComputOrderTask : IJob
    {
        
        public void DoComputOrder()
        {
            string routeLevel = "";
            //string LunchDate = String.Format("{0:yyyy-MM-dd}", DateTime.Today);
            var lunchdate =  DateTime.Now.ToString("yyyy-MM-dd");
            SqlConnection db = new SqlConnection(WebConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString);
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
                    string msg = String.Format("ComputOrder() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
                    Log(msg);
                    Thread.Sleep(2000);
                }
            }
            catch (Exception ex)
            {
                // 發生意外時只記在 log 裡，不拋出 exception，以確保迴圈持續執行.
                Log(ex.ToString());

            }

        }


        public void Execute(IJobExecutionContext context)
        {
            // 設定每一輪工作執行完畢之後要間隔幾分鐘再執行下一輪工作.
            const int LoopIntervalInMinutes = 1000 * 60 * 1;
            try
            {
                DoComputOrder();
            }
            catch (Exception ex)
            {
                // 發生意外時只記在 log 裡，不拋出 exception，以確保迴圈持續執行.
                Log(ex.ToString());
            }
            finally
            {
                // 每一輪工作完成後的延遲.
                System.Threading.Thread.Sleep(LoopIntervalInMinutes);
            }
        }

        private void Log(string msg)
        {
            System.IO.File.AppendAllText(@"C:\Temp\log.txt", msg + Environment.NewLine);
        }

    }
}