using CCM.Application.ViewModel;
using CCM.Domain;
using MySql.Data.MySqlClient;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;

namespace CCM.Application.Services
{
    public class RealTimeService
    {
        //過期時間
        int ExpiredTime = 30;

        public static string v_RTDBContext = "ccm_rtdb";
        private rtm_machinesApp rtm_machinesApp = new rtm_machinesApp();
        private realtime_sortingApp rtm_sortingApp = new realtime_sortingApp();

        #region 取得篩選機清單
        public List<string> GetSortList(string keyword)
        {
            var list = rtm_machinesApp.GetList(keyword).Select(o => o.F_Machine_ID ).ToList();
            return list;
        }

        public JArray GetSortArray(string keyword)
        {
            var list = rtm_machinesApp.GetList(keyword);

            JArray MixArray = new JArray();
            var detail = from p in list
                         select new
                         {
                             F_Id = p.F_Id,
                             F_Machine_ID = p.F_Machine_ID,
                             F_Machine_Model = p.F_Machine_Model,
                             F_Machine_Type = p.F_Machine_Type,
                             F_Remark = p.F_Remark
                         };

            int totalCount = detail.Count();
            foreach (var col in detail)
            {
                var colObject = new JObject
                {
                    {"F_Id",col.F_Id },
                    {"F_Machine_ID",col.F_Machine_ID },
                    {"F_Machine_Model",col.F_Machine_Model },
                    {"F_Machine_Type",col.F_Machine_Type },
                    {"F_Remark",col.F_Remark }
                };
                MixArray.Add(colObject);
            }
            return MixArray;
        }
        #endregion

        #region 抓取機台資料
        //public SortingMachine_DataViewModule GetSortingMachineData(string Machine_ID)
        //{
        //    var query = _db.RealTime_Sorting.Where(o => o.Machine == Machine_ID).OrderByDescending(o => o.EndTime);
        //    var machine_data = query.FirstOrDefault();

        //    var data = new SortingMachine_DataViewModule()
        //    {
        //        Flicker = GetFlicker(machine_data.EndTime, machine_data.Status),
        //        Pass = machine_data.Pass,
        //        Rejected = machine_data.Rejected,
        //        Yield = GetYield(machine_data.Pass, machine_data.Rejected),
        //        Speed = machine_data.Speed,
        //        Retest = machine_data.Retest,
        //        Teach = machine_data.Teach,
        //        Total = machine_data.Total,
        //        Msg = GetLastMsgTime(machine_data.EndTime, machine_data.Status, machine_data.StartingTime),
        //        Background = GetBackground(machine_data.EndTime, machine_data.Status)
        //    };
        //    return data;
        //}
        #endregion

        #region GetJson(string) 把DataTable轉成JSON字串
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

        #region queryDataTable(string) 回傳DataTable物件
        /// <summary>
        /// 依據SQL語句，回傳DataTable物件
        /// </summary>
        /// <param name="sql"></param>
        /// <returns></returns>
        public DataTable queryDataTable(string sql)
        {
            DataSet ds = new DataSet();
            using (MySqlConnection conn = new MySqlConnection(ConfigurationManager.ConnectionStrings[v_RTDBContext].ConnectionString))
            {
                MySqlDataAdapter da = new MySqlDataAdapter(sql, conn);
                da.Fill(ds);
            }

            return ds.Tables.Count > 0 ? ds.Tables[0] : new DataTable();

        }
        #endregion

        #region JSONstrToDataTable(string) JSON字串轉成DataTable
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


        public SortingMachine_DataViewModel GetSortingMachineData(string Machine_ID)
        {
            // 日期排序，由大到小
            var query = rtm_sortingApp.GetList(Machine_ID).OrderByDescending(o => o.EndTime);
            // 找第一筆
            var machine_data = query.FirstOrDefault();

            var data = new SortingMachine_DataViewModel()
            {
                Flicker = GetFlicker(machine_data.EndTime, machine_data.Status),
                Pass = machine_data.Pass,
                Rejected = machine_data.Rejected,
                Yield = GetYield(machine_data.Pass, machine_data.Rejected),
                Speed = machine_data.Speed,
                Retest = machine_data.Retest,
                Teach = machine_data.Teach,
                Total = machine_data.Total,
                Msg = GetLastMsgTime(machine_data.EndTime, machine_data.Status, machine_data.StartingTime),
                Background = GetBackground(machine_data.EndTime, machine_data.Status),
                Status = GetStatus(machine_data.EndTime, machine_data.Status)
            };
            return data;
        }

        //public FormerMachine_DataViewModel GetFormerMachineData(string Machine_ID)
        //{
        //    var query = rtm_sortingApp.GetList(Machine_ID).OrderByDescending(o => o.EndTime);
        //    var machine_data = query.FirstOrDefault();

        //    List<string> Error = FindError(machine_data);

        //    var data = new FormerMachine_DataViewModel()
        //    {
        //        Flicker = GetFormerFlicker(machine_data.EndTime, machine_data.Status),
        //        Customer = machine_data.Customer,
        //        Speed = machine_data.Speed,
        //        Status = GetFormerStatusString(machine_data.Status),
        //        Error1 = (machine_data.Status != "1" && Error.Count > 0) ? Error[0] : "",
        //        Error2 = (machine_data.Status != "1" && Error.Count > 1) ? Error[1] : "",
        //        Background = GetBackground(machine_data.EndTime, machine_data.Status),
        //        Total = machine_data.Total,
        //        Msg = GetLastMsgTime(machine_data.EndTime, machine_data.Status, machine_data.StartingTime)
        //    };

