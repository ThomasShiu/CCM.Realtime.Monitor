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