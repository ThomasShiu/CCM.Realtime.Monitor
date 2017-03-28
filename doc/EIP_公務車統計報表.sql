SELECT A.ObjectType, A.UseReason, A.Subject, A.[Description], A.EmployeeID, A.DepartmentID, A.BookingStartTime, A.BookingEndTime, A.CreateTime, A.AttendEmp, A.ProjectSID, A.Mileage, A.MileageLast, A.Status, A.LeaveTime, A.BackTime, A.GuardEMPID,A.GUID
,dbo.SF_GETDEPTBYDEPT(B.DEPID) DEPNM, EMP_NO,dbo.SF_GETEMPNAME(B.EMP_NO) EMP_NM
,(SELECT COUNT(C.ParentSID) FROM PO_PUBLIC_OBJECT_ATTEND_EMP C WHERE C.ParentSID = A.GUID GROUP BY C.ParentSID) CNT
,STUFF( (SELECT ', ' + dbo.SF_GETEMPNAME(C.EMP_NO) from PO_PUBLIC_OBJECT_ATTEND_EMP C WHERE C.ParentSID = A.GUID FOR XML PATH('')), 1, 1, '') AS ATTEND_EMP
 FROM PO_PUBLIC_OBJECT_BOOKING A  LEFT OUTER JOIN PO_PUBLIC_OBJECT_ATTEND_EMP B ON A.GUID=B.ParentSID
 WHERE A.ObjectType IN ('公務車輛') AND BookingStartTime >= '2017-03-20' 
 GROUP BY A.ObjectType, A.UseReason, A.Subject, A.[Description], A.EmployeeID, A.DepartmentID, A.BookingStartTime, A.BookingEndTime, A.CreateTime, A.AttendEmp, A.ProjectSID, A.Mileage, A.MileageLast, A.Status, A.LeaveTime, A.BackTime, A.GuardEMPID,A.GUID
,dbo.SF_GETDEPTBYDEPT(B.DEPID), EMP_NO,dbo.SF_GETEMPNAME(B.EMP_NO) 
 ORDER BY BookingStartTime,DepartmentID
 
 
 SELECT B.ObjectNM AS id,A.Subject AS title,CASE WHEN A.Status='取消' THEN '#999999' ELSE A.BgColor END AS BgColor,
           B.ObjectNM+'<br/>'+'('+dbo.SF_GETEMPNAME(A.EmployeeID)+') '+A.Subject+'<br/>事由:'+A.[Description]+'<br/>時間:'+
            CONVERT(VARCHAR(5), A.BookingStartTime, 108)+'~'+CONVERT(VARCHAR(5), A.BookingEndTime, 108) AS description,  
           CONVERT(VARCHAR(16), A.BookingStartTime, 120) BookingStartTime, CONVERT(VARCHAR(16), A.BookingEndTime, 120) AS BookingEndTime ,
           STUFF( (SELECT ', ' + dbo.SF_GETEMPNAME(C.EMP_NO) from PO_PUBLIC_OBJECT_ATTEND_EMP C WHERE C.ParentSID = A.GUID FOR XML PATH('')), 1, 1, '') AS ATTEND_EMP
 FROM PO_PUBLIC_OBJECT_BOOKING A JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID = B.SID 
 WHERE A.ObjectType IN ('公務車輛') AND BookingStartTime >= '2017-03-20' 