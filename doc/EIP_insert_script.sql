-- 公文發文
DELETE [EIP].[dbo].[FR_OFFIDOC_ISSUE];
DELETE [EIP].[dbo].[FR_OFFIDOC_ISSUE_ATTACH_FILE];

INSERT INTO [EIP].[dbo].[FR_OFFIDOC_ISSUE](
ISSUEID, COMPANY, ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, 
PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate,GUID
)
SELECT ISSUEID, COMPANY, ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, 
PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate,GUID
 FROM EIP01.dbo.FR_OFFIDOC_ISSUE;

 --發文附件
INSERT INTO EIP.dbo.FR_OFFIDOC_ISSUE_ATTACH_FILE(
SID,ParentISSUEID, [Name], UploadPath
)
SELECT SID,ParentISSUEID, [Name], UploadPath
 FROM EIP01.dbo.FR_OFFIDOC_ISSUE_ATTACH_FILE
 
-- 公文收文
DELETE EIP.dbo.FR_OFFIDOC_RECE;
DELETE EIP.dbo.FR_OFFIDOC_RECE_ATTACH_FILE;

INSERT INTO EIP.dbo.FR_OFFIDOC_RECE(
RECEIVEID, RECEDATE, OFFICIAL_NM, OFFICIAL_DOCID, OFFICIAL_DOCTYPE, DESCR, AttachFIle, EMPID, COMID, DEPID, STATUS,GUID
)
SELECT RECEIVEID, RECEDATE, OFFICIAL_NM, OFFICIAL_DOCID, OFFICIAL_DOCTYPE, DESCR, AttachFIle, EMPID, COMID, DEPID, STATUS,GUID
 FROM EIP01.dbo.FR_OFFIDOC_RECE;

--收文附件
 INSERT INTO EIP.dbo.FR_OFFIDOC_RECE_ATTACH_FILE(
 SID,ParentRECEIVEID, [Name], UploadPath
 )
SELECT SID,ParentRECEIVEID, [Name], UploadPath
 FROM EIP01.dbo.FR_OFFIDOC_RECE_ATTACH_FILE;

-- 公務車 會議室
DELETE EIP.dbo.PO_PUBLIC_OBJECT

INSERT INTO PO_PUBLIC_OBJECT(SID,ObjectType, ObjectNM, Description, Enable, PhotoUrl, EnableDate, Mileage, MaintenanceMileage, MaintenanceDate, RemindDate, DontMaintenance, Location)
SELECT SID,ObjectType, ObjectNM, Description, rtrim(Open_), PhotoUrl, EnableDate, Mileage, MaintenanceMileage, MaintenanceDate, RemindDate, DontMaintenance, Location
 FROM EIP01.dbo.PO_PUBLIC_OBJECT

--公務車預約
DELETE EIP.dbo.PO_PUBLIC_OBJECT_BOOKING

INSERT INTO EIP.dbo.PO_PUBLIC_OBJECT_BOOKING(SID,ObjectType, UseReason, Subject, [Description], EmployeeID, DepartmentID, ObjectSID, BookingStartTime, BookingEndTime, CreateTime, ProjectSID, Mileage, MileageLast, Status, LeaveTime, BackTime, GuardEMPID)
SELECT SID,ObjectType, UseReason, Subject, [Description], EmployeeID, DepartmentID, ObjectSID, BookingStartTime, BookingEndTime, CreateTime, ProjectSID, Mileage, MileageLast, Status, LeaveTime, BackTime, GuardEMPID
 FROM EIP01.dbo.PO_PUBLIC_OBJECT_BOOKING
 
 
--簽核流程設定
DELETE EIP.dbo.WF_FLOWD;
DELETE EIP.dbo.WF_FLOWM;

INSERT INTO EIP.dbo.WF_FLOWM(FLOWID, FLOWNM, FLOWDSC, DEACT, DB, TABLENM,SID)
SELECT FLOWID, FLOWNM, FLOWDSC, DEACT, DB, TABLENM,SID
 FROM EIP01.dbo.WF_FLOWM;