        //    return data;
        //}

        public string GetFlicker(DateTime Time, string Status)
        {
            string Flicker = "/Content/Images/green_light.png";
            TimeSpan Ts = DateTime.Now - Time;

            if (Status == "0") Flicker = "/Content/Images/red_light.png";
            if (Status == "2") Flicker = "/Content/Images/gray_light.png";
            if (((int)Ts.TotalSeconds) > ExpiredTime) Flicker = "/Content/Images/gray_light.png";

            return Flicker;
        }
        public string GetStatus(DateTime Time, string Status)
        {
            // 0:異常 1:正常 2:無連結
            string vStatus = "1";
            TimeSpan Ts = DateTime.Now - Time;

            if (Status == "0") vStatus = "0";
            if (Status == "2") vStatus = "2";
            if (((int)Ts.TotalSeconds) > ExpiredTime) vStatus = "2";

            return vStatus;
        }
        public string GetFormerFlicker(DateTime Time, string Status)
        {
            string Flicker = "/Content/Images/green_light.png";
            TimeSpan Ts = DateTime.Now - Time;

            if (Status == "0") Flicker = "/Content/Images/yellow_light.png";
            if (Status == "2") Flicker = "/Content/Images/red_light.png";
            if (((int)Ts.TotalSeconds) > ExpiredTime) Flicker = "/Content/Images/gray_light.png";

            return Flicker;
        }

        public string GetYield(int Pass, int Rejected)
        {
            int total = Pass + Rejected;
            if (Pass == 0 || total == 0)
            {
                return "0%";
            }
            else
            {
                return Convert.ToInt32(Math.Round((decimal)Pass / total, 2) * 100) + "%";
            }
        }

        public string GetBackground(DateTime EndTime, string Status)
        {
            string Background = "url(/Content/Images/total_bg_green.png)";
            TimeSpan Ts = DateTime.Now - EndTime;

            if (Status == "0") Background = "url(/Content/Images/total_bg_o.png)";
            if (Status == "2") Background = "url(/Content/Images/total_bg_r.png)";
            if (((int)Ts.TotalSeconds) > ExpiredTime) Background = "url(/Content/Images/total_bg_gray.png)";

            return Background;
        }

        public string GetLastMsgTime(DateTime EndTime, string Status, DateTime StartingTime)
        {
            string Msg = "";

            TimeSpan Ts = DateTime.Now - EndTime;

            if (Status == "0")
            {
                Msg = "最後接收:" + StartingTime.ToString("yyyy-MM-dd HH:mm");
            }else if (Status == "1"){
                Msg = "正常接收中";
            }
            else
            {
                if (((int)Ts.TotalSeconds) > ExpiredTime) Msg = "最後接收時間  :" + EndTime.ToString("yyyy-MM-dd HH:mm");
            }

            return Msg;
        }

        public string GetFormerStatusString(string Status)
        {
            string Msg = "";

            if (Status == "0") Msg = "待機中";
            if (Status == "1") Msg = "正常運作中";
            if (Status == "2") Msg = "機台異常";

            return Msg;
        }

        //public List<string> FindError(RealTime_Former Data)
        //{
        //    List<string> Error = new List<string>();

        //    #region Error訊號清單

        //    if (!Data.MainMotorOverload) Error.Add("主馬達過載");
        //    if (Data.EmergncyStopPressed_OA) Error.Add("緊急停止");
        //    if (!Data.PMA) Error.Add("檢測器異常");
        //    if (!Data.CurrnetOverload) Error.Add("電流過載檢測");
        //    if (!Data.LubOilMotorOverload) Error.Add("潤滑馬達過載");
        //    if (!Data.MainMotorOverHeat) Error.Add("主馬達過熱");
        //    if (!Data.AirPressureLosing) Error.Add("總風壓檢測異常");
        //    if (!Data.LubOilPressureAbnormal) Error.Add("潤滑油壓檢測異常");
        //    if (!Data.PKOandKO_Overload) Error.Add("前/後托風壓檢測異常");
        //    if (Data.EmergncyStopPressed_CA) Error.Add("緊急停止(輸送帶)異常");
        //    if (Data.Counter) Error.Add("運行計數器關閉");
        //    if (!Data.TFA) Error.Add("夾台浮動檢測異常");
        //    if (!Data.ShortFeedingAbnormal) Error.Add("短料檢測訊號異常");

        //    #endregion
        //    return Error;
        //}

        public SortingMachine_DataViewModel GetSortingFailMsg()
        {
            var data = new SortingMachine_DataViewModel()
            {
                Flicker = "/Content/Images/gray_light.png",
                Yield = "",
                Teach = "",
                Msg = "無機台資料連結",
                Background = "url(/Content/Images/total_bg_gray.png)"
            };
            return data;
        }

        //public FormerMachine_DataViewModule GetFormerFailMsg()
        //{
        //    var data = new FormerMachine_DataViewModule()
        //    {
        //        Flicker = "/Content/Images/gray_light.png",
        //        Customer = "--",
        //        Msg = "無機台資料連結",
        //        Background = "url(/Content/Images/total_bg_gray.png)"
        //    };
        //    return data;
        //}
    }
}
