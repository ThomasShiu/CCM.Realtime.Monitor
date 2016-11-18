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