INSERT INTO EIP.dbo.WF_FLOWD(FLOWSID, FLOWID, SITEID,ROLEID)
SELECT FLOWSID, FLOWID, SITEID,ROLEID
 FROM EIP01.dbo.WF_FLOWD;
 
--簽核角色設定
DELETE EIP.dbo.WF_ROLEM;
DELETE EIP.dbo.WF_ROLED;

INSERT INTO EIP.dbo.WF_ROLEM(ROLEID, ROLENM, REMARK,PROXY)
SELECT ROLEID, ROLENM, REMARK,PROXY
 FROM EIP01..WF_ROLEM;

INSERT INTO EIP..WF_ROLED(, ROLEID, DEP_NO, EMPLYID8, ACTIVE, ASSIGNDATE, PROXY1, PROXY2,PROXY3)
SELECT  ROLEID, DEP_NO, EMPLYID8, ACTIVE, ASSIGNDATE, PROXY1, PROXY2,PROXY3
 FROM EIP01..WF_ROLED;
 
--加班簽核途程
DELETE EIP..WF_SIGNM
DELETE EIP..WF_SIGND

INSERT INTO EIP..WF_SIGNM(SIGNID, FLOWID, SUBJECT, STATUS, EMP_ID, SENDDATE, FINISHDATE, DOCID)
SELECT SIGNID, FLOWID, SUBJECT, STATUS, EMP_ID, SENDDATE, FINISHDATE, DOCID
 FROM EIP01..WF_SIGNM
 WHERE SIGNID > '1000'

INSERT INTO EIP..WF_SIGND(SIGNSID, SIGNID, SITEID, STATUS, EMPLYID, SIGNDATE,REPLY)
SELECT SIGNSID, SIGNID, SITEID, STATUS, EMPLYID, SIGNDATE,REPLY
 FROM EIP01..WF_SIGND
 WHERE SIGNSID > 23000
 
--加班單
SELECT *
INTO EIP.dbo.HR_OVRTM
 FROM HRSDBR53.dbo.HR_OVRTM;

--DELETE EIP.dbo.HR_OVRTM;
 
 
 
INSERT INTO [EIP].[dbo].[BE_DEPM_MAIL](
      [SID]
      ,[DEPM_NM]
      ,[MAIL])
SELECT [SID]
      ,[DEPM_NM]
      ,[MAIL]
  FROM [EIP01].[dbo].[BE_DEPM_MAIL]


INSERT INTO [EIP].[dbo].[BE_HR](
		[Ref_NM]
      ,[Ref_Value])
  SELECT [Ref_NM]
      ,[Ref_Value]
  FROM [EIP01].[dbo].[BE_HR]


INSERT INTO [EIP].[dbo].[BE_MailNotifySetting](
[SID],[Program_ID],[EMAIL] )
  SELECT [SID]
      ,[Program_ID]
      ,[EMAIL]
  FROM [EIP01].[dbo].[BE_MailNotifySetting]

INSERT INTO [EIP].[dbo].[BU_BULLETIN](
[SID]
      ,[BUSubject]
      ,[BUContent]
      ,[StartDate]
      ,[EndDate]
      ,[WhoCanSee]
      ,[DepartmentID]
      ,[EmployeeID]
      ,[GUID]
)
  SELECT [SID]
      ,[BUSubject]
      ,[BUContent]
      ,[StartDate]
      ,[EndDate]
      ,[WhoCanSee]
      ,[DepartmentID]
      ,[EmployeeID]
      ,[GUID]
  FROM [EIP01].[dbo].[BU_BULLETIN]

  INSERT INTO [EIP].[dbo].[BU_BULLETIN_ATTACH_FILE](
  [SID]
      ,[ParentSID]
      ,[Name]
      ,[UploadPath])
  SELECT [SID]
      ,[ParentSID]
      ,[Name]
      ,[UploadPath]
  FROM [EIP01].[dbo].[BU_BULLETIN_ATTACH_FILE]