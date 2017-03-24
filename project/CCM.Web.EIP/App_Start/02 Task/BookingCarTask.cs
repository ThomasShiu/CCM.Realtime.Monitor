using CCM.Code;
using CCM.Domain.Entity.SystemManage;
using CCM.Domain.IRepository.SystemManage;
using CCM.Repository.SystemManage;
using Quartz;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using CCM.Domain.Entity.SystemSecurity;

namespace CCM.Web.EIP
{
    public class BookingCarTask : IJob
    {

        public void Execute(IJobExecutionContext context)
        {
            //DoSendMail();
            BookingCar();
        }

        #region 自動產生公務車預約-總經理特助楊登雄用車
        public void BookingCar()
        {
            DateTime dt = DateTime.Now;
            string tmp = dt.DayOfWeek.ToString();//tmp = Thursday
            string day = dt.DayOfWeek.ToString("d"); //day 0=日 ,1=1,2=2,3=3,4=4,5=5,6=6 
            string today = DateTime.Now.ToString("yyyy-MM-dd");
            string tomorrow = DateTime.Now.AddDays(1).ToString("yyyy-MM-dd");
            string holiday = DateTime.Now.AddDays(3).ToString("yyyy-MM-dd");
            string SQL = "";
            switch (day)
            {
                case "1":case "2":case "3":case "4":
                    SQL = " INSERT INTO PO_PUBLIC_OBJECT_BOOKING(ObjectType, UseReason, Subject, [Description], EmployeeID, DepartmentID, ObjectSID, BookingStartTime, BookingEndTime, AttendEmp, Status, Mileage, MileageLast,BgColor) " +
                          " VALUES('公務車輛', '內部需求', '總經理特助楊登雄上下班', '總經理特助楊登雄上下班', 'B060309', 'H00', '24', '" + today + " 17:00', '"+ tomorrow + " 08:00', '總經理室_楊登雄', '鎖定', 0, 0,'#FF0000')";
                    ExecuteSQL(SQL);
                    break;
                case "5":
                    SQL = " INSERT INTO PO_PUBLIC_OBJECT_BOOKING(ObjectType, UseReason, Subject, [Description], EmployeeID, DepartmentID, ObjectSID, BookingStartTime, BookingEndTime, AttendEmp, Status, Mileage, MileageLast,BgColor) " +
                         " VALUES('公務車輛', '內部需求', '總經理特助楊登雄上下班', '總經理特助楊登雄上下班', 'B060309', 'H00', '24', '" + today + " 17:00', '" + holiday + " 08:00', '總經理室_楊登雄', '鎖定', 0, 0,'#FF0000')";
                    ExecuteSQL(SQL);
                    break;
            }
        }
        #endregion

        private void ExecuteSQL(string SQL)
        {
            //1.引用SqlConnection物件連接資料庫
            using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["EIPContext"].ConnectionString))
            {
                //2.開啟資料庫
                conn.Open();
                //3.引用SqlCommand物件
                using (SqlCommand command = new SqlCommand(SQL, conn))
                {
                    try { 
                    command.ExecuteNonQuery();
                    string msg = String.Format("BookingCar() at {0:yyyy/MM/dd HH:mm:ss}", DateTime.Now);
                    Log(msg);
                    }
                    catch (Exception)
                    {

                    }
                    finally{
                        conn.Close();
                    }
                }
            }
        }
        private void Log(string msg)
        {
            System.IO.File.AppendAllText(@"C:\Temp\log.txt", msg + Environment.NewLine);
        }
    }
}