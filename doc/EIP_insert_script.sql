DELETE [EIP].[dbo].[FR_OFFIDOC_ISSUE];

INSERT INTO [EIP].[dbo].[FR_OFFIDOC_ISSUE](
ISSUEID, COMPANY, ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, 
PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate,GUID
)
SELECT ISSUEID, COMPANY, ISSUEDATE, OFFICIAL_NM, SUBJECT, DESCR, AttachFIle, EMPID, DEPID, STATUS, DOCTYPE, CONTACT, 
PHONEAREACODE, PHONE, PHONEEXTENSION, FAX, Original, Duplicate,GUID
 FROM EIP01.dbo.FR_OFFIDOC_ISSUE;
 
INSERT INTO EIP.dbo.FR_OFFIDOC_ISSUE_ATTACH_FILE(
SID,ParentISSUEID, [Name], UploadPath
)
SELECT SID,ParentISSUEID, [Name], UploadPath
 FROM EIP01.dbo.FR_OFFIDOC_ISSUE_ATTACH_FILE
 
 
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