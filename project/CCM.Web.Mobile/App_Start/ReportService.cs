using CCM.Application;
using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace CCM.Web.Mobile
{
    public class ReportService
    {
        private CcmServices cs = new CcmServices();

        #region 公文發文報表
        public LocalReport DOC01_R01(string keyValue, string type, string path)
        {
            string v_sqlstr = " SELECT ISSUEID, COMPANY, EIP.dbo.SF_TWDATEFORMAT(ISSUEDATE,'yyy/mm/dd') ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate" +
                             " FROM FR_OFFIDOC_ISSUE " +
                             " WHERE  SID = '" + keyValue + "' ";

            //資料集
            DataTable dt = cs.GetDataSet(v_sqlstr);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            return localReport;
        }
        #endregion

        #region 公務車每日里程統計表
        public LocalReport PUB01_R01(string keyValue, string type ,string path)
        {
            string v_sqlstr = " SELECT A.SID, A.ObjectType,B.ObjectNM, A.UseReason, A.Subject, A.[Description], A.EmployeeID, A.DepartmentID, A.ObjectSID,  " +
                            "          A.BookingStartTime, A.BookingEndTime, A.AttendEmp, A.ProjectSID, A.Mileage, A.MileageLast,(A.Mileage - A.MileageLast) ttlmile, " +
                            "          A.Status, A.LeaveTime, A.BackTime, A.GuardEMPID,C.USR_NM " +
                            "  FROM PO_PUBLIC_OBJECT_BOOKING A LEFT JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID " +
                            "  LEFT JOIN PO_GUARDNO C ON A.GuardEMPID = C.USR_NO " +
                            "  WHERE CONVERT(VARCHAR(10), A.BookingStartTime, 120) = '" + keyValue + "' " +
                            "  AND A.ObjectType = '公務車輛' AND A.Status = '結束' " +
                            "  ORDER BY B.ObjectNM,A.GuardEMPID ";

            //資料集
            DataTable dt = cs.GetDataSet(v_sqlstr);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            ReportParameter p_1 = new ReportParameter("P_date", keyValue);
            localReport.SetParameters(new ReportParameter[] { p_1 });

           
            return localReport;
        }
        #endregion

        #region 公務車每月里程統計表
        public LocalReport PUB01_R02(string keyValue, string type, string path)
        {
            string v_sqlstr = "SELECT B.ObjectNM, CONVERT(VARCHAR(7),A.BookingStartTime,120) YM, " +
                           "       sum(A.Mileage - A.MileageLast) ttlmile " +
                           "  FROM PO_PUBLIC_OBJECT_BOOKING A LEFT JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID " +
                           " LEFT JOIN PO_GUARDNO C ON A.GuardEMPID = C.USR_NO " +
                           " WHERE CONVERT(VARCHAR(4), A.BookingStartTime, 112) = '" + keyValue + "' " +
                           " AND A.ObjectType = '公務車輛' AND A.Status = '結束' " +
                           " GROUP BY B.ObjectNM, CONVERT(VARCHAR(7), A.BookingStartTime, 120) " +
                           " ORDER BY 1,2 ";
            string v_sqlstr2 = " SELECT B.ObjectNM, CONVERT(VARCHAR(7),A.BookingStartTime,120) YM, MAX(A.Mileage) Mileage " +
                            " FROM PO_PUBLIC_OBJECT_BOOKING A LEFT JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID " +
                            " LEFT JOIN PO_GUARDNO C ON A.GuardEMPID = C.USR_NO " +
                            " WHERE CONVERT(VARCHAR(4), A.BookingStartTime, 112) = '" + keyValue + "' " +
                            " AND A.ObjectType = '公務車輛' AND A.Status = '結束' " +
                            " GROUP BY B.ObjectNM, CONVERT(VARCHAR(7), A.BookingStartTime, 120) " +
                            " ORDER BY 1,2 ";

            //資料集
            DataTable dt = cs.GetDataSet(v_sqlstr);
            DataTable dt2 = cs.GetDataSet(v_sqlstr2);
            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            ReportDataSource reportDataSource2 = new ReportDataSource("DataSet2", dt2);
            localReport.DataSources.Add(reportDataSource2);
            localReport.EnableExternalImages = true;

            ReportParameter p_1 = new ReportParameter("P_date", keyValue);
            localReport.SetParameters(new ReportParameter[] { p_1 });


            return localReport;
        }
        #endregion

        #region 便當/團購統計表
        public LocalReport ORD02_R01(string keyValue, string type, string path)
        {
            string v_sqlstr1 = " SELECT A.SID,A.Subject, A.StoreID,B.[Name], A.OrderContent, A.StartDate, A.EndDate, A.CreatorTime, "+
                            "       dbo.SF_GETEMPNAME(A.EmployeeID) EMPLYNM,dbo.SF_GETDEPTBYDEPT(A.DepartmentID) DEPTNM,  " +
                            "       A.Qty, A.Amount, A.SubsidizeAmount " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID " +
                            " WHERE A.SID = '"+ keyValue + "' ";
            string v_sqlstr2 = " SELECT dbo.SF_GETEMPNAME(C.EmpID) +'-'+dbo.SF_GETDEPTBYDEPT(C.DepID) EMPLYNM, C.OrderMenuSID,D.MealsName,  " +
                            "        C.UnitPrice,C.Qty, E.AdjustItem, C.AdjustAmount, C.AdjustQty, C.Amount,C.OrderDate " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID  " +
                            " LEFT JOIN BU_ORDERS_DETAIL C ON A.SID = C.ParentSID  " +
                            " LEFT OUTER JOIN BU_ORDERS_MENU D ON C.OrderMenuSID = D.SID " +
                            " LEFT OUTER JOIN BU_ORDERS_ADJUST E ON C.AdjustSID = E.SID " +
                            " WHERE A.SID = '" + keyValue + "' ";
            string v_sqlstr3 = " SELECT  D.MealsName, C.UnitPrice,SUM(C.Qty) Qty, C.UnitPrice*SUM(C.Qty) Amount " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID " +
                            " LEFT JOIN BU_ORDERS_DETAIL C ON A.SID = C.ParentSID " +
                            " LEFT OUTER JOIN BU_ORDERS_MENU D ON C.OrderMenuSID = D.SID " +
                            " LEFT OUTER JOIN BU_ORDERS_ADJUST E ON C.AdjustSID = E.SID " +
                            " WHERE A.SID = '" + keyValue + "' " +
                            " GROUP BY D.MealsName, C.UnitPrice ";
            string v_sqlstr4 = " SELECT dbo.SF_GETEMPNAME(C.EmpID) +'-'+dbo.SF_GETDEPTBYDEPT(C.DepID) ITEM,C.Qty,(C.UnitPrice*C.Qty)-65  Amount " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID " +
                            " LEFT JOIN BU_ORDERS_DETAIL C ON A.SID = C.ParentSID " +
                            " LEFT OUTER JOIN BU_ORDERS_MENU D ON C.OrderMenuSID = D.SID " +
                            " LEFT OUTER JOIN BU_ORDERS_ADJUST E ON C.AdjustSID = E.SID " +
                            " WHERE A.SID = '" + keyValue + "' ";
            string v_sqlstr5 = " SELECT  dbo.SF_GETDEPTBYDEPT(C.DepID) ITEM, SUM(C.Qty) Qty, C.UnitPrice*SUM(C.Qty) Amount " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID " +
                            " LEFT JOIN BU_ORDERS_DETAIL C ON A.SID = C.ParentSID " +
                            " LEFT OUTER JOIN BU_ORDERS_MENU D ON C.OrderMenuSID = D.SID " +
                            " LEFT OUTER JOIN BU_ORDERS_ADJUST E ON C.AdjustSID = E.SID " +
                            " WHERE A.SID = '" + keyValue + "' " +
                            " GROUP BY dbo.SF_GETDEPTBYDEPT(C.DepID), C.UnitPrice ";
            string v_sqlstr6 = "  SELECT   '精湛' ITEM,SUM(C.Qty) Qty, SUM(C.UnitPrice*C.Qty) Amount " +
                            " FROM BU_ORDERS A LEFT JOIN BU_ORDERS_SOTRE B ON A.StoreID = B.SID " +
                            " LEFT JOIN BU_ORDERS_DETAIL C ON A.SID = C.ParentSID " +
                            " LEFT OUTER JOIN BU_ORDERS_MENU D ON C.OrderMenuSID = D.SID " +
                            " LEFT OUTER JOIN BU_ORDERS_ADJUST E ON C.AdjustSID = E.SID " +
                            " WHERE A.SID = '" + keyValue + "' ";
            //資料集
            DataTable dt1 = cs.GetDataSet(v_sqlstr1);
            DataTable dt2 = cs.GetDataSet(v_sqlstr2);
            DataTable dt3 = cs.GetDataSet(v_sqlstr3);
            DataTable dt4 = cs.GetDataSet(v_sqlstr4);
            DataTable dt5 = cs.GetDataSet(v_sqlstr5);
            DataTable dt6 = cs.GetDataSet(v_sqlstr6);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt1);
            localReport.DataSources.Add(reportDataSource);
            reportDataSource = new ReportDataSource("DataSet2", dt2);
            localReport.DataSources.Add(reportDataSource);
            reportDataSource = new ReportDataSource("DataSet3", dt3);
            localReport.DataSources.Add(reportDataSource);
            reportDataSource = new ReportDataSource("DataSet4", dt4);
            localReport.DataSources.Add(reportDataSource);
            reportDataSource = new ReportDataSource("DataSet5", dt5);
            localReport.DataSources.Add(reportDataSource);
            reportDataSource = new ReportDataSource("DataSet6", dt6);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            return localReport;
        }
        #endregion

        #region 午餐登記明細表
        public LocalReport ORD06_R01(string keyValue, string type, string path)
        {
            string v_year = keyValue.Substring(0, 4);
            string v_mon = keyValue.Substring(5, 2);
            string v_sqlstr = " SELECT LOCATION,LOCATIONM,LUTYPENM,DEPNM,EMPNM,LUDATE,STARTDATE, " +
                            " CONVERT(VARCHAR(10), DATEADD(s, -1, DATEADD(mm, DATEDIFF(m, 0, ENDDATE) + 1, 0)), 111) ENDDATE,MEATPEOPLES, VEGEPEOPLES " +
                            " FROM( " +
                            "   SELECT LOCATION, CASE WHEN LOCATION = '1' THEN '精湛總廠' WHEN LOCATION = '2' THEN '一廠' WHEN LOCATION = '3' THEN '全盈' WHEN LOCATION = '4' THEN '關廟' WHEN LOCATION = '5' THEN '柳營' END AS LOCATIONM, " +
                            "   CASE WHEN LUTYPE = '1' THEN '預訂單日不用餐' WHEN LUTYPE = '2' THEN '預訂整月不用餐' WHEN LUTYPE = '3' THEN '預訂素食用餐' WHEN LUTYPE = '4' THEN '預訂訪客用餐' WHEN LUTYPE = '5' THEN '新到離職扣款' END AS LUTYPENM, " +
                            "   dbo.SF_GETDEPTBYDEPT(DEPID) DEPNM, dbo.SF_GETEMPNAME(EMPLYID) EMPNM, LUDATE, " +
                            "   CASE WHEN FROM_YEAR <> '' THEN(FROM_YEAR + '/' + FROM_MONTH + '/' + '01') END AS STARTDATE, CASE WHEN TO_YEAR <> '' THEN(TO_YEAR + '/' + TO_MONTH + '/' + '01') END AS ENDDATE, " +
                            "   MEATPEOPLES, VEGEPEOPLES " +
                            "    FROM EIP.dbo.BU_LUNCH " +
                            "    WHERE(FROM_YEAR = '"+ v_year + "' AND FROM_MONTH = '"+ v_mon + "') " +
                            "    OR(CONVERT(VARCHAR(6), LUDATE, 112) = '"+ v_year + v_mon + "') " +
                            "  ) A " +
                            " ORDER BY 1,2,3,4 ";

            //資料集
            DataTable dt = cs.GetDataSet(v_sqlstr);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            ReportParameter p_1 = new ReportParameter("P_date", keyValue);
            localReport.SetParameters(new ReportParameter[] { p_1 });


            return localReport;
        }
        #endregion

        #region 午餐登記統計表
        public LocalReport ORD07_R01(string keyValue, string type, string path)
        {
            string v_ym = keyValue.Substring(0, 7);
            string v_sqlstr = "SELECT LUNCHDATE, LOCATION, MEATPEOPLES, VEGEPEOPLES,AbsentMEATPEOPLES, AbsentVEGEPEOPLES, ChangeMEATPEOPLES, ChangeVEGEPEOPLES,  " +
                            "    TuneMEATPEOPLES, TuneVEGEPEOPLES, REALMEATPEOPLES, REALVEGEPEOPLES, TunePAYEMPLYS, REALPAYEMPLYS,UNITPRICE, TOTAL, " +
                            "    CASE WHEN LOCATION= '1' THEN '精湛總廠' WHEN LOCATION= '2' THEN '一廠' WHEN LOCATION= '3' THEN '全盈' WHEN LOCATION= '4' THEN '關廟' WHEN LOCATION= '5' THEN '柳營' END AS LOCATIONM " +
                            " FROM EIP.dbo.BU_LUNCH_AMOUNT " +
                            " WHERE CONVERT(VARCHAR(7), LUNCHDATE, 120) = '"+ v_ym + "' " +
                            " ORDER BY LOCATION,LUNCHDATE ";

            //資料集
            DataTable dt = cs.GetDataSet(v_sqlstr);

            LocalReport localReport = new LocalReport();
            localReport.ReportPath = path;
            ReportDataSource reportDataSource = new ReportDataSource("DataSet1", dt);
            localReport.DataSources.Add(reportDataSource);
            localReport.EnableExternalImages = true;

            ReportParameter p_1 = new ReportParameter("P_date", keyValue);
            localReport.SetParameters(new ReportParameter[] { p_1 });


            return localReport;
        }
        #endregion
    }
}