USE [master]
GO
/****** Object:  Database [EIP01]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE DATABASE [EIP01] ON  PRIMARY 
( NAME = N'EIP01', FILENAME = N'D:\DBDATA\EIP01.mdf' , SIZE = 204800KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB ), 
 FILEGROUP [EIP01_IDX] 
( NAME = N'EIP01_IDX', FILENAME = N'D:\DBDATA\EIP01_IDX.ndf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EIP01_log', FILENAME = N'D:\DBDATA\EIP01_log.ldf' , SIZE = 26816KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EIP01] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EIP01].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EIP01] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EIP01] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EIP01] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EIP01] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EIP01] SET ARITHABORT OFF 
GO
ALTER DATABASE [EIP01] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EIP01] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EIP01] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EIP01] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EIP01] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EIP01] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EIP01] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EIP01] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EIP01] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EIP01] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EIP01] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EIP01] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EIP01] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EIP01] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EIP01] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EIP01] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EIP01] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EIP01] SET RECOVERY FULL 
GO
ALTER DATABASE [EIP01] SET  MULTI_USER 
GO
ALTER DATABASE [EIP01] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EIP01] SET DB_CHAINING OFF 
GO
USE [EIP01]
GO
/****** Object:  User [QryUser]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE USER [QryUser] FOR LOGIN [QryUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  User [MisPGUser]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE USER [MisPGUser] FOR LOGIN [MisPGUser] WITH DEFAULT_SCHEMA=[dbo]
GO
/****** Object:  Default [Default_Value_2369]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE DEFAULT [dbo].[Default_Value_2369] 
AS
'Y'

GO
/****** Object:  Default [Set_To_10000]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE DEFAULT [dbo].[Set_To_10000] 
AS
10000

GO
/****** Object:  Default [Set_To_Now]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE DEFAULT [dbo].[Set_To_Now] 
AS
getdate()

GO
/****** Object:  Default [Set_To_Yes]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE DEFAULT [dbo].[Set_To_Yes] 
AS
'Y'

GO
/****** Object:  UserDefinedTableType [dbo].[IdsTableType]    Script Date: 2016/11/18 上午 10:08:57 ******/
CREATE TYPE [dbo].[IdsTableType] AS TABLE(
	[Id] [uniqueidentifier] NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[SF_GETDEPT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SF_GETDEPT]
(@V_EMP_NO varchar(50))
RETURNS nvarchar(250)
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @V_DEPT_NM NVARCHAR(250) =''
 
SELECT @V_DEPT_NM= DEPNM
 FROM EIP01.dbo.VIEW_employee
 WHERE EMPLYID = @V_EMP_NO
 
 RETURN @V_DEPT_NM
END
GO
/****** Object:  UserDefinedFunction [dbo].[SF_GETEMPNAME]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SF_GETEMPNAME]
(@V_EMP_NO varchar(50))
RETURNS nvarchar(250)
WITH EXEC AS CALLER
AS
BEGIN
DECLARE @V_EMP_NM NVARCHAR(250) =''
 
SELECT @V_EMP_NM= EMP_NM
 FROM EIP01.dbo.V_EMPNO_ALL
 WHERE EMP_NO = @V_EMP_NO
 
 
 RETURN @V_EMP_NM
END
GO
/****** Object:  UserDefinedFunction [dbo].[SF_ITEM_NM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SF_ITEM_NM] (@V_ITEM_NO NCHAR(24))
RETURNS NVARCHAR(MAX)
AS

BEGIN
 DECLARE @V_ITEM_NM NVARCHAR(250)
 
 SELECT @V_ITEM_NM=ITEM_NM FROM V_ERP_ITEM
 WHERE ITEM_NO = @V_ITEM_NO

 RETURN @V_ITEM_NM
END
GO
/****** Object:  Table [dbo].[ActionLog]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ActionLog](
	[LogId] [bigint] IDENTITY(0,1) NOT NULL,
	[Operator] [varchar](10) NOT NULL,
	[Refer] [varchar](300) NULL,
	[Destination] [varchar](300) NOT NULL,
	[Method] [varchar](5) NULL,
	[MobleDevices] [bit] NOT NULL,
	[IPAddress] [varchar](40) NULL,
	[RequestTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ActionLog_1] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BE_DEPM_MAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BE_DEPM_MAIL](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[DEPM_NM] [nvarchar](50) NULL,
	[MAIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_BE_DEPM_MAIL] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BE_HR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BE_HR](
	[Ref_NM] [nvarchar](50) NULL,
	[Ref_Value] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BE_MailNotifySetting]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BE_MailNotifySetting](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Program_ID] [nvarchar](50) NULL,
	[EMAIL] [nvarchar](50) NULL,
 CONSTRAINT [PK_BE_MailNotifySetting] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_BULLETIN]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_BULLETIN](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[BUSubject] [nvarchar](100) NULL,
	[BUContent] [nvarchar](max) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[WhoCanSee] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](10) NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[GUID] [nchar](32) NULL,
 CONSTRAINT [PK_BU_BULLETIN] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_BULLETIN_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BU_BULLETIN_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_BU_BULLETIN_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BU_BULLETINITEMS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_BULLETINITEMS](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[BUType] [nvarchar](10) NULL,
	[BUSubject] [nvarchar](100) NULL,
	[BUContent] [nvarchar](max) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[WhoCanSee] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](10) NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[ChooseMode] [nvarchar](10) NULL,
	[UseAmount] [nvarchar](10) NULL,
	[Item01] [nvarchar](100) NULL,
	[Item01Description] [nvarchar](250) NULL,
	[Item02] [nvarchar](100) NULL,
	[Item02Description] [nvarchar](250) NULL,
	[Item03] [nvarchar](100) NULL,
	[Item03Description] [nvarchar](250) NULL,
	[Item04] [nvarchar](100) NULL,
	[Item04Description] [nvarchar](250) NULL,
	[Item05] [nvarchar](100) NULL,
	[Item05Description] [nvarchar](250) NULL,
	[Item06] [nvarchar](100) NULL,
	[Item06Description] [nvarchar](250) NULL,
	[Item07] [nvarchar](100) NULL,
	[Item07Description] [nvarchar](250) NULL,
	[Item08] [nvarchar](100) NULL,
	[Item08Description] [nvarchar](250) NULL,
	[Item09] [nvarchar](100) NULL,
	[Item09Description] [nvarchar](250) NULL,
	[Item10] [nvarchar](100) NULL,
	[Item10Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_BU_ITEMS] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_BULLETINITEMS_REPLY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_BULLETINITEMS_REPLY](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[ReplyDate] [smalldatetime] NULL,
	[ReplyItem] [nvarchar](20) NULL,
	[ReplyAmount] [int] NULL,
	[ReplyContent] [nvarchar](1000) NULL,
 CONSTRAINT [PK_BU_BULLETINITEMS_RESULT] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_FEEDBACK]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_FEEDBACK](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[FeedBackType] [nvarchar](10) NULL,
	[FeedBackContent] [nvarchar](max) NULL,
	[CreateDate] [nvarchar](10) NULL,
	[WhoCanSee] [nvarchar](250) NULL,
	[DepartmentID] [nvarchar](10) NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[ReplyContent] [nvarchar](max) NULL,
	[ReplyDate] [nvarchar](10) NULL,
	[ReplyDepartmentID] [nvarchar](10) NULL,
	[ReplyEmployeeID] [nvarchar](10) NULL,
	[Status] [nvarchar](10) NULL,
 CONSTRAINT [PK_BU_FEEDBACK] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_GUESTBOOK]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_GUESTBOOK](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Content] [nvarchar](500) NULL,
	[CreateTime] [datetime] NULL,
	[Reply] [nvarchar](500) NULL,
	[ReplyTime] [datetime] NULL,
 CONSTRAINT [PK__BU_GUEST__3213E83F3DD3211E] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_LUNCH]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_LUNCH](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[LUTYPE] [nchar](1) NULL,
	[LOCATION] [nvarchar](20) NULL,
	[LUDATE] [smalldatetime] NULL,
	[FROM_YEAR] [nchar](4) NULL,
	[FROM_MONTH] [nchar](2) NULL,
	[TO_YEAR] [nchar](4) NULL,
	[TO_MONTH] [nchar](2) NULL,
	[EMPLYID] [nvarchar](10) NULL,
	[DEPID] [nvarchar](10) NULL,
	[MEATPEOPLES] [int] NULL,
	[VEGEPEOPLES] [int] NULL,
	[AMOUNT] [int] NULL,
	[REMK] [nvarchar](100) NULL,
 CONSTRAINT [PK_BU_LUNCH] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_LUNCH_AMOUNT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_LUNCH_AMOUNT](
	[LUNCHDATE] [smalldatetime] NOT NULL,
	[LOCATION] [nvarchar](20) NOT NULL,
	[MEATPEOPLES] [int] NULL,
	[VEGEPEOPLES] [int] NULL,
	[AbsentMEATPEOPLES] [int] NULL,
	[AbsentVEGEPEOPLES] [int] NULL,
	[ChangeMEATPEOPLES] [int] NULL,
	[ChangeVEGEPEOPLES] [int] NULL,
	[TuneMEATPEOPLES] [int] NULL,
	[TuneVEGEPEOPLES] [int] NULL,
	[REALMEATPEOPLES] [int] NULL,
	[REALVEGEPEOPLES] [int] NULL,
	[TunePAYEMPLYS] [int] NULL,
	[REALPAYEMPLYS] [int] NULL,
	[UNITPRICE] [int] NULL,
	[TOTAL] [int] NULL,
	[REMARK] [nvarchar](200) NULL,
 CONSTRAINT [PK_BU_LUNCH_AMOUNT] PRIMARY KEY CLUSTERED 
(
	[LUNCHDATE] ASC,
	[LOCATION] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_LUNCH_DEPQTY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_LUNCH_DEPQTY](
	[LUNCHDATE] [smalldatetime] NOT NULL,
	[DEPID] [nvarchar](10) NOT NULL,
	[LOCATION] [nvarchar](10) NULL,
	[LUNCHQTY] [int] NULL,
 CONSTRAINT [PK_BU_LUNCH_DEPQTY_1] PRIMARY KEY CLUSTERED 
(
	[LUNCHDATE] ASC,
	[DEPID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_LUNCH_SETTING]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_LUNCH_SETTING](
	[EMPLYID] [nvarchar](10) NOT NULL,
	[DEPID] [nvarchar](10) NULL,
	[LOCATION] [nvarchar](20) NULL,
	[MEAT] [int] NULL,
	[VEGETABLE] [int] NULL,
	[REMARK] [nvarchar](50) NULL,
 CONSTRAINT [PK_BU_LUNCH_SETTING] PRIMARY KEY CLUSTERED 
(
	[EMPLYID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_ORDERS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_ORDERS](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](100) NULL,
	[StoreID] [bigint] NULL,
	[OrderContent] [nvarchar](max) NULL,
	[WhoCanSee] [nvarchar](250) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[CreateDate] [smalldatetime] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[Qty] [int] NULL,
	[Amount] [int] NULL,
	[SubsidizeAmount] [int] NULL,
	[GUID] [nchar](32) NULL,
 CONSTRAINT [PK_BU_ORDERS] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_ORDERS_ADJUST]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_ORDERS_ADJUST](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[AdjustItem] [nvarchar](50) NULL,
	[AdjustAmount] [int] NULL,
	[Remark] [nvarchar](250) NULL,
 CONSTRAINT [PK_BU_ORDERS_ADJUST] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_ORDERS_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BU_ORDERS_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_BU_ORDERS_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BU_ORDERS_DETAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_ORDERS_DETAIL](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[OrderDate] [smalldatetime] NULL,
	[EmpID] [nvarchar](10) NULL,
	[DepID] [nvarchar](10) NULL,
	[OrderMenuSID] [bigint] NULL,
	[Qty] [int] NULL,
	[UnitPrice] [int] NULL,
	[AdjustSID] [bigint] NULL,
	[AdjustAmount] [int] NULL,
	[AdjustQty] [int] NULL,
	[Amount] [int] NULL,
	[Remark] [nvarchar](100) NULL,
 CONSTRAINT [PK_BU_ORDERS_DETAIL] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_ORDERS_MENU]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_ORDERS_MENU](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[MealsName] [nvarchar](50) NULL,
	[UnitPrice] [int] NULL,
	[Remark] [nvarchar](100) NULL,
 CONSTRAINT [PK_BU_MEALS] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_ORDERS_SOTRE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_ORDERS_SOTRE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[Fax] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Contact] [nvarchar](50) NULL,
	[SubsidizeAmount] [int] NULL,
	[ContributingVendor] [nvarchar](10) NULL,
	[WebSiteURL] [nvarchar](200) NULL,
	[Offer] [nvarchar](max) NULL,
	[Remark] [nvarchar](max) NULL,
 CONSTRAINT [PK_BU_MEALS_SOTRE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_REPAIR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_REPAIR](
	[AppID] [nchar](10) NOT NULL,
	[AppDEPID] [nvarchar](10) NULL,
	[AppEMPID] [nvarchar](10) NULL,
	[AppDate] [smalldatetime] NULL,
	[AppEMPExtension] [nvarchar](10) NULL,
	[Location] [nchar](1) NULL,
	[RepairPlace] [nvarchar](50) NULL,
	[Subject] [nvarchar](50) NULL,
	[Description] [nvarchar](200) NULL,
	[STATUS] [nchar](2) NULL,
	[ReceiptDate] [smalldatetime] NULL,
	[ReceiptEMPID] [nvarchar](10) NULL,
	[DefaultRepairDate] [smalldatetime] NULL,
	[RealRepairDate] [smalldatetime] NULL,
	[JobType] [nchar](1) NULL,
	[RepairEMPID] [nvarchar](10) NULL,
	[RepairVendor] [nvarchar](20) NULL,
	[RepairResult] [nchar](1) NULL,
	[RepairDescription] [nvarchar](200) NULL,
 CONSTRAINT [PK_BU_REPAIR] PRIMARY KEY CLUSTERED 
(
	[AppID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_REPAIR_ATTEND_EMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_REPAIR_ATTEND_EMP](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [nchar](10) NULL,
	[EMP_NO] [nvarchar](10) NULL,
 CONSTRAINT [PK_BU_REPAIR_ATTEND_EMP] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_VOTE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_VOTE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Subject] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[WhoCanSee] [nvarchar](250) NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[CreateDate] [smalldatetime] NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[DepartmentID] [nvarchar](50) NULL,
	[GUID] [nchar](32) NULL,
	[SelectMode] [nchar](1) NULL,
	[Item01] [nvarchar](250) NULL,
	[PhotoUrlItem01] [nvarchar](250) NULL,
	[Item02] [nvarchar](250) NULL,
	[PhotoUrlItem02] [nvarchar](250) NULL,
	[Item03] [nvarchar](250) NULL,
	[PhotoUrlItem03] [nvarchar](250) NULL,
	[Item04] [nvarchar](250) NULL,
	[PhotoUrlItem04] [nvarchar](250) NULL,
	[Item05] [nvarchar](250) NULL,
	[PhotoUrlItem05] [nvarchar](250) NULL,
	[Item06] [nvarchar](250) NULL,
	[PhotoUrlItem06] [nvarchar](250) NULL,
	[Item07] [nvarchar](250) NULL,
	[PhotoUrlItem07] [nvarchar](250) NULL,
	[Item08] [nvarchar](250) NULL,
	[PhotoUrlItem08] [nvarchar](250) NULL,
	[Item09] [nvarchar](250) NULL,
	[PhotoUrlItem09] [nvarchar](250) NULL,
	[Item10] [nvarchar](250) NULL,
	[PhotoUrlItem10] [nvarchar](250) NULL,
	[Item11] [nvarchar](250) NULL,
	[PhotoUrlItem11] [nvarchar](250) NULL,
	[Item12] [nvarchar](250) NULL,
	[PhotoUrlItem12] [nvarchar](250) NULL,
	[Item13] [nvarchar](250) NULL,
	[PhotoUrlItem13] [nvarchar](250) NULL,
	[Item14] [nvarchar](250) NULL,
	[PhotoUrlItem14] [nvarchar](250) NULL,
	[Item15] [nvarchar](250) NULL,
	[PhotoUrlItem15] [nvarchar](250) NULL,
	[Item16] [nvarchar](250) NULL,
	[PhotoUrlItem16] [nvarchar](250) NULL,
	[Item17] [nvarchar](250) NULL,
	[PhotoUrlItem17] [nvarchar](250) NULL,
	[Item18] [nvarchar](250) NULL,
	[PhotoUrlItem18] [nvarchar](250) NULL,
	[Item19] [nvarchar](250) NULL,
	[PhotoUrlItem19] [nvarchar](250) NULL,
	[Item20] [nvarchar](250) NULL,
	[PhotoUrlItem20] [nvarchar](250) NULL,
	[SelectRemark1] [nvarchar](50) NULL,
	[SelectRemark2] [nvarchar](50) NULL,
 CONSTRAINT [PK_BU_VOTE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_VOTE_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[BU_VOTE_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_BU_VOTE_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[BU_VOTE_DETAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_VOTE_DETAIL](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[ReplyDate] [smalldatetime] NULL,
	[Item01] [nchar](1) NULL,
	[Item02] [nchar](1) NULL,
	[Item03] [nchar](1) NULL,
	[Item04] [nchar](1) NULL,
	[Item05] [nchar](1) NULL,
	[Item06] [nchar](1) NULL,
	[Item07] [nchar](1) NULL,
	[Item08] [nchar](1) NULL,
	[Item09] [nchar](1) NULL,
	[Item10] [nchar](1) NULL,
	[Item11] [nchar](1) NULL,
	[Item12] [nchar](1) NULL,
	[Item13] [nchar](1) NULL,
	[Item14] [nchar](1) NULL,
	[Item15] [nchar](1) NULL,
	[Item16] [nchar](1) NULL,
	[Item17] [nchar](1) NULL,
	[Item18] [nchar](1) NULL,
	[Item19] [nchar](1) NULL,
	[Item20] [nchar](1) NULL,
	[ReplyContent] [nvarchar](1000) NULL,
	[SuperReply] [nvarchar](1000) NULL,
	[SuperEMPID] [nvarchar](10) NULL,
 CONSTRAINT [PK_BU_VOTE_DETAIL] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[BU_WASHCAR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BU_WASHCAR](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[BOOKINGDATE] [smalldatetime] NULL,
	[WASHDATE] [smalldatetime] NULL,
	[STATUS] [nchar](3) NULL,
	[EMPLYID] [nvarchar](10) NULL,
	[DEPID] [nvarchar](10) NULL,
	[CARID] [nvarchar](50) NULL,
	[CARTYPE] [nchar](3) NULL,
	[CARMOTO] [nchar](2) NULL,
	[CHARGE] [int] NULL,
	[REMK] [nvarchar](100) NULL,
 CONSTRAINT [PK_BU_WASHCAR] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ERP_CONNECT_COUNT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ERP_CONNECT_COUNT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CREATE_DATE] [datetime] NOT NULL,
	[ACCOUNT_CNT] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_FilesCW00506]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FR_FilesCW00506](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[File_ID] [nvarchar](8) NULL,
	[CName] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Sex] [nvarchar](50) NULL,
	[Birthday] [smalldatetime] NULL,
	[SocialID] [nvarchar](50) NULL,
	[Depm] [nvarchar](50) NULL,
	[Post] [nvarchar](50) NULL,
	[PostStartDate] [smalldatetime] NULL,
	[PostStopDate] [smalldatetime] NULL,
	[PostStatus] [nvarchar](50) NULL,
	[PostYear] [nvarchar](50) NULL,
	[PostMonth] [nvarchar](50) NULL,
	[Company] [nvarchar](50) NULL,
	[Boss] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[CreateDate] [smalldatetime] NULL,
 CONSTRAINT [PK_FR_FilesCW00506] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_FilesCW00506_back]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FR_FilesCW00506_back](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[File_ID] [nvarchar](8) NULL,
	[CName] [nvarchar](50) NULL,
	[Location] [nvarchar](50) NULL,
	[Sex] [nvarchar](50) NULL,
	[Birthday] [smalldatetime] NULL,
	[SocialID] [nvarchar](50) NULL,
	[Depm] [nvarchar](50) NULL,
	[Post] [nvarchar](50) NULL,
	[PostStartDate] [smalldatetime] NULL,
	[PostStopDate] [smalldatetime] NULL,
	[PostStatus] [nvarchar](50) NULL,
	[PostYear] [nvarchar](50) NULL,
	[PostMonth] [nvarchar](50) NULL,
	[Company] [nvarchar](50) NULL,
	[Boss] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[Phone] [nvarchar](50) NULL,
	[CreateDate] [smalldatetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_OFFIDOC_ISSUE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FR_OFFIDOC_ISSUE](
	[ISSUEID] [nvarchar](20) NOT NULL,
	[COMPANY] [nchar](1) NULL,
	[ISSUEDATE] [smalldatetime] NULL,
	[OFFICIAL_NM] [nvarchar](50) NULL,
	[SUBJECT] [nvarchar](250) NULL,
	[DESCR] [nvarchar](max) NULL,
	[AttachFIle] [nchar](1) NULL,
	[EMPID] [nvarchar](10) NULL,
	[DEPID] [nvarchar](10) NULL,
	[STATUS] [nchar](2) NULL,
	[DOCTYPE] [nchar](1) NULL,
	[CONTACT] [nvarchar](50) NULL,
	[PHONEAREACODE] [nvarchar](5) NULL,
	[PHONE] [nvarchar](20) NULL,
	[PHONEEXTENSION] [nvarchar](20) NULL,
	[FAX] [nvarchar](20) NULL,
	[Original] [nvarchar](50) NULL,
	[Duplicate] [nvarchar](100) NULL,
	[GUID] [nchar](32) NULL,
 CONSTRAINT [PK_FR_OFFIDOC_ISSUE] PRIMARY KEY CLUSTERED 
(
	[ISSUEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_OFFIDOC_ISSUE_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FR_OFFIDOC_ISSUE_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentISSUEID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_FR_OFFIDOC_ISSUE_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FR_OFFIDOC_RECE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FR_OFFIDOC_RECE](
	[RECEIVEID] [nchar](10) NOT NULL,
	[RECEDATE] [smalldatetime] NULL,
	[OFFICIAL_NM] [nvarchar](50) NULL,
	[OFFICIAL_DOCID] [nvarchar](30) NULL,
	[OFFICIAL_DOCTYPE] [nchar](20) NULL,
	[DESCR] [nvarchar](1000) NULL,
	[AttachFIle] [nchar](1) NULL,
	[EMPID] [nvarchar](10) NULL,
	[COMID] [nvarchar](10) NULL,
	[DEPID] [nvarchar](10) NULL,
	[STATUS] [nchar](2) NULL,
	[GUID] [nchar](32) NULL,
 CONSTRAINT [PK_FR_OFFIDOC_RECE] PRIMARY KEY CLUSTERED 
(
	[RECEIVEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_OFFIDOC_RECE_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FR_OFFIDOC_RECE_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentRECEIVEID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_FR_OFFIDOC_RECE_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HR_DEP_ADJ]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_DEP_ADJ](
	[DEPID] [nvarchar](50) NULL,
	[EMPLYID] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_DEP_ADJ_NM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_DEP_ADJ_NM](
	[DEP_NO] [nvarchar](6) NOT NULL,
	[EMPID] [nvarchar](7) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_DEREASON]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_DEREASON](
	[DEREASON] [nvarchar](200) NOT NULL,
	[DEREASON_VI] [nvarchar](200) NULL,
 CONSTRAINT [PK_HR_DEREASON] PRIMARY KEY CLUSTERED 
(
	[DEREASON] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_EMP_ATTENDANCE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_EMP_ATTENDANCE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[EMP_NO] [nvarchar](10) NULL,
	[Status] [int] NULL,
	[StartDate] [smalldatetime] NULL,
	[EndDate] [smalldatetime] NULL,
	[Remark] [nvarchar](50) NULL,
	[Closed] [nchar](1) NULL,
	[Proxy] [nchar](1) NULL,
 CONSTRAINT [PK_HR_EMP_ATTENDANCE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_EMP_ATTENDANCE_STATUS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_EMP_ATTENDANCE_STATUS](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[StatusNM] [nvarchar](10) NULL,
 CONSTRAINT [PK_HR_EMP_ATTENDANCE_STATUS] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_EMPLOYEE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_EMPLOYEE](
	[EMP_NO] [nvarchar](50) NOT NULL,
	[CName] [nvarchar](50) NULL,
	[PhotoUrl] [nvarchar](100) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EMP_NO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[HR_HolidaySet]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HR_HolidaySet](
	[HDATE] [smalldatetime] NOT NULL,
	[HOLIDAY] [nchar](1) NULL,
	[REMK] [nchar](200) NULL,
 CONSTRAINT [PK_HR_HolidaySet] PRIMARY KEY CLUSTERED 
(
	[HDATE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[IP_Address]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[IP_Address](
	[sn] [int] IDENTITY(1,1) NOT NULL,
	[ip_addr] [varchar](50) NULL,
	[mac_addr] [varchar](50) NULL,
	[dept] [nvarchar](50) NULL,
	[user] [nvarchar](50) NULL,
	[device] [varchar](50) NULL,
	[os] [varchar](50) NULL,
	[group] [varchar](50) NULL,
	[antivirus] [nvarchar](50) NULL,
	[remark] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[sn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [U_dbo_IP_Address_1] UNIQUE NONCLUSTERED 
(
	[ip_addr] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Module_ATTACH]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Module_ATTACH](
	[GUID] [uniqueidentifier] NOT NULL,
	[ModuleNM] [varchar](10) NULL,
	[FunctionNM] [varchar](20) NULL,
	[FunctionGUID] [varchar](50) NULL,
	[FileName] [nvarchar](50) NULL,
	[UploadPath] [varchar](100) NULL,
	[CreateDatetime] [datetime] NULL,
 CONSTRAINT [PK_Module_ATTACH] PRIMARY KEY CLUSTERED 
(
	[GUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PB_Record]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PB_Record](
	[PBNO] [char](12) NOT NULL,
	[PBNOSerial] [tinyint] NULL,
	[ApplyDate] [date] NULL,
	[EmpID] [varchar](10) NULL,
	[DeptID] [varchar](3) NULL,
	[SysNo] [varchar](10) NULL,
	[OtherSys] [varchar](10) NULL,
	[Module] [varchar](10) NULL,
	[ProgramNo] [varchar](20) NULL,
	[ProgramNM] [varchar](30) NULL,
	[Priority] [varchar](10) NULL,
	[PBType] [varchar](20) NULL,
	[NeedDate] [date] NULL,
	[PBSubject] [nvarchar](50) NULL,
	[PBDesc] [nvarchar](100) NULL,
	[Memo] [nvarchar](100) NULL,
	[IT_HandleEmp] [varchar](10) NULL,
	[IT_Priority] [varchar](10) NULL,
	[IT_EstCompleteDate] [date] NULL,
	[IT_EstHandle] [nvarchar](100) NULL,
	[IT_CompleteDesc] [nvarchar](100) NULL,
	[IT_Memo] [nvarchar](100) NULL,
	[IT_CompleteDate] [date] NULL,
	[FunctionGUID] [varchar](50) NULL,
	[Status] [varchar](2) NULL,
	[CreateDatetime] [datetime] NULL,
	[UpdDatetime] [datetime] NULL,
 CONSTRAINT [PK_PB_Record] PRIMARY KEY CLUSTERED 
(
	[PBNO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PB_RecordFeedback]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PB_RecordFeedback](
	[SID] [int] IDENTITY(1,1) NOT NULL,
	[PBNO] [char](12) NOT NULL,
	[FeedText] [nvarchar](300) NULL,
	[IsShow] [char](1) NULL,
	[FeedEmp] [varchar](10) NULL,
	[CreateEmp] [varchar](10) NULL,
	[CreateDatetime] [datetime] NULL,
	[UpdEmp] [varchar](10) NULL,
	[UpdDatetime] [datetime] NULL,
 CONSTRAINT [PK_PB_RecordFeedback] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PM_LogWorkHours]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_LogWorkHours](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ProjectID] [nvarchar](7) NULL,
	[DEP_ID] [nvarchar](50) NULL,
	[EMPLY_ID] [nvarchar](50) NULL,
	[CreateTime] [smalldatetime] NULL,
	[HOURS] [numeric](18, 1) NULL,
	[Description] [nvarchar](250) NULL,
 CONSTRAINT [PK_PM_LogWorkHours] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PM_PROJECT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PM_PROJECT](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[Project_NM] [nvarchar](50) NULL,
	[Project_Description] [nvarchar](max) NULL,
	[CreateDate] [smalldatetime] NULL,
	[CloseDate] [smalldatetime] NULL,
	[Status] [nchar](1) NULL,
	[Cost] [numeric](18, 0) NULL,
	[Owner] [nvarchar](50) NULL,
	[Excute_Description] [nvarchar](max) NULL,
	[GUID] [nchar](32) NULL,
 CONSTRAINT [PK_PM_Project] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_GUARDNO]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_GUARDNO](
	[USR_NO] [nvarchar](10) NOT NULL,
	[USR_NM] [nvarchar](12) NOT NULL,
	[USR_PW] [nvarchar](30) NULL,
	[DEPM_NO] [nvarchar](6) NULL,
	[DEPM_NM] [nvarchar](20) NULL,
	[E_MAIL] [nvarchar](20) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_PUBLIC_OBJECT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_PUBLIC_OBJECT](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObjectType] [nvarchar](20) NULL,
	[ObjectNM] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Open_] [nchar](2) NULL,
	[PhotoUrl] [nvarchar](250) NULL,
	[EnableDate] [smalldatetime] NULL,
	[Mileage] [int] NULL,
	[MaintenanceMileage] [int] NULL,
	[MaintenanceDate] [smalldatetime] NULL,
	[RemindDate] [smalldatetime] NULL,
	[DontMaintenance] [nchar](1) NULL,
	[Location] [nvarchar](50) NULL,
 CONSTRAINT [PK_PO_PUBLIC_OBJECT] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_PUBLIC_OBJECT_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PO_PUBLIC_OBJECT_ATTACH_FILE](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [char](32) NULL,
	[Name] [nvarchar](100) NULL,
	[UploadPath] [nvarchar](500) NULL,
 CONSTRAINT [PK_PO_PUBLIC_OBJECT_ATTACH_FILE] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PO_PUBLIC_OBJECT_ATTEND_EMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_PUBLIC_OBJECT_ATTEND_EMP](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ParentSID] [bigint] NULL,
	[EMP_NO] [nvarchar](10) NULL,
 CONSTRAINT [PK_PO_PUBLIC_OBJECT_ATTEND_EMP] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_PUBLIC_OBJECT_BOOKING]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_PUBLIC_OBJECT_BOOKING](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[ObjectType] [nvarchar](20) NULL,
	[UseReason] [nvarchar](50) NULL,
	[Subject] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[EmployeeID] [nvarchar](10) NULL,
	[DepartmentID] [nvarchar](10) NULL,
	[ObjectSID] [bigint] NULL,
	[BookingStartTime] [smalldatetime] NULL,
	[BookingEndTime] [smalldatetime] NULL,
	[CreateTime] [smalldatetime] NULL,
	[ProjectSID] [bigint] NULL,
	[Mileage] [int] NULL,
	[MileageLast] [int] NULL,
	[Status] [nchar](2) NULL,
	[LeaveTime] [nvarchar](20) NULL,
	[BackTime] [nvarchar](20) NULL,
	[GuardEMPID] [nvarchar](10) NULL,
 CONSTRAINT [PK_PO_PUBLIC_OBJECT_BOOKING] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_PUBLIC_OBJECT_BOOKING_Lock_EMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_PUBLIC_OBJECT_BOOKING_Lock_EMP](
	[EmployeeID] [nvarchar](10) NOT NULL,
	[Status] [nvarchar](10) NULL,
 CONSTRAINT [PK_PO_PUBLIC_OBJECT_BOOKING_Lock_EMP] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PO_SALES_VISITORS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PO_SALES_VISITORS](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[VisitCompany] [nvarchar](50) NULL,
	[Visitors] [nvarchar](50) NULL,
	[VisitorsNumber] [int] NULL,
	[VisitType] [nvarchar](50) NULL,
	[VisitContent] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[MeetingRoomBookingSID] [bigint] NULL,
	[MeetingRoomBookingObjectSID] [bigint] NULL,
	[MeetingBookingStartTime] [nvarchar](20) NULL,
	[MeetingBookingEndTime] [nvarchar](20) NULL,
	[Participants] [nvarchar](50) NULL,
	[Drink] [nvarchar](50) NULL,
	[PrepareItem] [nvarchar](50) NULL,
	[SupportEMP] [nvarchar](50) NULL,
	[SupportModel] [nvarchar](50) NULL,
	[Hotel] [nvarchar](50) NULL,
	[HotelDescription] [nvarchar](50) NULL,
	[ACarBookingSID] [bigint] NULL,
	[ACarBookingObjectSID] [bigint] NULL,
	[ACarBookingStartTime] [nvarchar](20) NULL,
	[ACarBookingEndTime] [nvarchar](20) NULL,
	[BCarBookingSID] [bigint] NULL,
	[BCarBookingObjectSID] [bigint] NULL,
	[BCarBookingStartTime] [nvarchar](20) NULL,
	[BCarBookingEndTime] [nvarchar](20) NULL,
	[MarqueeContent] [nvarchar](50) NULL,
	[SalesEMP_ID] [nvarchar](50) NULL,
	[SalesDirectorEMP_ID] [nvarchar](50) NULL,
	[SupportDirectorEMP_ID] [nvarchar](50) NULL,
	[Status] [nchar](2) NULL,
	[EmployeeID] [nvarchar](50) NULL,
	[CreateDate] [smalldatetime] NULL,
 CONSTRAINT [PK_PO_SALES_VISITORS] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_ALBUMS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PU_ALBUMS](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[parentId] [bigint] NULL,
	[childId] [bigint] NULL,
	[FileName] [nvarchar](50) NULL,
	[Size] [int] NULL,
	[Prod_no] [varchar](50) NULL,
	[Pdate] [datetime] NULL,
	[Descript] [nvarchar](50) NULL,
	[ImgPath] [nvarchar](500) NULL,
	[KindType1] [varchar](50) NULL,
	[KindType2] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[CreateEmp] [varchar](50) NULL,
 CONSTRAINT [PK__PU_ALBUM__3214EC075C57A83E] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PU_CONNECT_COUNT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_CONNECT_COUNT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY] [nvarchar](100) NULL,
	[SYS_NAME] [nvarchar](50) NULL,
	[CREATE_DATE] [datetime] NOT NULL,
	[ON_LINE_CNT] [int] NULL,
	[ACCOUNT_CNT] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_ERPSESSION]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PU_ERPSESSION](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[session_id] [int] NULL,
	[dbid] [smallint] NULL,
	[host_name] [nvarchar](128) NULL,
	[program_name] [nvarchar](4000) NULL,
	[emp_nm] [nvarchar](250) NULL,
	[client_net_address] [varchar](48) NULL,
	[login_name] [nvarchar](128) NULL,
	[db_name] [nvarchar](128) NULL,
	[CREATE_DATE] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PU_LOCATION]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_LOCATION](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[LocationName] [nvarchar](50) NULL,
 CONSTRAINT [PK_PU_LOCATION] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_PDMSESSION]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PU_PDMSESSION](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CONNECT_PC] [varchar](50) NULL,
	[CONNECT_CLASS] [varchar](20) NULL,
	[CONNECT_USER] [varchar](20) NULL,
	[USERNAME] [nvarchar](30) NULL,
	[CONNECT_IP] [varchar](20) NULL,
	[CONNECT_CLIENTNAME] [varchar](50) NULL,
	[CONNECT_SESSIONNAME] [varchar](20) NULL,
	[CONNECT_APPNAME] [varchar](20) NULL,
	[CREATE_DATE] [datetime] NULL,
 CONSTRAINT [PK__PU_PDMSE__3214EC0701892CED] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[PU_PERMISSION]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_PERMISSION](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Program_ID] [nvarchar](50) NULL,
	[Field_ID] [nvarchar](50) NULL,
	[EMP_NO] [nvarchar](50) NULL,
	[DEP_NO] [nvarchar](50) NULL,
	[Role_ID] [nvarchar](50) NULL,
	[Read_] [nchar](1) NULL,
	[Read_limit] [nchar](1) NULL,
	[Create_] [nchar](1) NULL,
	[Update_] [nchar](1) NULL,
	[Delete_] [nchar](1) NULL,
	[Mail_] [nchar](1) NULL,
	[Print_] [nchar](1) NULL,
	[Reply_] [nchar](1) NULL,
	[Send2Sign] [nchar](1) NULL,
	[Sign_] [nchar](1) NULL,
	[Upload_] [nchar](1) NULL,
	[Download_] [nchar](1) NULL,
	[Super_] [nchar](1) NULL,
 CONSTRAINT [PK_PU_PERMISSION] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_PERMISSION_PRGMROLE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_PERMISSION_PRGMROLE](
	[PRGMSID] [bigint] IDENTITY(1,1) NOT NULL,
	[PRGMID] [int] NULL,
	[ROLEID] [int] NULL,
 CONSTRAINT [PK_PU_PERMISSION_PRGMROLE] PRIMARY KEY CLUSTERED 
(
	[PRGMSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_PERMISSION_PROGRAM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_PERMISSION_PROGRAM](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Program_ID] [nvarchar](50) NULL,
	[Program_NM] [nvarchar](50) NULL,
	[Field_ID] [nvarchar](50) NULL,
	[Field_NM] [nvarchar](50) NULL,
 CONSTRAINT [PK_PU_PERMISSION_PROGRAM] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[PU_REFER]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PU_REFER](
	[SID] [bigint] IDENTITY(1,1) NOT NULL,
	[Program_ID] [nvarchar](50) NULL,
	[Field_ID] [nvarchar](50) NULL,
	[DAYS] [int] NULL,
	[AMOUNT] [decimal](18, 2) NULL,
	[QTY] [int] NULL,
	[CROSS_SIGN] [nvarchar](1) NULL,
	[DATE1] [smalldatetime] NULL,
	[DATE2] [smalldatetime] NULL,
 CONSTRAINT [PK_PU_REFER] PRIMARY KEY CLUSTERED 
(
	[SID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[V_ACCOUNT_CNT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_ACCOUNT_CNT](
	[ACCOUNT_CNT] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[V_ONLINE_CNT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[V_ONLINE_CNT](
	[ONLINE_CNT] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_FLOWD]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_FLOWD](
	[FLOWSID] [bigint] IDENTITY(1,1) NOT NULL,
	[FLOWID] [int] NULL,
	[SITEID] [int] NULL,
	[ROLEID] [int] NULL,
 CONSTRAINT [PK_WF_FLOWD_1] PRIMARY KEY CLUSTERED 
(
	[FLOWSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_FLOWM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_FLOWM](
	[FLOWID] [bigint] IDENTITY(1,1) NOT NULL,
	[FLOWNM] [nvarchar](50) NULL,
	[FLOWDSC] [nvarchar](100) NULL,
	[DEACT] [nchar](1) NULL,
	[DB] [nvarchar](100) NULL,
	[TABLENM] [nvarchar](100) NULL,
	[SID] [nvarchar](10) NULL,
 CONSTRAINT [PK_WF_FLOWM] PRIMARY KEY CLUSTERED 
(
	[FLOWID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_ROLED]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_ROLED](
	[ROLESID] [bigint] IDENTITY(1,1) NOT NULL,
	[ROLEID] [int] NULL,
	[DEP_NO] [nvarchar](10) NULL,
	[EMPLYID8] [nvarchar](10) NULL,
	[ACTIVE] [nchar](1) NULL,
	[ASSIGNDATE] [smalldatetime] NULL,
	[PROXY1] [nvarchar](10) NULL,
	[PROXY2] [nvarchar](10) NULL,
	[PROXY3] [nvarchar](10) NULL,
 CONSTRAINT [PK_WF_ROLED] PRIMARY KEY CLUSTERED 
(
	[ROLESID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_ROLEM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_ROLEM](
	[ROLEID] [bigint] IDENTITY(1,1) NOT NULL,
	[ROLENM] [nvarchar](20) NULL,
	[REMARK] [nvarchar](200) NULL,
	[PROXY] [nchar](1) NULL,
 CONSTRAINT [PK_WF_ROLE] PRIMARY KEY CLUSTERED 
(
	[ROLEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_SIGND]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_SIGND](
	[SIGNSID] [bigint] IDENTITY(1,1) NOT NULL,
	[SIGNID] [bigint] NULL,
	[SITEID] [int] NULL,
	[STATUS] [nchar](2) NULL,
	[EMPLYID] [nvarchar](10) NULL,
	[SIGNDATE] [smalldatetime] NULL,
	[REPLY] [nvarchar](200) NULL,
 CONSTRAINT [PK_WF_SIGND_1] PRIMARY KEY CLUSTERED 
(
	[SIGNSID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[WF_SIGNM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[WF_SIGNM](
	[SIGNID] [bigint] IDENTITY(1,1) NOT NULL,
	[FLOWID] [int] NULL,
	[SUBJECT] [nvarchar](80) NULL,
	[STATUS] [nvarchar](2) NULL,
	[EMP_ID] [nvarchar](10) NULL,
	[SENDDATE] [smalldatetime] NULL,
	[FINISHDATE] [smalldatetime] NULL,
	[DOCID] [nvarchar](12) NULL,
 CONSTRAINT [PK_WF_SIGNM] PRIMARY KEY CLUSTERED 
(
	[SIGNID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[VIEW_CCM_Main_Employee]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_CCM_Main_Employee]
as 
SELECT RTRIM(A.EMPLYID) AS EMP_NO,RTRIM(A.EMPLYNM) AS EMP_NM,RIGHT(CONVERT(CHAR(10),A.BRTHDT,120),5) AS BRD_DT,
CONVERT(CHAR(3),(YEAR(A.BRTHDT)-1911))+RIGHT(CONVERT(CHAR(10),A.BRTHDT,120),6) AS BRD_DT1,
CONVERT(CHAR(3),(YEAR(A.REGDT)-1911))+RIGHT(CONVERT(CHAR(10),A.REGDT,120),6) AS ARV_DT,
RTRIM(A.DEPID) AS DEPM_NO,RTRIM(A.SEX) AS SEX,RTRIM(A.PIDNO) AS ID_NO,CONVERT(CHAR(10),A.LLFDT,120) AS LEV_DT,RTRIM(A.JOBID) AS JOB_NO,RTRIM(A.HP) AS TEL_NO2,
RTRIM(E.JOBNM) AS JOB_NM,RTRIM(C.DEPNM) AS DEPM_NM,RTRIM(C.DEPNM) AS DEPM_NM1,'~/EIPContent/Content/PublicShare/Family/'+RTRIM(A.EMPLYNM)+'.JPG' AS PhotoUrl
FROM HRSDBR53..HR_EMPLYM A 
LEFT JOIN HRSDBR53..HR_DEP C ON A.DEPID=C.DEPID
LEFT JOIN HRSDBR53..HR_JOBID E ON A.JOBID=E.JOBID
WHERE A.C_STA='A' AND A.EMPLYID NOT IN ('A830902','B001203','B010505','B010701') 
UNION
SELECT 'BMW','守衛室','','','','G00','','','','','','','管理部','',''
GO
/****** Object:  View [dbo].[VIEW_WF_SIGNER]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_WF_SIGNER]
AS
SELECT DISTINCT A.FLOWID,A.SITEID,B.ROLENM,ISNULL(C.DEP_NO,'') AS DEP_NO,ISNULL(D.DEPM_NM,'') AS DEP_NM,
ISNULL(C.EMPLYID8,'') AS EMPLYID8,ISNULL(E.EMP_NM,'') AS EMP_NM,
ISNULL(D1.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS,'') AS SIGNEMPLYID1,ISNULL(E1.EMP_NM,'') AS SIGNEMPLYID1NM,
ISNULL(D2.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS,'') AS SIGNEMPLYID2,ISNULL(E2.EMP_NM,'') AS SIGNEMPLYID2NM,  
ISNULL(D3.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS,'') AS SIGNEMPLYID3,ISNULL(E3.EMP_NM,'') AS SIGNEMPLYID3NM,  
ISNULL(D4.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS,'') AS SIGNEMPLYID4,ISNULL(E4.EMP_NM,'') AS SIGNEMPLYID4NM,  
ISNULL(E7.EMP_NO,'') AS PROXY1ID,ISNULL(E7.EMP_NM,'') AS PROXY1NM,  
ISNULL(E8.EMP_NO,'') AS PROXY2ID,ISNULL(E8.EMP_NM,'') AS PROXY2NM,  
ISNULL(E9.EMP_NO,'') AS PROXY3ID,ISNULL(E9.EMP_NM,'') AS PROXY3NM  
FROM WF_FLOWD A 
LEFT JOIN WF_ROLEM B ON A.ROLEID=B.ROLEID 
LEFT JOIN WF_ROLED C ON B.ROLEID=C.ROLEID 
LEFT JOIN (SELECT DISTINCT DEPM_NO,DEPM_NM FROM [VIEW_CCM_Main_Employee] WHERE DEPM_NM IS NOT NULL) D ON C.DEP_NO=D.DEPM_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E ON C.EMPLYID8=E.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN HRSDBR53..HR_DEP D1 ON C.DEP_NO=D1.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E1 ON D1.EMPLYID=E1.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN HRSDBR53..HR_DEP D2 ON D1.DPRTID=D2.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E2 ON D2.EMPLYID=E2.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN HRSDBR53..HR_DEP D3 ON D2.DPRTID=D3.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E3 ON D3.EMPLYID=E3.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN HRSDBR53..HR_DEP D4 ON D3.DPRTID=D4.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E4 ON D4.EMPLYID=E4.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E7 ON C.PROXY1=E7.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E8 ON C.PROXY2=E8.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN (SELECT EMP_NO,EMP_NM FROM [VIEW_CCM_Main_Employee]) E9 ON C.PROXY3=E9.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[VIEW_Bulletin_WashCar]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_Bulletin_WashCar] 
AS 
SELECT A.*,B.EMP_NM,B.DEPM_NM FROM BU_WASHCAR A 
JOIN VIEW_CCM_Main_Employee B ON A.EMPLYID=B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS  
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING]
as 
SELECT A.*,B.EMP_NM,B.DEPM_NM,C.ObjectNM FROM PO_PUBLIC_OBJECT_BOOKING A
JOIN dbo.VIEW_CCM_Main_Employee AS B ON A.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
JOIN dbo.PO_PUBLIC_OBJECT AS C ON A.ObjectSID = C.SID
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_REPLY_Notice]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_VOTE_REPLY_Notice]
AS
SELECT A.SID,B.Subject,C.EMP_NM,C.DEPM_NM,A.ReplyDate,ReplyContent,SuperReply,D.EMP_NM AS SuperEMP_NM,D.DEPM_NM AS SuperDEPM_NM
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN VIEW_CCM_Main_Employee D ON A.SuperEMPID=D.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
GO
/****** Object:  View [dbo].[VIEW_BU_ORDERS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_BU_ORDERS]
as 
SELECT A.*,B.EMP_NM,C.DEPM_NM,D.Name FROM BU_ORDERS A
JOIN VIEW_CCM_Main_Employee B ON A.EmployeeID=B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
JOIN (SELECT DISTINCT DEPM_NO,DEPM_NM FROM [VIEW_CCM_Main_Employee] WHERE DEPM_NM IS NOT NULL) C ON A.DepartmentID=C.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
JOIN BU_ORDERS_SOTRE D ON A.StoreID=D.SID
GO
/****** Object:  View [dbo].[VIEW_BU_ORDERS_DETAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_BU_ORDERS_DETAIL]
as
SELECT A.*,B.EMP_NM,C.DEPM_NM,D.MealsName,E.AdjustItem FROM BU_ORDERS_DETAIL A 
JOIN VIEW_CCM_Main_Employee B ON A.EmpID=B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
JOIN (SELECT DISTINCT DEPM_NO,DEPM_NM FROM [VIEW_CCM_Main_Employee] WHERE DEPM_NM IS NOT NULL) C ON A.DepID=C.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
JOIN BU_ORDERS_MENU D ON A.OrderMenuSID=D.SID
LEFT JOIN BU_ORDERS_ADJUST E ON A.AdjustSID=E.SID
GO
/****** Object:  View [dbo].[VIEW_BU_ORDERS_DEPMAP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_ORDERS_DEPMAP]
AS
SELECT A.Name,REPLACE(CONVERT(varchar(10),A.EndDate,120),'-','/') AS EndDate,
CASE WHEN B.DepID IN ('K10','K30') THEN '全盈' ELSE '精湛' END AS COMPANY,SUM(B.Qty*B.UnitPrice+B.AdjustQty*B.AdjustAmount) AS AMOUNT FROM VIEW_BU_ORDERS A
JOIN VIEW_BU_ORDERS_DETAIL B ON A.SID=B.ParentSID
GROUP BY A.Name,A.EndDate,B.DepID
GO
/****** Object:  View [dbo].[VIEW_BU_BULLETIN]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_BU_BULLETIN]
as 
SELECT A.*,B.EMP_NM,C.DEPM_NM FROM BU_BULLETIN A
JOIN VIEW_CCM_Main_Employee B ON A.EmployeeID=B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
JOIN (SELECT DISTINCT DEPM_NO,DEPM_NM FROM [VIEW_CCM_Main_Employee] WHERE DEPM_NM IS NOT NULL) C ON A.DepartmentID=C.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 

GO
/****** Object:  View [dbo].[VIEW_CCM_Main_ALLUSERS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE view [dbo].[VIEW_CCM_Main_ALLUSERS]
as 
SELECT RTRIM(A.EMP_NO) AS USR_NO,
CASE ISNULL(B.USR_NO,'') WHEN '' THEN RTRIM(A.EMP_NM)+'(離職)' ELSE A.EMP_NM END AS USR_NM,B.USR_PW,RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(A.EMP_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].CCM_Main.dbo.EMPNO A 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.USRNO B ON A.EMP_NO=B.USR_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
WHERE A.EMP_NO NOT IN ('A830902','B001203','B010505','B010701')
/* 
UNION 
SELECT RTRIM(A.EMP_NO) AS USR_NO,CASE A.C_STA WHEN 'Y' THEN A.EMP_NM ELSE RTRIM(A.EMP_NM)+'(離職)' END AS USR_NM,B.USR_PW,'K'+RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(A.EMP_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].KSC_15.dbo.EMPLOYEE A 
LEFT JOIN [192.168.100.19].KSC_15.dbo.USRNO B ON A.EMP_NO=B.USR_NO
JOIN [192.168.100.19].KSC_15.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
UNION 
SELECT RTRIM(A.EMP_NO) AS USR_NO,CASE A.C_STA WHEN 'Y' THEN A.EMP_NM ELSE RTRIM(A.EMP_NM)+'(離職)' END AS USR_NM,B.USR_PW,'K'+RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(A.EMP_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].DAC_15.dbo.EMPLOYEE A 
LEFT JOIN [192.168.100.19].DAC_15.dbo.USRNO B ON A.EMP_NO=B.USR_NO
JOIN [192.168.100.19].DAC_15.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
*/

GO
/****** Object:  View [dbo].[VIEW_WF_NEEDSIGN1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_WF_NEEDSIGN1]
AS
SELECT     A.SIGNID, A.FLOWID, M.FLOWNM, A.DOCID, A.SUBJECT, A.EMP_ID, U.USR_NM AS EMP_NM, U.DEPM_NM, B.STATUS, A.STATUS AS SIGNMSTATUS, 
                      B.STATUS AS SIGNDSTATUS, A.SENDDATE, B.SIGNDATE, B.EMPLYID, U1.USR_NM AS EMP_NM1, U1.DEPM_NM AS DEPM_NM1, U1.DEPM_NO AS DEPM_NO1
FROM         WF_SIGNM A JOIN
                      WF_SIGND B ON A.SIGNID = B.SIGNID JOIN
                      WF_FLOWM M ON A.FLOWID = M.FLOWID JOIN
                      VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO JOIN
                      VIEW_CCM_Main_ALLUSERS U1 ON B.EMPLYID = U1.USR_NO
WHERE     B.SITEID = 1 AND A.SIGNID IN
                          (SELECT     A.SIGNID
                            FROM          WF_SIGNM A JOIN
                                                   WF_SIGND B ON A.SIGNID = B.SIGNID
                            WHERE      B.SITEID = 1)
UNION
SELECT     A.SIGNID, A.FLOWID, M.FLOWNM, A.DOCID, A.SUBJECT, A.EMP_ID, U.USR_NM AS EMP_NM, U.DEPM_NM, B.STATUS, A.STATUS AS SIGNMSTATUS, 
                      B.STATUS AS SIGNDSTATUS, A.SENDDATE, B.SIGNDATE, B.EMPLYID, U1.USR_NM AS EMP_NM1, U1.DEPM_NM AS DEPM_NM1, U1.DEPM_NO AS DEPM_NO1
FROM         WF_SIGNM A JOIN
                      WF_SIGND B ON A.SIGNID = B.SIGNID JOIN
                      WF_FLOWM M ON A.FLOWID = M.FLOWID JOIN
                      VIEW_CCM_Main_ALLUSERS U ON A.EMP_ID = U.USR_NO JOIN
                      VIEW_CCM_Main_ALLUSERS U1 ON B.EMPLYID = U1.USR_NO
WHERE     B.SITEID <> 1 AND A.SIGNID IN
                          (SELECT     A.SIGNID
                            FROM          WF_SIGNM A JOIN
                                                   WF_SIGND B ON A.SIGNID = B.SIGNID
                            WHERE      B.SITEID IN
                                                       (SELECT     SITEID - 1
                                                         FROM          WF_SIGND) AND B.STATUS = 'CF')

GO
/****** Object:  View [dbo].[VIEW_CCM_Main_ALLUSERS1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CCM_Main_ALLUSERS1]
AS
SELECT     M.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS AS USR_NO, M.EMPLYNM COLLATE Chinese_Taiwan_Stroke_CI_AS AS USR_NM, 
                      '' COLLATE Chinese_Taiwan_Stroke_CI_AS AS USR_PW, M.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS AS DEPM_NO, 
                      D.DEPNM COLLATE Chinese_Taiwan_Stroke_CI_AS AS DEPM_NM, RTRIM(M.EMPLYID) + '@CCM3S.COM' COLLATE Chinese_Taiwan_Stroke_CI_AS AS E_MAIL
FROM         HRSDBR53.dbo.HR_EMPLYM AS M LEFT OUTER JOIN
                      HRSDBR53.dbo.HR_DEP AS D ON M.DEPID = D.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE     (M.C_STA = 'A')

GO
/****** Object:  View [dbo].[View_USR_DETECTERR_OVRTM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_USR_DETECTERR_OVRTM]
AS
SELECT     EMPLYID, DOCID, SUBJECT, EMP_ID, STATUS, MRDT, FETB, FETE, Min_SIGNINTIME COLLATE Chinese_Taiwan_Stroke_CI_AS AS MinSignTime, 
                      Max_SIGNINTIME COLLATE Chinese_Taiwan_Stroke_CI_AS AS MaxSignTime
FROM         (SELECT DISTINCT 
                                              B.EMPLYID, A.DOCID, A.SUBJECT, A.EMP_ID, A.STATUS, M.MRDT, M.FETB, M.FETE, MAX(CONVERT(CHAR(10), N.YYMMDD, 120) 
                                              + ' ' + RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2), N.TKT_HH), 2) + ':' + RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2), N.TKT_NN), 2) 
                                              + ':' + RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2), N.TKT_SS), 2)) COLLATE Chinese_Taiwan_Stroke_CI_AS AS Max_SIGNINTIME, 
                                              MIN(CONVERT(CHAR(10), N.YYMMDD, 120) + ' ' + RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2), N.TKT_HH), 2) + ':' + RIGHT(REPLICATE('0', 2) 
                                              + CONVERT(NVARCHAR(2), N.TKT_NN), 2) + ':' + RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2), N.TKT_SS), 2)) COLLATE Chinese_Taiwan_Stroke_CI_AS
                                               AS Min_SIGNINTIME
                       FROM          dbo.WF_SIGNM AS A INNER JOIN
                                              dbo.WF_SIGND AS B ON A.SIGNID = B.SIGNID INNER JOIN
                                              dbo.WF_FLOWM AS M1 ON A.FLOWID = M1.FLOWID INNER JOIN
                                              dbo.VIEW_CCM_Main_ALLUSERS1 AS U ON A.EMP_ID = U.USR_NO INNER JOIN
                                              HRSDBR53.dbo.HR_OVRTM AS M ON M.OVRTNO COLLATE Chinese_Taiwan_Stroke_CI_AS = A.DOCID LEFT OUTER JOIN
                                              HRSDBR53.dbo.HR_TICKET AS N ON M.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS = N.EMPLYID AND CONVERT(CHAR(10), N.YYMMDD, 120) 
                                              = CONVERT(CHAR(10), M.FETE, 120) COLLATE Chinese_Taiwan_Stroke_CI_AS
                       GROUP BY B.EMPLYID, A.DOCID, A.SUBJECT, A.EMP_ID, A.STATUS, M.MRDT, M.FETB, M.FETE, N.YYMMDD
                       HAVING      (B.EMPLYID = 'A970202') AND (A.STATUS = 'SN') OR
                                              (B.EMPLYID = 'A970202') AND (A.STATUS = 'SN') AND (N.YYMMDD IS NULL)) AS X
WHERE     (CONVERT(CHAR(10), MRDT, 120) <> CONVERT(CHAR(10), GETDATE(), 120)) AND (STUFF(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, FETB, 120), '-', ''), ' ', ''), 
                      ':', ''), 13, 2, '00') < STUFF(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, Min_SIGNINTIME COLLATE Chinese_Taiwan_Stroke_CI_AS, 120), '-', ''), ' ', ''), ':', ''), 13, 
                      2, '00') COLLATE Chinese_Taiwan_Stroke_CI_AS) OR
                      (CONVERT(CHAR(10), MRDT, 120) <> CONVERT(CHAR(10), GETDATE(), 120)) AND (STUFF(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, FETE, 120), '-', ''), ' ', ''), 
                      ':', ''), 13, 2, '00') > STUFF(REPLACE(REPLACE(REPLACE(CONVERT(VARCHAR, Max_SIGNINTIME COLLATE Chinese_Taiwan_Stroke_CI_AS, 120), '-', ''), ' ', ''), ':', ''), 13, 
                      2, '00') COLLATE Chinese_Taiwan_Stroke_CI_AS) OR
                      (Min_SIGNINTIME COLLATE Chinese_Taiwan_Stroke_CI_AS IS NULL)

GO
/****** Object:  View [dbo].[VIEW_BU_LUNCH]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_LUNCH] 
AS 
SELECT A.*,B.EMP_NM,B.DEPM_NM FROM BU_LUNCH A 
JOIN VIEW_CCM_Main_Employee B ON A.EMPLYID=B.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[VIEW_HR_OVTM_EMPSUM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[VIEW_HR_OVTM_EMPSUM]
 AS
 SELECT YEAR(A.MRDT) AS MRDT_YEAR, replicate('0', (2-len(MONTH(A.MRDT)))) + CONVERT(nchar, MONTH(A.MRDT)) AS MRDT_MONTH,A.EMPLYID,
 SUM(A.REHRS1) AS REHRS1,C.EMP_NM,A.DEPID,C.DEPM_NM
 FROM HRSDBR53..HR_OVRTM A
 JOIN dbo.VIEW_CCM_Main_Employee AS C ON A.EMPLYID = C.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS 
 WHERE A.STATUS='CF'
 GROUP BY YEAR(A.MRDT),MONTH(A.MRDT),A.EMPLYID,C.EMP_NM,A.DEPID,C.DEPM_NM
GO
/****** Object:  View [dbo].[VIEW_HR_OVTM_EMPSUMBYOTTP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 CREATE VIEW [dbo].[VIEW_HR_OVTM_EMPSUMBYOTTP]
 AS
 SELECT YEAR(A.MRDT) AS MRDT_YEAR, RTRIM(replicate('0', (2-len(MONTH(A.MRDT)))) + CONVERT(nchar, MONTH(A.MRDT))) AS MRDT_MONTH,A.EMPLYID,
 SUM(A.REHRS1) AS REHRS1,C.EMP_NM,A.DEPID,C.DEPM_NM,CASE A.OTTP WHEN 'S' THEN '平日' ELSE '假日' END AS OTTP,
 CASE A.STATUS WHEN 'CF' THEN '核准' WHEN 'CL' THEN '退回' ELSE '簽核中' END AS STATUS
 FROM HRSDBR53..HR_OVRTM A
 JOIN dbo.VIEW_CCM_Main_Employee AS C ON A.EMPLYID = C.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS 
 WHERE A.STATUS IN ('CF','CL','SN')
 GROUP BY YEAR(A.MRDT),MONTH(A.MRDT),A.EMPLYID,C.EMP_NM,A.DEPID,C.DEPM_NM,A.OTTP,A.STATUS
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_DEPM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_CCM_Main_DEPM]
as 
SELECT DISTINCT RTRIM(A.DEPID) AS DEPM_NO,A.DEPNM AS DEPM_NM
FROM HRSDBR53..HR_DEP A
JOIN HRSDBR53..HR_EMPLYM B ON A.DEPID=B.DEPID
UNION
SELECT 'A00','全部'
UNION
SELECT 'A01','新進員工(近3個月)'
UNION
SELECT 'Z91','離職員工'
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_USERS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE view [dbo].[VIEW_CCM_Main_USERS]
as 
SELECT RTRIM(A.EMP_NO) AS USR_NO,
CASE ISNULL(B.USR_NO,'') WHEN '' THEN RTRIM(A.EMP_NM)+'(離職)' ELSE A.EMP_NM END AS USR_NM,B.USR_PW,RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(A.EMP_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].CCM_Main.dbo.EMPNO A 
JOIN [192.168.100.19].CCM_Main.dbo.USRNO B ON A.EMP_NO=B.USR_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
WHERE A.EMP_NO NOT IN ('A830902','B001203','B010505','B010701')
/* 
UNION 
SELECT RTRIM(B.USR_NO) AS USR_NO,B.USR_NM,B.USR_PW,'K'+RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(B.USR_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].KSC_15.dbo.EMPLOYEE A 
JOIN [192.168.100.19].KSC_15.dbo.USRNO B ON A.EMP_NO=B.USR_NO
JOIN [192.168.100.19].KSC_15.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
WHERE (A.C_STA='Y' OR A.C_STA='1' OR A.C_STA='2') 
UNION 
SELECT RTRIM(B.USR_NO) AS USR_NO,B.USR_NM,B.USR_PW,'K'+RTRIM(A.DEPM_NO) AS DEPM_NO,C.DEPM_NM,RTRIM(B.USR_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].DAC_15.dbo.EMPLOYEE A 
JOIN [192.168.100.19].DAC_15.dbo.USRNO B ON A.EMP_NO=B.USR_NO
JOIN [192.168.100.19].DAC_15.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
WHERE (A.C_STA='Y' OR A.C_STA='1' OR A.C_STA='2') 
*/


GO
/****** Object:  View [dbo].[VIEW_BU_REPAIR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_REPAIR]
AS
SELECT A.[AppID]
     ,A.[AppDEPID]
     ,A.[AppEMPID]
     ,A.[AppDate]
     ,A.[AppEMPExtension]
     ,CASE A.[Location] WHEN 'C' THEN '精湛總廠' ELSE '全盈一廠' END AS Location
     ,A.[RepairPlace]
     ,A.[Subject]
     ,A.[Description]
     ,CASE A.[STATUS] WHEN 'OP' THEN '未送簽' WHEN 'SN' THEN '簽核中' WHEN 'CF' THEN '已核准' WHEN 'CL' THEN '已退回' WHEN 'NL' THEN '已作廢' END AS STATUS
     ,A.[ReceiptDate]
     ,A.[ReceiptEMPID]
     ,A.[DefaultRepairDate]
     ,A.[RealRepairDate]
     ,A.[JobType]
     ,A.[RepairEMPID]
     ,A.[RepairVendor]
     ,A.[RepairDescription]
     ,CASE A.[RepairResult] WHEN '1' THEN '完成' WHEN '2' THEN '報廢' WHEN '3' THEN '其他' END AS RepairResult
     ,E.USR_NM AS AppEMP,D.DEPM_NM AS AppDEP,E1.USR_NM AS ReceiptEMP,E2.USR_NM AS RepairEMP FROM BU_REPAIR A
LEFT JOIN VIEW_CCM_Main_DEPM D ON A.AppDEPID=D.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN [VIEW_CCM_Main_USERS] E ON A.AppEMPID=E.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN [VIEW_CCM_Main_USERS] E1 ON A.ReceiptEMPID=E1.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN [VIEW_CCM_Main_USERS] E2 ON A.RepairEMPID=E2.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_VALID]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_VALID]
as 
SELECT A.*,B.EMP_NM,B.DEPM_NM,C.ObjectNM,
CASE WHEN BookingStartTime>= GETDATE() AND (Status IS NULL OR Status='') THEN 'V' ELSE '' END AS VALID FROM PO_PUBLIC_OBJECT_BOOKING A
JOIN dbo.VIEW_CCM_Main_Employee AS B ON A.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
JOIN dbo.PO_PUBLIC_OBJECT AS C ON A.ObjectSID = C.SID
WHERE A.BookingStartTime>= CONVERT(CHAR(10),GETDATE(),120)
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_STATUS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_STATUS]
as 
SELECT A.SID,CASE WHEN C.SID IS NULL THEN '0' ELSE C.SID END AS BOOKING_SID,A.ObjectNM,A.ObjectType,
C.Subject,B.EMP_NM,C.BookingStartTime,C.BookingEndTIme
FROM PO_PUBLIC_OBJECT A
LEFT JOIN PO_PUBLIC_OBJECT_BOOKING C ON A.SID=C.ObjectSID AND (C.Status IS NULL OR C.Status='') AND (C.BookingStartTime<= GETDATE() AND C.BookingEndTIme>= GETDATE()) 
LEFT JOIN dbo.VIEW_CCM_Main_Employee AS B ON C.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[V_BOOKING_CAR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_BOOKING_CAR]
AS
SELECT     A.SID AS ObjectSID, CASE WHEN C.SID IS NULL THEN '0' ELSE C.SID END AS BOOKING_SID, A.ObjectNM, A.ObjectType, 
           --B.EMP_NM,
           (CASE WHEN B.EMP_NM IS NULL  THEN '可借用' 
           ELSE B.EMP_NM END collate Chinese_Taiwan_Stroke_CI_AS) AS EMP_NM,C.Subject, 
           REPLACE(CONVERT(CHAR(19), C.BookingStartTime, 120),' ','T') AS BookingStartTime, 
           REPLACE(CONVERT(CHAR(19), C.BookingEndTime, 120),' ','T') AS BookingEndTIme, 
           C.Mileage, C.MileageLast
FROM       dbo.PO_PUBLIC_OBJECT AS A LEFT OUTER JOIN
           dbo.PO_PUBLIC_OBJECT_BOOKING AS C ON A.SID = C.ObjectSID 
           AND (C.Status IS NULL OR  C.Status = '' OR  C.Status = '鎖定') 
           AND C.BookingStartTime <= GETDATE() 
           LEFT OUTER JOIN dbo.VIEW_CCM_Main_Employee AS B ON C.EmployeeID = B.EMP_NO
           COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE     (A.ObjectType = '公務車輛') AND (A.ObjectNM <> '私人車輛') AND (A.Open_ = '啟用')
GO
/****** Object:  View [dbo].[V_BOOKING_MEETROOM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_BOOKING_MEETROOM]
AS
SELECT A.SID AS ObjectSID,CASE WHEN C.SID IS NULL THEN '0' ELSE C.SID END AS BOOKING_SID,A.ObjectNM,A.ObjectType,
 (CASE WHEN B.EMP_NM IS NULL  THEN '可借用' 
           ELSE B.EMP_NM END collate Chinese_Taiwan_Stroke_CI_AS) AS EMP_NM,C.Subject, 
           REPLACE(CONVERT(CHAR(19), C.BookingStartTime, 120),' ','T') AS BookingStartTime, 
           REPLACE(CONVERT(CHAR(19), C.BookingEndTime, 120),' ','T') AS BookingEndTIme, 
           C.Mileage, C.MileageLast
FROM PO_PUBLIC_OBJECT A
LEFT JOIN PO_PUBLIC_OBJECT_BOOKING C ON A.SID=C.ObjectSID AND (C.Status IS NULL OR C.Status='') AND (C.BookingStartTime<= GETDATE() AND C.BookingEndTIme>= GETDATE()) 
LEFT JOIN dbo.VIEW_CCM_Main_Employee AS B ON C.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE A.ObjectType='會議室' AND A.Open_='啟用'
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_CAR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_CAR]
AS
SELECT     A.SID AS ObjectSID, CASE WHEN C.SID IS NULL THEN '0' ELSE C.SID END AS BOOKING_SID, A.ObjectNM, A.ObjectType, CASE WHEN B.EMP_NM IS NULL 
                      THEN '可借用' ELSE B.EMP_NM END AS EMP_NM, C.Subject, CONVERT(CHAR(5), C.BookingStartTime, 108) AS BookingStartTime, CONVERT(CHAR(5), 
                      C.BookingEndTime, 108) AS BookingEndTIme, C.Mileage, C.MileageLast
FROM         dbo.PO_PUBLIC_OBJECT AS A LEFT OUTER JOIN
                      dbo.PO_PUBLIC_OBJECT_BOOKING AS C ON A.SID = C.ObjectSID AND (C.Status IS NULL OR
                      C.Status = '' OR
                      C.Status = '鎖定') AND C.BookingStartTime <= GETDATE() LEFT OUTER JOIN
                      dbo.VIEW_CCM_Main_Employee AS B ON C.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE     (A.ObjectType = '公務車輛') AND (A.ObjectNM <> '私人車輛') AND (A.Open_ = '啟用')

GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_MEETINGROOM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--VIEW_PO_PUBLIC_OBJECT_BOOKING_MEETINGROOM
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_MEETINGROOM]
as 
SELECT A.SID AS ObjectSID,CASE WHEN C.SID IS NULL THEN '0' ELSE C.SID END AS BOOKING_SID,A.ObjectNM,A.ObjectType,
CASE WHEN B.EMP_NM IS NULL THEN '可借用' ELSE B.EMP_NM END AS EMP_NM,C.Subject,
CONVERT(CHAR(5),C.BookingStartTime,108) AS BookingStartTime,
CONVERT(CHAR(5),C.BookingEndTIme,108) AS BookingEndTIme,C.Mileage
FROM PO_PUBLIC_OBJECT A
LEFT JOIN PO_PUBLIC_OBJECT_BOOKING C ON A.SID=C.ObjectSID AND (C.Status IS NULL OR C.Status='') AND (C.BookingStartTime<= GETDATE() AND C.BookingEndTIme>= GETDATE()) 
LEFT JOIN dbo.VIEW_CCM_Main_Employee AS B ON C.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE A.ObjectType='會議室' AND A.Open_='啟用'
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP]
as 
SELECT RTRIM(DEPM_NM)+'_'+RTRIM(USR_NM) AS EMP_NM,RTRIM(USR_NM) AS EMP_NM1,USR_NO AS EMP_NO,DEPM_NO 
FROM VIEW_CCM_Main_USERS
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP_TODAY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP_TODAY]
AS
SELECT     B.EMP_NM, C.Subject, D.ObjectNM, CONVERT(CHAR(5), C.BookingStartTime, 108) AS BookingStartTime, CONVERT(CHAR(5), C.BookingEndTime, 108) 
                      AS BookingEndTime, CONVERT(CHAR(5), C.BookingStartTime, 108) + '~' + CONVERT(CHAR(5), C.BookingEndTime, 108) 
                      + '/' + C.Subject + '/' + D.ObjectNM AS Subject1
FROM         dbo.PO_PUBLIC_OBJECT_BOOKING AS C INNER JOIN
                      dbo.PO_PUBLIC_OBJECT_ATTEND_EMP AS A ON C.SID = A.ParentSID INNER JOIN
                      dbo.VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP AS B ON B.EMP_NO = A.EMP_NO INNER JOIN
                      dbo.PO_PUBLIC_OBJECT AS D ON C.ObjectSID = D.SID
WHERE     (C.ObjectType = '公務車輛') AND (C.Status IS NULL OR
                      C.Status = '' OR
                      C.Status = '鎖定') AND (C.BookingStartTime <= GETDATE()) AND (C.BookingEndTime >= GETDATE())

GO
/****** Object:  View [dbo].[VIEW_HR_EMP_ATTENDANCE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_HR_EMP_ATTENDANCE]
as 
SELECT     C.EMP_NM1 AS EMP_NM, B.StatusNM, RIGHT(CONVERT(CHAR(10), A.StartDate, 111), 5) AS StartDate, RIGHT(CONVERT(CHAR(10), A.EndDate, 111), 5) AS EndDate,
B.StatusNM+RIGHT(CONVERT(CHAR(10), A.StartDate, 111), 5)+'至'+RIGHT(CONVERT(CHAR(10), A.EndDate, 111), 5) AS StartDate1, 
A.Remark,A.Closed
FROM         dbo.HR_EMP_ATTENDANCE AS A INNER JOIN
dbo.HR_EMP_ATTENDANCE_STATUS AS B ON A.Status = B.SID INNER JOIN
dbo.VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP AS C ON A.EMP_NO = C.EMP_NO
WHERE     (A.EndDate >= DATEADD(day, 0, CONVERT(CHAR(10), GETDATE(), 111))) AND A.Closed IS NULL
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_ATTEND_EMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_ATTEND_EMP]
AS
SELECT A.*,B.EMP_NM FROM PO_PUBLIC_OBJECT_ATTEND_EMP A
JOIN VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP B ON B.EMP_NO=A.EMP_NO
GO
/****** Object:  View [dbo].[VIEW_PO_SALES_VISITORS]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_SALES_VISITORS]
AS
SELECT A.*,
B.EMP_NM1 AS EMP_NM_Sales,B1.EMP_NM1 AS EMP_NM_SalesDirector,B2.EMP_NM1 AS EMP_NM_SupportDirector,B3.EMP_NM1 AS EMP_NM_Employee,
C.ObjectNM AS ObjectNM_Meeting,C1.ObjectNM AS ObjectNM_ACar,C2.ObjectNM AS ObjectNM_BCar FROM PO_SALES_VISITORS A
LEFT JOIN VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP B ON B.EMP_NO=A.SalesEMP_ID
LEFT JOIN VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP B1 ON B1.EMP_NO=A.SalesDirectorEMP_ID
LEFT JOIN VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP B2 ON B2.EMP_NO=A.SupportDirectorEMP_ID
LEFT JOIN VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP B3 ON B3.EMP_NO=A.EmployeeID
LEFT JOIN PO_PUBLIC_OBJECT C ON A.MeetingRoomBookingObjectSID=C.SID
LEFT JOIN PO_PUBLIC_OBJECT C1 ON A.ACarBookingObjectSID=C1.SID
LEFT JOIN PO_PUBLIC_OBJECT C2 ON A.BCarBookingObjectSID=C2.SID
GO
/****** Object:  View [dbo].[HR_TICKET]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HR_TICKET]
AS
SELECT     YYMMDD, EMPLYID, TKT_HH, TKT_NN, TKT_SS, BL_DT, C_UPDATE, C_FUNC, REMARK, SN
FROM         HRSDBR53.dbo.HR_TICKET 
GO
/****** Object:  View [dbo].[VIEW_HR_TICKET_NOTICE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_HR_TICKET_NOTICE]
AS
SELECT C.DEPM_NM,EMPLYID,C.EMP_NM,CONVERT(CHAR(10),A.YYMMDD, 120)+' '+RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2),A.TKT_HH), 2)+':'+RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2),A.TKT_NN), 2)+':'+RIGHT(REPLICATE('0', 2) + CONVERT(NVARCHAR(2),A.TKT_SS), 2) AS YYMMDD 
FROM HR_TICKET A
LEFT JOIN dbo.VIEW_CCM_Main_Employee AS C ON A.EMPLYID = C.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE CONVERT(CHAR(10),YYMMDD, 120)=CONVERT(CHAR(10),GetDate() , 120) AND EMPLYID IN (
	SELECT EMPLYID FROM HR_TICKET 
	WHERE CONVERT(CHAR(10),YYMMDD, 120)=CONVERT(CHAR(10),GetDate() , 120)
	GROUP BY CONVERT(CHAR(10),YYMMDD, 120),EMPLYID
	HAVING COUNT(EMPLYID)>1)
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_SATISFIED]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_VOTE_SATISFIED]
AS
SELECT A.SID,A.Subject,A.Description,A.StartDate,A.EndDate,B.EMP_NM,B.DEPM_NM
FROM BU_Vote A 
JOIN VIEW_CCM_Main_Employee B ON A.EmployeeID=B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS  
WHERE A.SelectMode='3'
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_SATISFIED_REPORT02_REPLYCONTENT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_VOTE_SATISFIED_REPORT02_REPLYCONTENT]
AS
SELECT A.ParentSID,C.EMP_NM,C.DEPM_NM,A.ReplyDate,A.REPLYCONTENT
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE B.SelectMode='3' AND A.REPLYCONTENT IS NOT NULL AND A.REPLYCONTENT<>''
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP]
AS
SELECT     CONVERT(CHAR(10), C.BookingStartTime, 120) AS StartDate, D.ObjectNM, B.EMP_NM, LEFT(RIGHT(CONVERT(char(19), C.BookingStartTime, 120), 8), 5) 
                      AS BookingStartTime, LEFT(RIGHT(CONVERT(char(19), C.BookingEndTime, 120), 8), 5) AS BookingEndTime, LEFT(RIGHT(RTRIM(C.LeaveTime), 8), 5) AS LeaveTime, 
                      LEFT(RIGHT(RTRIM(C.BackTime), 8), 5) AS BackTime, C.Subject, C.Description, ISNULL(C.MileageLast, 0) AS MileageLast, ISNULL(C.Mileage, 0) AS Mileage, 
                      CASE WHEN C.Mileage - C.MileageLast < 0 THEN 0 ELSE ISNULL(C.Mileage - C.MileageLast, 0) END AS Mileages, ISNULL(B1.USR_NM, '') AS GuardEMPNM
FROM         dbo.PO_PUBLIC_OBJECT_BOOKING AS C INNER JOIN
                      dbo.PO_PUBLIC_OBJECT_ATTEND_EMP AS A ON C.SID = A.ParentSID INNER JOIN
                      dbo.VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP AS B ON B.EMP_NO = A.EMP_NO LEFT OUTER JOIN
                      dbo.VIEW_CCM_Main_USERS AS B1 ON B1.USR_NO = C.GuardEMPID INNER JOIN
                      dbo.PO_PUBLIC_OBJECT AS D ON C.ObjectSID = D.SID
WHERE     (C.ObjectType = '公務車輛') AND (C.Status = '結束')

GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY]
AS
SELECT     StartDate, ObjectNM, BookingStartTime + '~' + BookingEndTime AS BookingStartEndTime, LeaveTime + '~' + BackTime AS LeaveBackTime, Subject, Description, 
                      MileageLast, Mileage, Mileages, GuardEMPNM, EMP_NM = STUFF
                          ((SELECT     '; ' + ic.EMP_NM + CHAR(13)
                              FROM         dbo.VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP AS ic
                              WHERE     ic.StartDate = c.StartDate AND ic.ObjectNM = c.ObjectNM AND ic.LeaveTime = c.LeaveTime AND ic.BackTime = c.BackTime AND 
                                                    ic.Subject = c.Subject AND ic.Description = c.Description AND ic.MileageLast = c.MileageLast AND ic.Mileage = c.Mileage AND 
                                                    ic.Mileages = c.Mileages AND ic.GuardEMPNM = c.GuardEMPNM FOR XML PATH(''), TYPE ).value('.', 'nvarchar(max)'), 1, 2, '')
FROM         dbo.VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP AS c
GROUP BY StartDate, ObjectNM, BookingStartTime, BookingEndTime, LeaveTime, BackTime, Subject, Description, MileageLast, Mileage, Mileages, GuardEMPNM

GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_MONTHLY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_MONTHLY]
AS
SELECT LEFT(StartDate,7) AS StartDate, ObjectNM, SUM(Mileages) AS Mileages
FROM VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP
WHERE ObjectNM<>'私人車輛' AND ObjectNM NOT LIKE '機車%'
GROUP BY LEFT(StartDate,7), ObjectNM
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_MONTHLY_MAX_Mileage]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_MONTHLY_MAX_Mileage]
AS
SELECT LEFT(StartDate,7) AS StartDate1, ObjectNM AS ObjectNM1, MAX(Mileage) AS Mileage1
FROM VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP
WHERE ObjectNM<>'私人車輛' AND ObjectNM NOT LIKE '機車%'
GROUP BY LEFT(StartDate,7), ObjectNM
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_REPLY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_VOTE_REPLY]
AS
SELECT A.SID,A.ParentSID,C.EMP_NO,C.EMP_NM,C.DEPM_NM,A.ReplyDate,ReplyContent,SuperReply,D.EMP_NM AS SuperEMP_NM,D.DEPM_NM AS SuperDEPM_NM,
CASE WHEN A.ITEM01='1' THEN
(CASE WHEN RTRIM(B.ITEM01)<>'' AND A.ITEM01='1' THEN LEFT(B.ITEM01,20)+ ',' END )
ELSE '' END
+
CASE WHEN A.ITEM02='1' THEN
  (CASE  WHEN RTRIM(B.ITEM02)<>'' AND A.ITEM02='1' THEN LEFT(B.ITEM02,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM03='1' THEN
  (CASE  WHEN RTRIM(B.ITEM03)<>'' AND A.ITEM03='1' THEN LEFT(B.ITEM03,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM04='1' THEN
  (CASE  WHEN RTRIM(B.ITEM04)<>'' AND A.ITEM04='1' THEN LEFT(B.ITEM04,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM05='1' THEN
  (CASE  WHEN RTRIM(B.ITEM05)<>'' AND A.ITEM05='1' THEN LEFT(B.ITEM05,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM06='1' THEN
  (CASE  WHEN RTRIM(B.ITEM06)<>'' AND A.ITEM06='1' THEN LEFT(B.ITEM06,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM07='1' THEN
  (CASE  WHEN RTRIM(B.ITEM07)<>'' AND A.ITEM07='1' THEN LEFT(B.ITEM07,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM08='1' THEN
  (CASE  WHEN RTRIM(B.ITEM08)<>'' AND A.ITEM08='1' THEN LEFT(B.ITEM08,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM09='1' THEN
  (CASE  WHEN RTRIM(B.ITEM09)<>'' AND A.ITEM09='1' THEN LEFT(B.ITEM09,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM10='1' THEN
  (CASE  WHEN RTRIM(B.ITEM10)<>'' AND A.ITEM10='1' THEN LEFT(B.ITEM10,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item11='1' THEN
(CASE WHEN RTRIM(B.Item11)<>'' AND A.Item11='1' THEN LEFT(B.Item11,20)+ ',' END )
ELSE '' END
+
CASE WHEN A.Item12='1' THEN
  (CASE  WHEN RTRIM(B.Item12)<>'' AND A.Item12='1' THEN LEFT(B.Item12,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item13='1' THEN
  (CASE  WHEN RTRIM(B.Item13)<>'' AND A.Item13='1' THEN LEFT(B.Item13,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item14='1' THEN
  (CASE  WHEN RTRIM(B.Item14)<>'' AND A.Item14='1' THEN LEFT(B.Item14,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item15='1' THEN
  (CASE  WHEN RTRIM(B.Item15)<>'' AND A.Item15='1' THEN LEFT(B.Item15,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item16='1' THEN
  (CASE  WHEN RTRIM(B.Item16)<>'' AND A.Item16='1' THEN LEFT(B.Item16,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item17='1' THEN
  (CASE  WHEN RTRIM(B.Item17)<>'' AND A.Item17='1' THEN LEFT(B.Item17,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item18='1' THEN
  (CASE  WHEN RTRIM(B.Item18)<>'' AND A.Item18='1' THEN LEFT(B.Item18,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.Item19='1' THEN
  (CASE  WHEN RTRIM(B.Item19)<>'' AND A.Item19='1' THEN LEFT(B.Item19,20)+ ',' END  ) 
ELSE '' END
+
CASE WHEN A.ITEM20='1' THEN
  (CASE  WHEN RTRIM(B.ITEM20)<>'' AND A.ITEM20='1' THEN LEFT(B.ITEM20,20)+ ',' END  ) 
ELSE '' END
AS Reply
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN VIEW_CCM_Main_Employee D ON A.SuperEMPID=D.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
GO
/****** Object:  View [dbo].[VIEW_PM_LogWorkHours]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PM_LogWorkHours] 
AS
SELECT A.ProjectID,A.ProjectID+B.PRJ_NM AS PRJ_NM,left(CONVERT(CHAR(10),A.CreateTime,120),7) as CreateTime,A.EMPLY_ID,V.USR_NM,A.DEP_ID,V.DEPM_NM,SUM(HOURS) AS HOURS 
FROM PM_LogWorkHours A
JOIN VIEW_CCM_Main_ALLUSERS V ON A.EMPLY_ID=V.USR_NO
JOIN [192.168.100.19].CCM_Main.dbo.PRJNO B ON A.ProjectID=B.PRJ_NO
GROUP BY A.ProjectID,A.EMPLY_ID,left(CONVERT(CHAR(10),A.CreateTime,120),7),B.PRJ_NM,V.USR_NM,A.DEP_ID,V.DEPM_NM
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_REPLY_REPORT02]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_BU_VOTE_REPLY_REPORT02]
as
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM01,20) AS ITEM,COUNT(A.ITEM01) AS ITEM_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM01<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM01
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM02,20) AS Item02,COUNT(A.ITEM02) AS ITEM02_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM02<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM02
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM03,20) AS Item03,COUNT(A.ITEM03) AS ITEM03_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM03<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM03
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM04,20) AS Item04,COUNT(A.ITEM04) AS ITEM04_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM04<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM04
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM05,20) AS Item05,COUNT(A.ITEM05) AS ITEM05_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM05<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM05
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM06,20) AS Item06,COUNT(A.ITEM06) AS ITEM06_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM06<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM06
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM07,20) AS Item07,COUNT(A.ITEM07) AS ITEM07_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM07<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM07
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM08,20) AS Item08,COUNT(A.ITEM08) AS ITEM08_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM08<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM08
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM09,20) AS Item09,COUNT(A.ITEM09) AS ITEM09_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM09<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM09
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM10,20) AS Item10,COUNT(A.ITEM10) AS ITEM10_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM10<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM10
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item11,20) AS Item11,COUNT(A.Item11) AS ITEM_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item11<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item11
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item12,20) AS Item12,COUNT(A.Item12) AS ITEM02_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item12<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item12
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item13,20) AS Item13,COUNT(A.Item13) AS ITEM03_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item13<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item13
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item14,20) AS Item14,COUNT(A.Item14) AS ITEM04_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item14<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item14
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item15,20) AS Item15,COUNT(A.Item15) AS ITEM05_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item15<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item15
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item16,20) AS Item16,COUNT(A.Item16) AS ITEM06_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item16<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item16
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item17,20) AS Item17,COUNT(A.Item17) AS ITEM07_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item17<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item17
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item18,20) AS Item18,COUNT(A.Item18) AS ITEM08_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item18<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item18
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.Item19,20) AS Item19,COUNT(A.Item19) AS ITEM09_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.Item19<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.Item19
UNION
SELECT A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,LEFT(B.ITEM20,20) AS Item20,COUNT(A.ITEM10) AS ITEM10_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
JOIN VIEW_CCM_Main_Employee C ON A.EmployeeID=C.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
WHERE A.ITEM20<>'0'
GROUP BY A.ParentSID,A.ReplyContent,C.EMP_NM,C.DEPM_NM,B.ITEM20

GO
/****** Object:  View [dbo].[VIEW_BU_VOTE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_VOTE]
AS
SELECT     A.SID, A.Subject, A.Description, A.StartDate, A.EndDate, B.EMP_NM, B.DEPM_NM, CASE A.SelectMode WHEN '1' THEN '單選' ELSE '複選' END AS SelectMode, 
  CASE WHEN A.Item01 <> '' THEN (CASE WHEN RTRIM(A.Item01) <> '' THEN ' 1.' + A.Item01 END) ELSE '' END + CASE WHEN A.Item02 <> '' THEN (CASE WHEN RTRIM(A.Item02) 
  <> '' THEN ' 2.' + A.Item02 END) ELSE '' END + CASE WHEN A.Item03 <> '' THEN (CASE WHEN RTRIM(A.Item03) <> '' THEN ' 3.' + A.Item03 END) 
  ELSE '' END + CASE WHEN A.Item04 <> '' THEN (CASE WHEN RTRIM(A.Item04) <> '' THEN ' 4.' + A.Item04 END) ELSE '' END + CASE WHEN A.Item05 <> '' THEN (CASE WHEN RTRIM(A.Item05) 
  <> '' THEN ' 5.' + A.Item05 END) ELSE '' END + CASE WHEN A.Item06 <> '' THEN (CASE WHEN RTRIM(A.Item06) <> '' THEN ' 6.' + A.Item06 END) 
  ELSE '' END + CASE WHEN A.Item07 <> '' THEN (CASE WHEN RTRIM(A.Item07) <> '' THEN ' 7.' + A.Item07 END) ELSE '' END + CASE WHEN A.Item08 <> '' THEN (CASE WHEN RTRIM(A.Item08) 
  <> '' THEN ' 8.' + A.Item08 END) ELSE '' END + CASE WHEN A.Item09 <> '' THEN (CASE WHEN RTRIM(A.Item09) <> '' THEN ' 9.' + A.Item09 END) 
  ELSE '' END + CASE WHEN A.Item10 <> '' THEN (CASE WHEN RTRIM(A.Item10) <> '' THEN ' 10.' + A.Item10 END) ELSE '' END + CASE WHEN A.Item11 <> '' THEN (CASE WHEN RTRIM(A.Item11) 
  <> '' THEN ' 11.' + A.Item11 END) ELSE '' END + CASE WHEN A.Item12 <> '' THEN (CASE WHEN RTRIM(A.Item12) <> '' THEN ' 12.' + A.Item12 END) 
  ELSE '' END + CASE WHEN A.Item13 <> '' THEN (CASE WHEN RTRIM(A.Item13) <> '' THEN ' 13.' + A.Item13 END) ELSE '' END + CASE WHEN A.Item14 <> '' THEN (CASE WHEN RTRIM(A.Item14) 
  <> '' THEN ' 14.' + A.Item14 END) ELSE '' END + CASE WHEN A.Item15 <> '' THEN (CASE WHEN RTRIM(A.Item15) <> '' THEN ' 15.' + A.Item15 END) 
  ELSE '' END + CASE WHEN A.Item16 <> '' THEN (CASE WHEN RTRIM(A.Item16) <> '' THEN ' 16.' + A.Item16 END) ELSE '' END + CASE WHEN A.Item17 <> '' THEN (CASE WHEN RTRIM(A.Item17) 
  <> '' THEN ' 17.' + A.Item17 END) ELSE '' END + CASE WHEN A.Item18 <> '' THEN (CASE WHEN RTRIM(A.Item18) <> '' THEN ' 18.' + A.Item18 END) 
  ELSE '' END + CASE WHEN A.Item19 <> '' THEN (CASE WHEN RTRIM(A.Item19) <> '' THEN ' 19.' + A.Item19 END) ELSE '' END + CASE WHEN A.Item20 <> '' THEN (CASE WHEN RTRIM(A.Item20) 
  <> '' THEN ' 20.' + A.Item20 END) ELSE '' END AS Item
FROM         dbo.BU_VOTE AS A INNER JOIN
dbo.VIEW_CCM_Main_Employee AS B ON A.EmployeeID = B.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS 
GO
/****** Object:  View [dbo].[VIEW_HR_OVRTM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_HR_OVRTM]
AS
SELECT A.OVRTNO, E.DEPM_NM,E.USR_NM, A.FETB,A.FETE, A.DEMIN, 
 CASE A.LNO WHEN '1' THEN '用餐' WHEN '0' THEN '不用餐' END AS LNO, A.DEREASON, 
 A.STATUS, CASE A.OTTP WHEN 'S' THEN '平日' WHEN 'H' THEN '假日' END AS OTTP
FROM HRSDBR53..HR_OVRTM A
LEFT JOIN VIEW_CCM_Main_ALLUSERS E ON A.EMPLYID=E.USR_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[VIEW_BU_LUNCH_DETAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_LUNCH_DETAIL]
AS
SELECT LUTYPE,
CASE LUTYPE WHEN '1' THEN '預訂單日不用餐' 
WHEN '2' THEN '預訂整月不用餐' WHEN '3' THEN '預訂素食用餐' WHEN '4' THEN '預訂訪客用餐' WHEN '6' THEN '用餐總人數' END AS LUTYPENM,
LOCATION,CASE LOCATION WHEN '1' THEN '精湛總廠' ELSE '全盈一廠' END AS LOCATIONNM,LUDATE,YEAR(LUDATE) AS LUDATEYEAR,MONTH(LUDATE) AS LUDATEMONTH,
CASE FROM_YEAR WHEN '' THEN NULL ELSE CONVERT(SMALLDATETIME,FROM_YEAR+'-'+FROM_MONTH+'-01') END AS FROM_YEARMONTH,
CASE TO_YEAR WHEN '' THEN NULL ELSE CONVERT(SMALLDATETIME,DATEADD(DAY,-1,DATEADD(MONTH,1,TO_YEAR+'-'+TO_MONTH+'-01'))) END AS TO_YEARMONTH,B.EMP_NM,B.DEPM_NM,MEATPEOPLES,VEGEPEOPLES
FROM BU_LUNCH A
JOIN VIEW_CCM_Main_Employee B ON A.EMPLYID=B.EMP_NO  COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE LUTYPE NOT IN ('5','6')
GO
/****** Object:  View [dbo].[V_EMP_ALBUM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_EMP_ALBUM]
AS
SELECT  M.EMPLYID, M.EMPLYNM, M.DEPID,D.DEPNM,M.BRTHDT, M.C_STA,M.REGDT,M.LLFDT,
        E.CName,E.PhotoUrl
 FROM HRSDBR53.dbo.HR_EMPLYM M ,HRSDBR53.dbo.HR_DEP D,EIP01.dbo.HR_EMPLOYEE E
 WHERE M.DEPID = D.DEPID
 AND M.EMPLYID = E.EMP_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
 AND M.C_STA='A'
GO
/****** Object:  View [dbo].[V_EMPLYEE_ALL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_EMPLYEE_ALL]
AS
SELECT     EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
FROM         [192.168.100.19].CCM_Main.dbo.EMPNO
/*
UNION
SELECT     EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
FROM         [192.168.100.19].CCS_Main.dbo.EMPNO
UNION
SELECT     EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
FROM         [192.168.100.19].KSC_15.dbo.EMPNO
UNION
SELECT     EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
FROM         [192.168.100.19].NGB_15.dbo.EMPNO
*/


GO
/****** Object:  View [dbo].[V_EMPNO_ALL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[V_EMPNO_ALL]
AS
/*
*以工號取得系統使用者姓名，包含其他事業體
*/
SELECT EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
 FROM [192.168.100.19].CCM_Main.dbo.EMPNO
 UNION
  SELECT EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
 FROM [192.168.100.19].CCS_Main.dbo.EMPNO
/*
 *UNION
 * SELECT EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
 *FROM [192.168.100.19].KSC_15.dbo.EMPNO
 *UNION
 *SELECT EMP_NO, EMP_NM, DEPM_NO, TEL_NO, TEL_NO2, E_MAIL, C_INV, C_PUR, C_COP, C_PPS, C_AST, C_ACT, C_SFC, C_QMS, C_BOM
 *FROM [192.168.100.19].NGB_15.dbo.EMPNO
*/

GO
/****** Object:  View [dbo].[V_ERP_CONNECT_CN_LIST]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ERP_CONNECT_CN_LIST]
AS
SELECT ID, host_name, program_name, emp_nm, client_net_address, login_name, db_name,
        convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI, CREATE_DATE) GMINUTE,
        dbo.SF_GETDEPT(program_name) DEPTNM
 FROM EIP01.dbo.PU_ERPSESSION
 WHERE db_name in ('NGB_15','KSC_15','DAC_15')
GO
/****** Object:  View [dbo].[V_ERP_CONNECT_CN_SUM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ERP_CONNECT_CN_SUM]
AS
SELECT ISNULL(CONVERT(VARCHAR(36), newid()),'') AS ID,convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI,CREATE_DATE)GMINUTE,COUNT(*) CNT
      -- CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME   
 FROM (
   SELECT ID, session_id, dbid, [host_name], program_name, emp_nm, client_net_address, login_name, [db_name],CREATE_DATE
FROM EIP01.dbo.PU_ERPSESSION
WHERE db_name in ('NGB_15','KSC_15','DAC_15')
 ) A
 GROUP BY convert(varchar(10),CREATE_DATE,120),DATEPART(HH, CREATE_DATE) ,DATEPART(MI, CREATE_DATE)
GO
/****** Object:  View [dbo].[V_ERP_CONNECT_LIST]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ERP_CONNECT_LIST]
AS
SELECT ID, host_name, program_name, emp_nm, client_net_address, login_name, db_name,
        convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI, CREATE_DATE) GMINUTE,
        dbo.SF_GETDEPT(program_name) DEPTNM
 FROM EIP01.dbo.PU_ERPSESSION
 WHERE db_name in ('CCM_Main','YPA_Main','CCS_Main')
GO
/****** Object:  View [dbo].[V_ERP_CONNECT_SUM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ERP_CONNECT_SUM]
AS
SELECT ISNULL(CONVERT(VARCHAR(36), newid()),'') AS ID,convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI,CREATE_DATE)GMINUTE,COUNT(*) CNT
      -- CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME   
 FROM (
   SELECT ID, session_id, dbid, [host_name], program_name, emp_nm, client_net_address, login_name, [db_name],CREATE_DATE
FROM EIP01.dbo.PU_ERPSESSION
WHERE db_name in ('CCM_Main','YPA_Main','CCS_Main')
 ) A
 GROUP BY convert(varchar(10),CREATE_DATE,120),DATEPART(HH, CREATE_DATE) ,DATEPART(MI, CREATE_DATE)
GO
/****** Object:  View [dbo].[V_ERP_ITEM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ERP_ITEM]
AS
SELECT i.ITEM_NO,i.ITEM_NM,i.ITEM_SP,i.ITEM_NO_O,i.CLAS_NO,i.CLAS_NO1,i.UNIT
FROM [192.168.100.19].CCM_Main.dbo.ITEM i
GO
/****** Object:  View [dbo].[V_GUARDLIST]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_GUARDLIST]
AS
SELECT     EMPLYID, EMPLYNM
FROM         HRSDBR53.dbo.HR_EXTERAL
WHERE     (ROLEID = 'M01') AND (C_STA = 'A')

GO
/****** Object:  View [dbo].[V_PDM_CONNECT_LIST]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PDM_CONNECT_LIST]
AS
SELECT ISNULL(CONVERT(VARCHAR(36), newid()),'') AS ID,GDATE,GHOUR,GMINUTE,CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME ,DEPTNM
FROM (
 SELECT DISTINCT convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI, CREATE_DATE) GMINUTE,
        CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME ,
        dbo.SF_GETDEPT(CONNECT_USER) DEPTNM
 FROM EIP01.dbo.PU_PDMSESSION
 ) A
GO
/****** Object:  View [dbo].[V_PDM_CONNECT_SUM]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_PDM_CONNECT_SUM]
AS
SELECT ISNULL(CONVERT(VARCHAR(36), newid()),'') AS ID,convert(varchar(10),CREATE_DATE,120) GDATE,DATEPART(HH, CREATE_DATE) GHOUR,DATEPART(MI, CREATE_DATE) GMINUTE
      ,COUNT(*) CNT
      -- CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME   
 FROM (
   SELECT DISTINCT CONNECT_PC, CONNECT_USER, USERNAME, CONNECT_IP , CONNECT_APPNAME,CREATE_DATE 
   FROM EIP01.dbo.PU_PDMSESSION
 ) A
 GROUP BY convert(varchar(10),CREATE_DATE,120),DATEPART(HH, CREATE_DATE) ,DATEPART(MI, CREATE_DATE)
GO
/****** Object:  View [dbo].[V_SRVDATAMT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVDATAMT]
AS
SELECT VCH_TY, VCH_NO, VCH_DT, RCV_MODE, EMP_NO, PROD_NO, CS_NO, PROB_REC, TO_ADDR, CURRENCY, EXCH_RATE, IVC_PAGE, TAX_TY, TAX_RT, PART_AMT, MMT_AMT, PLAN_DT, REAL_DT, REMK, C_CLS, N_PRT, C_CFM, CFM_DT, OWNER_GRP_NO, ADD_DT, CFM_USR_NO, IP_NM, CP_NM
 FROM [192.168.100.19].CCM_Main.dbo.SRVDATAMT
GO
/****** Object:  View [dbo].[V_SRVPRODMT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODMT]
AS
SELECT id, PROD_NO, PROD_TY, ITEM_NO, dbo.SF_ITEM_NM(ITEM_NO) ITEM_NM
 FROM EIP01.dbo.SRVPRODMT
GO
/****** Object:  View [dbo].[VIEW_BU_LUNCH_DEPQTY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_LUNCH_DEPQTY]
AS
SELECT YEAR(Q.LUNCHDATE) AS LYEAR,MONTH(Q.LUNCHDATE) AS LMONTH,DAY(Q.LUNCHDATE) AS LDAY,D.DEPNM,LUNCHQTY FROM [BU_LUNCH_DEPQTY] Q
JOIN HRSDBR53..HR_DEP D ON Q.DEPID=D.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[VIEW_BU_LUNCHYEAR]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_BU_LUNCHYEAR]
AS 
SELECT YEAR(GETDATE()) AS LUYEAR
UNION
SELECT YEAR(DATEADD(YEAR,1,GETDATE())) AS LUYEAR
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_REPLY_REPORT01]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_BU_VOTE_REPLY_REPORT01]
as
SELECT A.ParentSID,LEFT(B.ITEM01,20) AS ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0'
GROUP BY A.ParentSID,B.ITEM01
UNION
SELECT A.ParentSID,LEFT(B.ITEM02,20) AS ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0'
GROUP BY A.ParentSID,B.ITEM02
UNION
SELECT A.ParentSID,LEFT(B.ITEM03,20) AS ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0'
GROUP BY A.ParentSID,B.ITEM03
UNION
SELECT A.ParentSID,LEFT(B.ITEM04,20) AS ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0'
GROUP BY A.ParentSID,B.ITEM04
UNION
SELECT A.ParentSID,LEFT(B.ITEM05,20) AS ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0'
GROUP BY A.ParentSID,B.ITEM05
UNION
SELECT A.ParentSID,LEFT(B.ITEM06,20) AS ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0'
GROUP BY A.ParentSID,B.ITEM06
UNION
SELECT A.ParentSID,LEFT(B.ITEM07,20) AS ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0'
GROUP BY A.ParentSID,B.ITEM07
UNION
SELECT A.ParentSID,LEFT(B.ITEM08,20) AS ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0'
GROUP BY A.ParentSID,B.ITEM08
UNION
SELECT A.ParentSID,LEFT(B.ITEM09,20) AS ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0'
GROUP BY A.ParentSID,B.ITEM09
UNION
SELECT A.ParentSID,LEFT(B.ITEM10,20) AS ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0'
GROUP BY A.ParentSID,B.ITEM10
UNION
SELECT A.ParentSID,LEFT(B.Item11,20) AS ITEM11,COUNT(A.Item11) AS ITEM01_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item11<>'0'
GROUP BY A.ParentSID,B.Item11
UNION
SELECT A.ParentSID,LEFT(B.Item12,20) AS ITEM12,COUNT(A.Item12) AS ITEM02_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item12<>'0'
GROUP BY A.ParentSID,B.Item12
UNION
SELECT A.ParentSID,LEFT(B.Item13,20) AS ITEM13,COUNT(A.Item13) AS ITEM03_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item13<>'0'
GROUP BY A.ParentSID,B.Item13
UNION
SELECT A.ParentSID,LEFT(B.Item14,20) AS ITEM14,COUNT(A.Item14) AS ITEM04_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item14<>'0'
GROUP BY A.ParentSID,B.Item14
UNION
SELECT A.ParentSID,LEFT(B.Item15,20) AS ITEM15,COUNT(A.Item15) AS ITEM05_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item15<>'0'
GROUP BY A.ParentSID,B.Item15
UNION
SELECT A.ParentSID,LEFT(B.Item16,20) AS ITEM16,COUNT(A.Item16) AS ITEM06_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item16<>'0'
GROUP BY A.ParentSID,B.Item16
UNION
SELECT A.ParentSID,LEFT(B.Item17,20) AS ITEM17,COUNT(A.Item17) AS ITEM07_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item17<>'0'
GROUP BY A.ParentSID,B.Item17
UNION
SELECT A.ParentSID,LEFT(B.Item18,20) AS ITEM18,COUNT(A.Item18) AS ITEM08_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item18<>'0'
GROUP BY A.ParentSID,B.Item18
UNION
SELECT A.ParentSID,LEFT(B.Item19,20) AS ITEM19,COUNT(A.Item19) AS ITEM09_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.Item19<>'0'
GROUP BY A.ParentSID,B.Item19
UNION
SELECT A.ParentSID,LEFT(B.ITEM20,20) AS ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0'
GROUP BY A.ParentSID,B.ITEM20
GO
/****** Object:  View [dbo].[VIEW_BU_VOTE_SATISFIED_REPORT01]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create VIEW [dbo].[VIEW_BU_VOTE_SATISFIED_REPORT01]
AS
SELECT DISTINCT A.ParentSID,B.ITEM01,ISNULL(A3.ITEM01_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM01_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM01_COUNT5,0) AS Normal,ISNULL(A6.ITEM01_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM01_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0' AND B.SelectMode='3' AND A.ITEM01='3'
GROUP BY A.ParentSID,B.ITEM01
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM01=B.ITEM01
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0' AND B.SelectMode='3' AND A.ITEM01='4'
GROUP BY A.ParentSID,B.ITEM01
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM01=B.ITEM01
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0' AND B.SelectMode='3' AND A.ITEM01='5'
GROUP BY A.ParentSID,B.ITEM01
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM01=B.ITEM01
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0' AND B.SelectMode='3' AND A.ITEM01='6'
GROUP BY A.ParentSID,B.ITEM01
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM01=B.ITEM01
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM01,COUNT(A.ITEM01) AS ITEM01_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM01<>'0' AND B.SelectMode='3' AND A.ITEM01='7'
GROUP BY A.ParentSID,B.ITEM01
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM01=B.ITEM01
WHERE A.ITEM01<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM02,ISNULL(A3.ITEM02_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM02_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM02_COUNT5,0) AS Normal,ISNULL(A6.ITEM02_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM02_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0' AND B.SelectMode='3' AND A.ITEM02='3'
GROUP BY A.ParentSID,B.ITEM02
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM02=B.ITEM02
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0' AND B.SelectMode='3' AND A.ITEM02='4'
GROUP BY A.ParentSID,B.ITEM02
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM02=B.ITEM02
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0' AND B.SelectMode='3' AND A.ITEM02='5'
GROUP BY A.ParentSID,B.ITEM02
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM02=B.ITEM02
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0' AND B.SelectMode='3' AND A.ITEM02='6'
GROUP BY A.ParentSID,B.ITEM02
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM02=B.ITEM02
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM02,COUNT(A.ITEM02) AS ITEM02_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM02<>'0' AND B.SelectMode='3' AND A.ITEM02='7'
GROUP BY A.ParentSID,B.ITEM02
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM02=B.ITEM02
WHERE A.ITEM02<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM03,ISNULL(A3.ITEM03_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM03_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM03_COUNT5,0) AS Normal,ISNULL(A6.ITEM03_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM03_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0' AND B.SelectMode='3' AND A.ITEM03='3'
GROUP BY A.ParentSID,B.ITEM03
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM03=B.ITEM03
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0' AND B.SelectMode='3' AND A.ITEM03='4'
GROUP BY A.ParentSID,B.ITEM03
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM03=B.ITEM03
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0' AND B.SelectMode='3' AND A.ITEM03='5'
GROUP BY A.ParentSID,B.ITEM03
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM03=B.ITEM03
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0' AND B.SelectMode='3' AND A.ITEM03='6'
GROUP BY A.ParentSID,B.ITEM03
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM03=B.ITEM03
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM03,COUNT(A.ITEM03) AS ITEM03_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM03<>'0' AND B.SelectMode='3' AND A.ITEM03='7'
GROUP BY A.ParentSID,B.ITEM03
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM03=B.ITEM03
WHERE A.ITEM03<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM04,ISNULL(A3.ITEM04_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM04_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM04_COUNT5,0) AS Normal,ISNULL(A6.ITEM04_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM04_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0' AND B.SelectMode='3' AND A.ITEM04='3'
GROUP BY A.ParentSID,B.ITEM04
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM04=B.ITEM04
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0' AND B.SelectMode='3' AND A.ITEM04='4'
GROUP BY A.ParentSID,B.ITEM04
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM04=B.ITEM04
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0' AND B.SelectMode='3' AND A.ITEM04='5'
GROUP BY A.ParentSID,B.ITEM04
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM04=B.ITEM04
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0' AND B.SelectMode='3' AND A.ITEM04='6'
GROUP BY A.ParentSID,B.ITEM04
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM04=B.ITEM04
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM04,COUNT(A.ITEM04) AS ITEM04_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM04<>'0' AND B.SelectMode='3' AND A.ITEM04='7'
GROUP BY A.ParentSID,B.ITEM04
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM04=B.ITEM04
WHERE A.ITEM04<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM05,ISNULL(A3.ITEM05_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM05_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM05_COUNT5,0) AS Normal,ISNULL(A6.ITEM05_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM05_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0' AND B.SelectMode='3' AND A.ITEM05='3'
GROUP BY A.ParentSID,B.ITEM05
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM05=B.ITEM05
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0' AND B.SelectMode='3' AND A.ITEM05='4'
GROUP BY A.ParentSID,B.ITEM05
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM05=B.ITEM05
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0' AND B.SelectMode='3' AND A.ITEM05='5'
GROUP BY A.ParentSID,B.ITEM05
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM05=B.ITEM05
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0' AND B.SelectMode='3' AND A.ITEM05='6'
GROUP BY A.ParentSID,B.ITEM05
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM05=B.ITEM05
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM05,COUNT(A.ITEM05) AS ITEM05_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM05<>'0' AND B.SelectMode='3' AND A.ITEM05='7'
GROUP BY A.ParentSID,B.ITEM05
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM05=B.ITEM05
WHERE A.ITEM05<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM06,ISNULL(A3.ITEM06_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM06_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM06_COUNT5,0) AS Normal,ISNULL(A6.ITEM06_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM06_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0' AND B.SelectMode='3' AND A.ITEM06='3'
GROUP BY A.ParentSID,B.ITEM06
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM06=B.ITEM06
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0' AND B.SelectMode='3' AND A.ITEM06='4'
GROUP BY A.ParentSID,B.ITEM06
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM06=B.ITEM06
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0' AND B.SelectMode='3' AND A.ITEM06='5'
GROUP BY A.ParentSID,B.ITEM06
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM06=B.ITEM06
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0' AND B.SelectMode='3' AND A.ITEM06='6'
GROUP BY A.ParentSID,B.ITEM06
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM06=B.ITEM06
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM06,COUNT(A.ITEM06) AS ITEM06_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM06<>'0' AND B.SelectMode='3' AND A.ITEM06='7'
GROUP BY A.ParentSID,B.ITEM06
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM06=B.ITEM06
WHERE A.ITEM06<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM07,ISNULL(A3.ITEM07_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM07_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM07_COUNT5,0) AS Normal,ISNULL(A6.ITEM07_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM07_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0' AND B.SelectMode='3' AND A.ITEM07='3'
GROUP BY A.ParentSID,B.ITEM07
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM07=B.ITEM07
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0' AND B.SelectMode='3' AND A.ITEM07='4'
GROUP BY A.ParentSID,B.ITEM07
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM07=B.ITEM07
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0' AND B.SelectMode='3' AND A.ITEM07='5'
GROUP BY A.ParentSID,B.ITEM07
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM07=B.ITEM07
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0' AND B.SelectMode='3' AND A.ITEM07='6'
GROUP BY A.ParentSID,B.ITEM07
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM07=B.ITEM07
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM07,COUNT(A.ITEM07) AS ITEM07_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM07<>'0' AND B.SelectMode='3' AND A.ITEM07='7'
GROUP BY A.ParentSID,B.ITEM07
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM07=B.ITEM07
WHERE A.ITEM07<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM08,ISNULL(A3.ITEM08_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM08_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM08_COUNT5,0) AS Normal,ISNULL(A6.ITEM08_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM08_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0' AND B.SelectMode='3' AND A.ITEM08='3'
GROUP BY A.ParentSID,B.ITEM08
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM08=B.ITEM08
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0' AND B.SelectMode='3' AND A.ITEM08='4'
GROUP BY A.ParentSID,B.ITEM08
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM08=B.ITEM08
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0' AND B.SelectMode='3' AND A.ITEM08='5'
GROUP BY A.ParentSID,B.ITEM08
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM08=B.ITEM08
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0' AND B.SelectMode='3' AND A.ITEM08='6'
GROUP BY A.ParentSID,B.ITEM08
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM08=B.ITEM08
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM08,COUNT(A.ITEM08) AS ITEM08_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM08<>'0' AND B.SelectMode='3' AND A.ITEM08='7'
GROUP BY A.ParentSID,B.ITEM08
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM08=B.ITEM08
WHERE A.ITEM08<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM09,ISNULL(A3.ITEM09_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM09_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM09_COUNT5,0) AS Normal,ISNULL(A6.ITEM09_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM09_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0' AND B.SelectMode='3' AND A.ITEM09='3'
GROUP BY A.ParentSID,B.ITEM09
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM09=B.ITEM09
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0' AND B.SelectMode='3' AND A.ITEM09='4'
GROUP BY A.ParentSID,B.ITEM09
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM09=B.ITEM09
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0' AND B.SelectMode='3' AND A.ITEM09='5'
GROUP BY A.ParentSID,B.ITEM09
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM09=B.ITEM09
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0' AND B.SelectMode='3' AND A.ITEM09='6'
GROUP BY A.ParentSID,B.ITEM09
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM09=B.ITEM09
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM09,COUNT(A.ITEM09) AS ITEM09_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM09<>'0' AND B.SelectMode='3' AND A.ITEM09='7'
GROUP BY A.ParentSID,B.ITEM09
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM09=B.ITEM09
WHERE A.ITEM09<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM10,ISNULL(A3.ITEM10_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM10_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM10_COUNT5,0) AS Normal,ISNULL(A6.ITEM10_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM10_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0' AND B.SelectMode='3' AND A.ITEM10='3'
GROUP BY A.ParentSID,B.ITEM10
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM10=B.ITEM10
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0' AND B.SelectMode='3' AND A.ITEM10='4'
GROUP BY A.ParentSID,B.ITEM10
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM10=B.ITEM10
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0' AND B.SelectMode='3' AND A.ITEM10='5'
GROUP BY A.ParentSID,B.ITEM10
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM10=B.ITEM10
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0' AND B.SelectMode='3' AND A.ITEM10='6'
GROUP BY A.ParentSID,B.ITEM10
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM10=B.ITEM10
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM10,COUNT(A.ITEM10) AS ITEM10_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM10<>'0' AND B.SelectMode='3' AND A.ITEM10='7'
GROUP BY A.ParentSID,B.ITEM10
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM10=B.ITEM10
WHERE A.ITEM10<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM11,ISNULL(A3.ITEM11_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM11_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM11_COUNT5,0) AS Normal,ISNULL(A6.ITEM11_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM11_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM11,COUNT(A.ITEM11) AS ITEM11_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM11<>'0' AND B.SelectMode='3' AND A.ITEM11='3'
GROUP BY A.ParentSID,B.ITEM11
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM11=B.ITEM11
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM11,COUNT(A.ITEM11) AS ITEM11_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM11<>'0' AND B.SelectMode='3' AND A.ITEM11='4'
GROUP BY A.ParentSID,B.ITEM11
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM11=B.ITEM11
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM11,COUNT(A.ITEM11) AS ITEM11_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM11<>'0' AND B.SelectMode='3' AND A.ITEM11='5'
GROUP BY A.ParentSID,B.ITEM11
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM11=B.ITEM11
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM11,COUNT(A.ITEM11) AS ITEM11_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM11<>'0' AND B.SelectMode='3' AND A.ITEM11='6'
GROUP BY A.ParentSID,B.ITEM11
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM11=B.ITEM11
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM11,COUNT(A.ITEM11) AS ITEM11_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM11<>'0' AND B.SelectMode='3' AND A.ITEM11='7'
GROUP BY A.ParentSID,B.ITEM11
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM11=B.ITEM11
WHERE A.ITEM11<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM12,ISNULL(A3.ITEM12_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM12_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM12_COUNT5,0) AS Normal,ISNULL(A6.ITEM12_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM12_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM12,COUNT(A.ITEM12) AS ITEM12_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM12<>'0' AND B.SelectMode='3' AND A.ITEM12='3'
GROUP BY A.ParentSID,B.ITEM12
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM12=B.ITEM12
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM12,COUNT(A.ITEM12) AS ITEM12_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM12<>'0' AND B.SelectMode='3' AND A.ITEM12='4'
GROUP BY A.ParentSID,B.ITEM12
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM12=B.ITEM12
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM12,COUNT(A.ITEM12) AS ITEM12_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM12<>'0' AND B.SelectMode='3' AND A.ITEM12='5'
GROUP BY A.ParentSID,B.ITEM12
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM12=B.ITEM12
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM12,COUNT(A.ITEM12) AS ITEM12_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM12<>'0' AND B.SelectMode='3' AND A.ITEM12='6'
GROUP BY A.ParentSID,B.ITEM12
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM12=B.ITEM12
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM12,COUNT(A.ITEM12) AS ITEM12_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM12<>'0' AND B.SelectMode='3' AND A.ITEM12='7'
GROUP BY A.ParentSID,B.ITEM12
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM12=B.ITEM12
WHERE A.ITEM12<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM13,ISNULL(A3.ITEM13_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM13_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM13_COUNT5,0) AS Normal,ISNULL(A6.ITEM13_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM13_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM13,COUNT(A.ITEM13) AS ITEM13_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM13<>'0' AND B.SelectMode='3' AND A.ITEM13='3'
GROUP BY A.ParentSID,B.ITEM13
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM13=B.ITEM13
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM13,COUNT(A.ITEM13) AS ITEM13_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM13<>'0' AND B.SelectMode='3' AND A.ITEM13='4'
GROUP BY A.ParentSID,B.ITEM13
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM13=B.ITEM13
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM13,COUNT(A.ITEM13) AS ITEM13_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM13<>'0' AND B.SelectMode='3' AND A.ITEM13='5'
GROUP BY A.ParentSID,B.ITEM13
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM13=B.ITEM13
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM13,COUNT(A.ITEM13) AS ITEM13_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM13<>'0' AND B.SelectMode='3' AND A.ITEM13='6'
GROUP BY A.ParentSID,B.ITEM13
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM13=B.ITEM13
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM13,COUNT(A.ITEM13) AS ITEM13_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM13<>'0' AND B.SelectMode='3' AND A.ITEM13='7'
GROUP BY A.ParentSID,B.ITEM13
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM13=B.ITEM13
WHERE A.ITEM13<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM14,ISNULL(A3.ITEM14_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM14_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM14_COUNT5,0) AS Normal,ISNULL(A6.ITEM14_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM14_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM14,COUNT(A.ITEM14) AS ITEM14_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM14<>'0' AND B.SelectMode='3' AND A.ITEM14='3'
GROUP BY A.ParentSID,B.ITEM14
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM14=B.ITEM14
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM14,COUNT(A.ITEM14) AS ITEM14_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM14<>'0' AND B.SelectMode='3' AND A.ITEM14='4'
GROUP BY A.ParentSID,B.ITEM14
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM14=B.ITEM14
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM14,COUNT(A.ITEM14) AS ITEM14_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM14<>'0' AND B.SelectMode='3' AND A.ITEM14='5'
GROUP BY A.ParentSID,B.ITEM14
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM14=B.ITEM14
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM14,COUNT(A.ITEM14) AS ITEM14_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM14<>'0' AND B.SelectMode='3' AND A.ITEM14='6'
GROUP BY A.ParentSID,B.ITEM14
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM14=B.ITEM14
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM14,COUNT(A.ITEM14) AS ITEM14_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM14<>'0' AND B.SelectMode='3' AND A.ITEM14='7'
GROUP BY A.ParentSID,B.ITEM14
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM14=B.ITEM14
WHERE A.ITEM14<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM15,ISNULL(A3.ITEM15_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM15_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM15_COUNT5,0) AS Normal,ISNULL(A6.ITEM15_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM15_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM15,COUNT(A.ITEM15) AS ITEM15_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM15<>'0' AND B.SelectMode='3' AND A.ITEM15='3'
GROUP BY A.ParentSID,B.ITEM15
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM15=B.ITEM15
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM15,COUNT(A.ITEM15) AS ITEM15_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM15<>'0' AND B.SelectMode='3' AND A.ITEM15='4'
GROUP BY A.ParentSID,B.ITEM15
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM15=B.ITEM15
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM15,COUNT(A.ITEM15) AS ITEM15_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM15<>'0' AND B.SelectMode='3' AND A.ITEM15='5'
GROUP BY A.ParentSID,B.ITEM15
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM15=B.ITEM15
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM15,COUNT(A.ITEM15) AS ITEM15_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM15<>'0' AND B.SelectMode='3' AND A.ITEM15='6'
GROUP BY A.ParentSID,B.ITEM15
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM15=B.ITEM15
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM15,COUNT(A.ITEM15) AS ITEM15_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM15<>'0' AND B.SelectMode='3' AND A.ITEM15='7'
GROUP BY A.ParentSID,B.ITEM15
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM15=B.ITEM15
WHERE A.ITEM15<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM16,ISNULL(A3.ITEM16_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM16_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM16_COUNT5,0) AS Normal,ISNULL(A6.ITEM16_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM16_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM16,COUNT(A.ITEM16) AS ITEM16_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM16<>'0' AND B.SelectMode='3' AND A.ITEM16='3'
GROUP BY A.ParentSID,B.ITEM16
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM16=B.ITEM16
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM16,COUNT(A.ITEM16) AS ITEM16_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM16<>'0' AND B.SelectMode='3' AND A.ITEM16='4'
GROUP BY A.ParentSID,B.ITEM16
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM16=B.ITEM16
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM16,COUNT(A.ITEM16) AS ITEM16_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM16<>'0' AND B.SelectMode='3' AND A.ITEM16='5'
GROUP BY A.ParentSID,B.ITEM16
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM16=B.ITEM16
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM16,COUNT(A.ITEM16) AS ITEM16_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM16<>'0' AND B.SelectMode='3' AND A.ITEM16='6'
GROUP BY A.ParentSID,B.ITEM16
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM16=B.ITEM16
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM16,COUNT(A.ITEM16) AS ITEM16_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM16<>'0' AND B.SelectMode='3' AND A.ITEM16='7'
GROUP BY A.ParentSID,B.ITEM16
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM16=B.ITEM16
WHERE A.ITEM16<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM17,ISNULL(A3.ITEM17_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM17_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM17_COUNT5,0) AS Normal,ISNULL(A6.ITEM17_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM17_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM17,COUNT(A.ITEM17) AS ITEM17_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM17<>'0' AND B.SelectMode='3' AND A.ITEM17='3'
GROUP BY A.ParentSID,B.ITEM17
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM17=B.ITEM17
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM17,COUNT(A.ITEM17) AS ITEM17_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM17<>'0' AND B.SelectMode='3' AND A.ITEM17='4'
GROUP BY A.ParentSID,B.ITEM17
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM17=B.ITEM17
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM17,COUNT(A.ITEM17) AS ITEM17_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM17<>'0' AND B.SelectMode='3' AND A.ITEM17='5'
GROUP BY A.ParentSID,B.ITEM17
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM17=B.ITEM17
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM17,COUNT(A.ITEM17) AS ITEM17_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM17<>'0' AND B.SelectMode='3' AND A.ITEM17='6'
GROUP BY A.ParentSID,B.ITEM17
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM17=B.ITEM17
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM17,COUNT(A.ITEM17) AS ITEM17_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM17<>'0' AND B.SelectMode='3' AND A.ITEM17='7'
GROUP BY A.ParentSID,B.ITEM17
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM17=B.ITEM17
WHERE A.ITEM17<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM18,ISNULL(A3.ITEM18_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM18_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM18_COUNT5,0) AS Normal,ISNULL(A6.ITEM18_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM18_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM18,COUNT(A.ITEM18) AS ITEM18_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM18<>'0' AND B.SelectMode='3' AND A.ITEM18='3'
GROUP BY A.ParentSID,B.ITEM18
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM18=B.ITEM18
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM18,COUNT(A.ITEM18) AS ITEM18_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM18<>'0' AND B.SelectMode='3' AND A.ITEM18='4'
GROUP BY A.ParentSID,B.ITEM18
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM18=B.ITEM18
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM18,COUNT(A.ITEM18) AS ITEM18_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM18<>'0' AND B.SelectMode='3' AND A.ITEM18='5'
GROUP BY A.ParentSID,B.ITEM18
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM18=B.ITEM18
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM18,COUNT(A.ITEM18) AS ITEM18_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM18<>'0' AND B.SelectMode='3' AND A.ITEM18='6'
GROUP BY A.ParentSID,B.ITEM18
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM18=B.ITEM18
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM18,COUNT(A.ITEM18) AS ITEM18_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM18<>'0' AND B.SelectMode='3' AND A.ITEM18='7'
GROUP BY A.ParentSID,B.ITEM18
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM18=B.ITEM18
WHERE A.ITEM18<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM19,ISNULL(A3.ITEM19_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM19_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM19_COUNT5,0) AS Normal,ISNULL(A6.ITEM19_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM19_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM19,COUNT(A.ITEM19) AS ITEM19_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM19<>'0' AND B.SelectMode='3' AND A.ITEM19='3'
GROUP BY A.ParentSID,B.ITEM19
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM19=B.ITEM19
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM19,COUNT(A.ITEM19) AS ITEM19_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM19<>'0' AND B.SelectMode='3' AND A.ITEM19='4'
GROUP BY A.ParentSID,B.ITEM19
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM19=B.ITEM19
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM19,COUNT(A.ITEM19) AS ITEM19_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM19<>'0' AND B.SelectMode='3' AND A.ITEM19='5'
GROUP BY A.ParentSID,B.ITEM19
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM19=B.ITEM19
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM19,COUNT(A.ITEM19) AS ITEM19_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM19<>'0' AND B.SelectMode='3' AND A.ITEM19='6'
GROUP BY A.ParentSID,B.ITEM19
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM19=B.ITEM19
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM19,COUNT(A.ITEM19) AS ITEM19_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM19<>'0' AND B.SelectMode='3' AND A.ITEM19='7'
GROUP BY A.ParentSID,B.ITEM19
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM19=B.ITEM19
WHERE A.ITEM19<>'0' AND B.SelectMode='3'
UNION
SELECT DISTINCT A.ParentSID,B.ITEM20,ISNULL(A3.ITEM20_COUNT3,0) AS VerySatisfied,ISNULL(A4.ITEM20_COUNT4,0) AS Satisfied,
ISNULL(A5.ITEM20_COUNT5,0) AS Normal,ISNULL(A6.ITEM20_COUNT6,0) AS Dissatisfied,ISNULL(A7.ITEM20_COUNT7,0) AS VeryDissatisfied
FROM BU_VOTE_DETAIL A 
JOIN BU_Vote B ON A.ParentSID=B.SID 
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT3
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0' AND B.SelectMode='3' AND A.ITEM20='3'
GROUP BY A.ParentSID,B.ITEM20
) A3 ON A3.ParentSID=A.ParentSID AND A3.ITEM20=B.ITEM20
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT4
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0' AND B.SelectMode='3' AND A.ITEM20='4'
GROUP BY A.ParentSID,B.ITEM20
) A4 ON A4.ParentSID=A.ParentSID AND A4.ITEM20=B.ITEM20
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT5
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0' AND B.SelectMode='3' AND A.ITEM20='5'
GROUP BY A.ParentSID,B.ITEM20
) A5 ON A5.ParentSID=A.ParentSID AND A5.ITEM20=B.ITEM20
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT6
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0' AND B.SelectMode='3' AND A.ITEM20='6'
GROUP BY A.ParentSID,B.ITEM20
) A6 ON A6.ParentSID=A.ParentSID AND A6.ITEM20=B.ITEM20
LEFT JOIN 
(
SELECT A.ParentSID,B.ITEM20,COUNT(A.ITEM20) AS ITEM20_COUNT7
FROM BU_VOTE_DETAIL A
JOIN BU_Vote B ON A.ParentSID=B.SID 
WHERE A.ITEM20<>'0' AND B.SelectMode='3' AND A.ITEM20='7'
GROUP BY A.ParentSID,B.ITEM20
) A7 ON A7.ParentSID=A.ParentSID AND A7.ITEM20=B.ITEM20
WHERE A.ITEM20<>'0' AND B.SelectMode='3'
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_DEPM_VALID]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_CCM_Main_DEPM_VALID]
as 
SELECT DISTINCT RTRIM(A.DEPID) AS DEPM_NO,A.DEPNM AS DEPM_NM
FROM HRSDBR53..HR_DEP A
JOIN HRSDBR53..HR_EMPLYM B ON A.DEPID=B.DEPID
WHERE B.C_STA='A'
UNION
SELECT 'E00','總經理'
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_EMPLOYEE_DATA]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CCM_Main_EMPLOYEE_DATA]
 AS
SELECT RTRIM(A.EMPLYID) AS EMP_NO,RTRIM(A.EMPLYNM) AS EMP_NM,
CONVERT(CHAR(10),A.REGDT,120) AS ARV_DT,RTRIM(A.DEPID) AS DEPM_NO,RTRIM(A.SEX) AS SEX,
RTRIM(A.PIDNO) AS ID_NO,CONVERT(CHAR(10),A.LLFDT,120) AS LEV_DT,RTRIM(A.JOBID) AS JOB_NO,RTRIM(A.HP) AS TEL_NO2,
RTRIM(E.JOBNM) AS JOB_NM,RTRIM(C.DEPM_NM) AS DEPM_NM,RTRIM(F.DEPM_NM)+RTRIM(C.DEPM_NM) AS DEPM_NM1
FROM HRSDBR53.dbo.HR_EMPLYM A 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPID=C.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM F ON C.U_DEPM_NO=F.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
LEFT JOIN HRSDBR53..HR_JOBID E ON A.JOBID=E.JOBID
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_EMPLOYEE_DATA1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CCM_Main_EMPLOYEE_DATA1]
AS
SELECT     M.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS AS EMP_NO, M.EMPLYNM COLLATE Chinese_Taiwan_Stroke_CI_AS AS EMP_NM, CONVERT(char(10), 
                      M.REGDT, 20) COLLATE Chinese_Taiwan_Stroke_CI_AS AS ARV_DT, CONVERT(char(10), M.LLFDT, 20) COLLATE Chinese_Taiwan_Stroke_CI_AS AS LEV_DT
FROM         HRSDBR53.dbo.HR_EMPLYM AS M LEFT OUTER JOIN
                      HRSDBR53.dbo.HR_DEP AS D ON M.DEPID = D.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS
WHERE     (M.C_STA = 'A')

GO
/****** Object:  View [dbo].[VIEW_CCM_Main_Employee_Resign]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_CCM_Main_Employee_Resign]
as 
SELECT RTRIM(A.EMP_NO) AS EMP_NO,RTRIM(A.EMP_NM) AS EMP_NM,RIGHT(CONVERT(CHAR(10),A.BRD_DT,120),5) AS BRD_DT,
CONVERT(CHAR(3),(YEAR(A.BRD_DT)-1911))+RIGHT(CONVERT(CHAR(10),A.BRD_DT,120),6) AS BRD_DT1,
CONVERT(CHAR(3),(YEAR(A.ARV_DT)-1911))+RIGHT(CONVERT(CHAR(10),A.ARV_DT,120),6) AS ARV_DT,
RTRIM(A.DEPM_NO) AS DEPM_NO,RTRIM(A.SEX) AS SEX,RTRIM(A.ID_NO) AS ID_NO,CONVERT(CHAR(10),A.LEV_DT,120) AS LEV_DT,RTRIM(A.JOB_NO) AS JOB_NO,RTRIM(A.TEL_NO2) AS TEL_NO2,
RTRIM(E.JOB_NM) AS JOB_NM,RTRIM(C.DEPM_NM) AS DEPM_NM,RTRIM(F.DEPM_NM)+RTRIM(C.DEPM_NM) AS DEPM_NM1,RTRIM(D.PhotoUrl) AS PhotoUrl
FROM [192.168.100.19].CCM_Main.dbo.EMPLOYEE A 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM F ON C.U_DEPM_NO=F.DEPM_NO
LEFT JOIN HR_EMPLOYEE D ON A.EMP_NO=D.EMP_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.PNLJOB E ON A.JOB_NO=E.JOB_NO
WHERE A.C_STA='N' AND A.EMP_NO NOT IN ('A830902','B001203','B010505','B010701') AND A.EMP_NO NOT LIKE 'Z%' 
GO
/****** Object:  View [dbo].[VIEW_CCM_Main_Employee_Resign1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CCM_Main_Employee_Resign1]
AS
SELECT     M.EMPLYID AS EMP_NO, M.EMPLYNM AS EMP_NM, RIGHT(CONVERT(CHAR(10), M.BRTHDT, 120), 5) AS BRD_DT, CONVERT(CHAR(3), YEAR(M.BRTHDT) - 1911) 
                      + RIGHT(CONVERT(CHAR(10), M.BRTHDT, 120), 6) AS BRD_DT1, CONVERT(CHAR(3), YEAR(M.REGDT) - 1911) + RIGHT(CONVERT(CHAR(10), M.REGDT, 120), 6) 
                      AS ARV_DT, M.DEPID AS DEPM_NO, M.SEX, M.PIDNO AS ID_NO, CONVERT(CHAR(3), YEAR(M.LLFDT) - 1911) + RIGHT(CONVERT(CHAR(10), M.LLFDT, 120), 6) 
                      AS LEV_DT, M.JOBID AS JOB_NO, M.HP AS TEL_NO2, J.JOBNM AS JOB_NM, D.DEPNM AS DEPM_NM, D1.DEPNM AS DEPM_NM1, E.PhotoUrl
FROM         HRSDBR53.dbo.HR_EMPLYM AS M INNER JOIN
                      HRSDBR53.dbo.HR_DEP AS D ON M.DEPID = D.DEPID LEFT OUTER JOIN
                      HRSDBR53.dbo.HR_DEP AS D1 ON D.DPRTID = D1.DEPID LEFT OUTER JOIN
                      HRSDBR53.dbo.HR_JOBID AS J ON M.JOBID = J.JOBID LEFT OUTER JOIN
                      dbo.HR_EMPLOYEE AS E ON M.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS = E.EMP_NO
WHERE     (M.C_STA = 'D')

GO
/****** Object:  View [dbo].[VIEW_CCM_Main_USERS1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_CCM_Main_USERS1]
AS
SELECT     a.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS as USR_NO, a.USR_NM COLLATE Chinese_Taiwan_Stroke_CI_AS as USR_NM, b.USR_PW COLLATE Chinese_Taiwan_Stroke_CI_AS as USR_PW, a.DEPM_NO COLLATE Chinese_Taiwan_Stroke_CI_AS as DEPM_NO, a.DEPM_NM COLLATE Chinese_Taiwan_Stroke_CI_AS as DEPM_NM, a.E_MAIL COLLATE Chinese_Taiwan_Stroke_CI_AS as E_MAIL
FROM         (SELECT     M.EMPLYID AS USR_NO, M.EMPLYNM AS USR_NM, /*as USR_PW,*/ M.DEPID AS DEPM_NO, D .DEPNM AS DEPM_NM, RTRIM(M.EMPLYID) 
                                              + '@CCM3S.COM' AS E_MAIL
                       FROM          HRSDBR53.dbo.HR_EMPLYM AS M LEFT OUTER JOIN
                                              HRSDBR53.dbo.HR_DEP AS D ON M.DEPID = D .DEPID
                       WHERE      (M.C_STA = 'A')) AS a LEFT JOIN
                      [192.168.100.19].[CCM_Main].[dbo].[USRNO] AS b ON a.USR_NO = b.USR_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
UNION
SELECT     'BMW', '守衛室', 'bmw', 'G00', '管理部', ''

GO
/****** Object:  View [dbo].[VIEW_employee]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_employee]
AS
SELECT  M.EMPLYID, M.EMPLYNM, M.DEPID,D.DEPNM, M.C_STA,REGDT,LLFDT
 FROM HRSDBR53.dbo.HR_EMPLYM M
 LEFT JOIN HRSDBR53..HR_DEP D ON M.DEPID=D.DEPID WHERE M.C_STA='A' 
GO
/****** Object:  View [dbo].[VIEW_FR_OFFIDOC_ISSUE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--VIEW_FR_OFFIDOC_ISSUE
CREATE VIEW [dbo].[VIEW_FR_OFFIDOC_ISSUE]
AS
SELECT A.*,C.DEPM_NM,D.EMP_NM,
CASE DOCTYPE WHEN '1' THEN '普通件' WHEN '2' THEN '速件' WHEN '3' THEN '最速件' END AS DOCTYPENM FROM FR_OFFIDOC_ISSUE A
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPID=C.DEPM_NO
JOIN [192.168.100.19].CCM_Main.dbo.EMPNO D ON A.EMPID=D.EMP_NO
GO
/****** Object:  View [dbo].[VIEW_FR_OFFIDOC_ISSUE_ATTACH_FILE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_FR_OFFIDOC_ISSUE_ATTACH_FILE]
AS
SELECT * FROM FR_OFFIDOC_ISSUE_ATTACH_FILE
GO
/****** Object:  View [dbo].[VIEW_HR_DEREASON_ORDER]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_HR_DEREASON_ORDER]
AS 
SELECT DEREASON,EMPLYID,DEPID,COUNT(DEREASON) AS AA FROM HRSDBR53..HR_OVRTM 
WHERE DEREASON IS NOT NULL AND DEREASON<>'' 
GROUP BY DEREASON,EMPLYID,DEPID
HAVING COUNT(DEREASON)>2
GO
/****** Object:  View [dbo].[VIEW_HR_EMP_BIRTHDAY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_HR_EMP_BIRTHDAY] AS 
SELECT A.EMPLYNM,A.BRTHDT,B.JOBNM,C.DEPNM FROM HRSDBR53..HR_EMPLYM A
JOIN HRSDBR53..HR_JOBID B ON A.JOBID=B.JOBID
JOIN HRSDBR53..HR_DEP C ON A.DEPID=C.DEPID
WHERE C_STA='A'
GO
/****** Object:  View [dbo].[View_HR_HolidayCombineData]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[View_HR_HolidayCombineData]
AS
SELECT     CASE WHEN b_HDATE IS NULL THEN a_HDATE ELSE b_HDATE END AS HDATE, CASE WHEN b_HOLIDAY IS NULL 
                      THEN a_HOLIDAY ELSE b_HOLIDAY END AS HOLIDAY, CASE WHEN b_REMK IS NULL THEN a_REMK ELSE b_REMK END AS REMK
FROM         (SELECT     a.HDATE AS a_HDATE, a.HOLIDAY AS a_HOLIDAY, a.REMK AS A_REMK, b.HDATE AS b_HDATE, b.HOLIDAY AS b_HOLIDAY, b.REMK AS b_REMK
                       FROM          dbo.HR_HolidaySet AS a LEFT OUTER JOIN
                                                  (SELECT     DDDAY AS HDATE, 'Y' AS HOLIDAY, CASE DatePart(WeekDay, [DDDAY]) 
                                                                           WHEN '1' THEN '星期日' WHEN '2' THEN '星期一' WHEN '3' THEN '星期二' WHEN '4' THEN '星期三' WHEN '5' THEN '星期四' WHEN '6' THEN
                                                                            '星期五' WHEN '7' THEN '星期六' END AS REMK
                                                    FROM          HRSDBR53.dbo.HR_OFFDAY) AS b ON a.HDATE = b.HDATE) AS derivedtbl_1

GO
/****** Object:  View [dbo].[VIEW_HR_NEEDSIGN_EMPLYID]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_HR_NEEDSIGN_EMPLYID]
AS
SELECT M.DOCID,D.EMPLYID FROM WF_SIGNM M
JOIN WF_SIGND D ON M.SIGNID=D.SIGNID
JOIN (SELECT SIGNID,MIN(SITEID) AS SITEID FROM WF_SIGND WHERE STATUS='SN' GROUP BY SIGNID) C ON D.SIGNID=C.SIGNID 
WHERE D.SITEID=C.SITEID
GO
/****** Object:  View [dbo].[VIEW_PB_SYSNO]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO





CREATE view [dbo].[VIEW_PB_SYSNO]
as 
SELECT *,'ERP' as SYS_TYPE
FROM [192.168.100.19].CCM_Main.dbo.SYSNO sysno

UNION
SELECT 'EIP','EIP','EIP' as SYS_TYPE
UNION
SELECT 'PDM','PDM','PDM' as SYS_TYPE




GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_DAILYSUMMARY]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_DAILYSUMMARY]
 AS 
SELECT CONVERT(CHAR(10),BookingStartTime,120) AS BookingDate,D.ObjectNM,
CASE 
	WHEN SUM(C.Mileage-C.MileageLast)<0 THEN 0 
	ELSE SUM(C.Mileage-C.MileageLast) 
END AS Mileages
FROM PO_PUBLIC_OBJECT_BOOKING C 
JOIN PO_PUBLIC_OBJECT D ON C.ObjectSID=D.SID
WHERE C.ObjectType='公務車輛' AND (C.Status='結束') AND (C.ObjectSID<>41) 
GROUP BY CONVERT(CHAR(10),BookingStartTime,120),D.ObjectNM
GO
/****** Object:  View [dbo].[VIEW_PO_PUBLIC_OBJECT_MILEAGE]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PO_PUBLIC_OBJECT_MILEAGE]
as 
SELECT A.SID,A.ObjectSID,B.ObjectNM,A.Mileage AS CurrentMileage,B.Mileage,B.MaintenanceMileage,B.MaintenanceDate,B.RemindDate FROM PO_PUBLIC_OBJECT_BOOKING A
JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID=B.SID
JOIN (
SELECT B.ObjectNM,MAX(A.Mileage) AS CurrentMileage FROM PO_PUBLIC_OBJECT_BOOKING A
JOIN PO_PUBLIC_OBJECT B ON A.ObjectSID=B.SID
WHERE A.ObjectType='公務車輛' AND A.Mileage>=B.Mileage+B.MaintenanceMileage AND (B.ObjectNM IS NULL OR B.ObjectNM='N')
GROUP BY B.ObjectNM) C ON B.ObjectNM=C.ObjectNM AND A.Mileage=C.CurrentMileage
GO
/****** Object:  View [dbo].[VIEW_PS_PublicShare_Assets]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PS_PublicShare_Assets]
AS
SELECT S.AST_NO,S.AST_NM,C.CLAS_NO,C.CLAS_NO+C.CLAS_NM AS CLAS_NM,S.UNIT,ISNULL(S.LOCATION,'') AS LOCATION,CONVERT(CHAR(10),S.GET_DT,120) AS GET_DT,
K.EMP_NO,K.DEPM_NO,D.DEPNM+'/'+U.EMPLYNM AS EMPLYNM,CONVERT(NVARCHAR(20),K.QTY)+S.UNIT AS QTY,'~\EIPContent\Content\PublicShare\Assects\'+RTRIM(S.AST_NO)+'\'+RTRIM(S.AST_NO)+'.jpg' AS PhotoUrl,
'EIPContent\Content\PublicShare\Assects\'+RTRIM(S.AST_NO)+'\' AS PhotoUrlFolder,'EIPContent\Content\PublicShare\Assects\'+RTRIM(S.AST_NO)+'\Thumb\' AS PhotoUrlThumb
FROM [192.168.100.19].CCM_Main.dbo.ASSET S
LEFT JOIN [192.168.100.19].CCM_Main.dbo.ASTTAK K ON S.AST_NO=K.AST_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.ASTCLAS C ON S.CLAS_NO=C.CLAS_NO
LEFT JOIN HRSDBR53..HR_EMPLYM U ON K.EMP_NO=U.EMPLYID COLLATE Chinese_Taiwan_Stroke_CI_AS 
LEFT JOIN HRSDBR53..HR_DEP D ON K.DEPM_NO=D.DEPID COLLATE Chinese_Taiwan_Stroke_CI_AS 
GO
/****** Object:  View [dbo].[VIEW_PS_PublicShare_Items]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_PS_PublicShare_Items]
AS
SELECT M.ITEM_NO,M.ITEM_NM,M.ITEM_SP,M.CLAS_NO,RTRIM(M.CLAS_NO)+C.CLAS_NM AS CLAS_NM,M.WAHO_NO,M.LOCA_NO,RTRIM(M.WAHO_NO)+RTRIM(W.WAHO_NM)+' '+M.LOCA_NO AS WAHO_NM,
ISNULL(CONVERT(NVARCHAR(20),CONVERT(INT,K.QTY)),'0')+' '+M.UNIT AS QTYUNIT,K.QTY,
CASE WHEN C_SOURCE='M' THEN '自製件' WHEN C_SOURCE='P' THEN '採購件' WHEN C_SOURCE='U' THEN '非存貨' ELSE C_SOURCE END AS C_SOURCE,
'EIPContent\Content\PublicShare\Items\'+RTRIM(M.ITEM_NO)+'.jpg' AS PhotoUrl,
'EIPContent\Content\PublicShare\Items\'+RTRIM(M.ITEM_NO)+'\' AS PhotoUrlFolder,'EIPContent\Content\PublicShare\Items\'+RTRIM(M.ITEM_NO)+'\Thumb\' AS PhotoUrlThumb
FROM [192.168.100.19].CCM_Main.dbo.ITEM M 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.WAHO W ON M.WAHO_NO=W.WAHO_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.ITCLAS C ON M.CLAS_NO=C.CLAS_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.ITSTKMT K ON M.ITEM_NO=K.ITEM_NO
GO
/****** Object:  View [dbo].[VIEW_PU_EMP_MAIL]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[VIEW_PU_EMP_MAIL]
as 
SELECT RTRIM(DEPM_NM)+' '+RTRIM(EMP_NM) AS EMP_NM,EMP_NO,E_MAIL FROM (
SELECT 
CASE WHEN SUBSTRING(C.DEPM_NM,1,1)='董' OR SUBSTRING(C.DEPM_NM,1,2)='總經' OR SUBSTRING(C.DEPM_NM,1,1)='稽' THEN '1'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,1)='生' OR SUBSTRING(C.DEPM_NM,1,2)='組立' OR SUBSTRING(C.DEPM_NM,1,2)='電控' OR SUBSTRING(C.DEPM_NM,1,2)='倉管' THEN 'A'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,1)='品' OR SUBSTRING(C.DEPM_NM,1,2)='成品' OR SUBSTRING(C.DEPM_NM,1,2)='進貨'THEN 'B'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,1)='管' OR SUBSTRING(C.DEPM_NM,1,1)='人' OR SUBSTRING(C.DEPM_NM,1,2)='總務' THEN 'C'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,1)='營' THEN 'D'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='國內' THEN 'DA'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='國外' THEN 'DB'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='客服' THEN 'DC'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,1)='研' THEN 'DC'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='全盈' THEN 'FA'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='北部' THEN 'FB'+C.DEPM_NM 
WHEN SUBSTRING(C.DEPM_NM,1,2)='中部' THEN 'FC'+C.DEPM_NM
WHEN SUBSTRING(C.DEPM_NM,1,1)='採' THEN 'G'+C.DEPM_NM
WHEN SUBSTRING(C.DEPM_NM,1,2)='成型' THEN 'H'+C.DEPM_NM
WHEN SUBSTRING(C.DEPM_NM,1,1)='資' THEN 'I'+C.DEPM_NM
WHEN SUBSTRING(C.DEPM_NM,1,1)='財' OR SUBSTRING(C.DEPM_NM,1,2)='會計' THEN 'J'+C.DEPM_NM
ELSE C.DEPM_NM END AS DEPM_NM,
A.EMP_NO,A.EMP_NM,RTRIM(A.EMP_NO)+'@CCM3S.COM' AS E_MAIL
FROM [192.168.100.19].CCM_Main.dbo.EMPLOYEE A 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON A.DEPM_NO=C.DEPM_NO
WHERE A.C_STA='Y' AND A.EMP_NO NOT IN ('A830902','B001203','B010505','B010701') 
) A 
GO
/****** Object:  View [dbo].[VIEW_WF_NEEDSIGN]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VIEW_WF_NEEDSIGN]
AS
SELECT A.SIGNID,A.FLOWID,M.FLOWNM,A.DOCID,A.SUBJECT,A.EMP_ID,U.EMP_NM AS EMP_NM,C.DEPM_NM,B.STATUS,A.STATUS AS SIGNMSTATUS,B.STATUS AS SIGNDSTATUS,A.SENDDATE,B.SIGNDATE,B.EMPLYID,U1.EMP_NM AS EMP_NM1,C1.DEPM_NM AS DEPM_NM1,U1.DEPM_NO AS DEPM_NO1
FROM WF_SIGNM A JOIN WF_SIGND B ON A.SIGNID=B.SIGNID 
JOIN WF_FLOWM M ON A.FLOWID=M.FLOWID
LEFT JOIN [192.168.100.19].CCM_Main.dbo.EMPNO U ON A.EMP_ID=U.EMP_NO 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON U.DEPM_NO=C.DEPM_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.EMPNO U1 ON B.EMPLYID=U1.EMP_NO 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C1 ON U1.DEPM_NO=C1.DEPM_NO
WHERE B.SITEID=1 AND 
A.SIGNID IN 
(
SELECT A.SIGNID FROM WF_SIGNM A JOIN WF_SIGND B ON A.SIGNID=B.SIGNID 
WHERE  B.SITEID=1 )
UNION 
SELECT A.SIGNID,A.FLOWID,M.FLOWNM,A.DOCID,A.SUBJECT,A.EMP_ID,U.EMP_NM AS EMP_NM,C.DEPM_NM,B.STATUS,A.STATUS AS SIGNMSTATUS,B.STATUS AS SIGNDSTATUS,A.SENDDATE,B.SIGNDATE,B.EMPLYID,U1.EMP_NM AS EMP_NM1,C1.DEPM_NM AS DEPM_NM1,U1.DEPM_NO AS DEPM_NO1 
FROM WF_SIGNM A JOIN WF_SIGND B ON A.SIGNID=B.SIGNID 
JOIN WF_FLOWM M ON A.FLOWID=M.FLOWID
LEFT JOIN [192.168.100.19].CCM_Main.dbo.EMPNO U ON A.EMP_ID=U.EMP_NO 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C ON U.DEPM_NO=C.DEPM_NO
LEFT JOIN [192.168.100.19].CCM_Main.dbo.EMPNO U1 ON B.EMPLYID=U1.EMP_NO 
LEFT JOIN [192.168.100.19].CCM_Main.dbo.DEPM C1 ON U1.DEPM_NO=C1.DEPM_NO
WHERE B.SITEID<>1 AND 
A.SIGNID IN 
(
SELECT A.SIGNID FROM WF_SIGNM A JOIN WF_SIGND B ON A.SIGNID=B.SIGNID 
WHERE  B.SITEID IN
(SELECT SITEID-1 FROM WF_SIGND ) AND B.STATUS='CF' )
GO
ALTER TABLE [dbo].[BU_ORDERS_ADJUST] ADD  CONSTRAINT [DF_BU_ORDERS_ADJUST_AdjustAmount]  DEFAULT ((0)) FOR [AdjustAmount]
GO
ALTER TABLE [dbo].[ERP_CONNECT_COUNT] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[PU_CONNECT_COUNT] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[PU_ERPSESSION] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[PU_PDMSESSION] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
/****** Object:  StoredProcedure [dbo].[DropWorkflowInbox]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DropWorkflowInbox] 
		@processId uniqueidentifier
	AS
	BEGIN
		BEGIN TRAN	
		DELETE FROM dbo.WorkflowInbox WHERE ProcessId = @processId	
		COMMIT TRAN
	END
GO
/****** Object:  StoredProcedure [dbo].[DropWorkflowProcess]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DropWorkflowProcess] 
		@id uniqueidentifier
	AS
	BEGIN
		BEGIN TRAN
	
		DELETE FROM dbo.WorkflowProcessInstance WHERE Id = @id
		DELETE FROM dbo.WorkflowProcessInstanceStatus WHERE Id = @id
		DELETE FROM dbo.WorkflowProcessInstancePersistence  WHERE ProcessId = @id
	
		COMMIT TRAN
	END
GO
/****** Object:  StoredProcedure [dbo].[DropWorkflowProcesses]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DropWorkflowProcesses] 
		@Ids  IdsTableType	READONLY
	AS	
	BEGIN
		BEGIN TRAN
	
		DELETE dbo.WorkflowProcessInstance FROM dbo.WorkflowProcessInstance wpi  INNER JOIN @Ids  ids ON wpi.Id = ids.Id 
		DELETE dbo.WorkflowProcessInstanceStatus FROM dbo.WorkflowProcessInstanceStatus wpi  INNER JOIN @Ids  ids ON wpi.Id = ids.Id 
		DELETE dbo.WorkflowProcessInstanceStatus FROM dbo.WorkflowProcessInstancePersistence wpi  INNER JOIN @Ids  ids ON wpi.ProcessId = ids.Id 
	

		COMMIT TRAN
	END
GO
/****** Object:  StoredProcedure [dbo].[ERP_Mo_ProgressCheck]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ERP_Mo_ProgressCheck] 
		@ITEM_NO nvarchar(24)
	AS
	BEGIN
		BEGIN TRAN
		--先移除
		DELETE FROM ERP_Mo_Progress WHERE ITEM_NO=@ITEM_NO
		--訂單單號
			DECLARE 
				@CO_VCH_TY as nvarchar(4),
				@CO_VCH_NO as nVarchar(9)
				
			SELECT @CO_VCH_TY=CT.VCH_TY,@CO_VCH_NO=CT.VCH_NO
			FROM [192.168.100.19].CCM_Main.dbo.COMT CT
			JOIN [192.168.100.19].CCM_Main.dbo.CODL CD ON CT.VCH_TY=CD.VCH_TY AND CT.VCH_NO=CD.VCH_NO
			WHERE CD.ITEM_NO=@ITEM_NO
--全部製令
			--宣告要使用的資料集
			DECLARE 
			@PITEM_NO as nvarchar(24),
			@PITEM_NM as nvarchar(30),
			@MO_VCH_TY as nvarchar(4),
			@MO_VCH_NO as nVarchar(9),
			@MO_C_END as nVarchar(1)--完工碼
			--宣告CURSOR
			DECLARE MOcursor CURSOR FOR
			SELECT DISTINCT T.ITEM_NO,E.ITEM_NM,T.VCH_TY,T.VCH_NO,ISNULL(T.C_END,'N') AS C_END
			FROM [192.168.100.19].CCM_Main.dbo.MOMT T 
			JOIN [192.168.100.19].CCM_Main.dbo.ITEM E ON T.ITEM_NO=E.ITEM_NO
			WHERE T.PLAN_TY=@CO_VCH_TY AND T.PLAN_NO=@CO_VCH_NO
		    --開啟CURSOR
			OPEN MOcursor
			--將SELECT的值丟入
			FETCH NEXT FROM MOcursor INTO @PITEM_NO,@PITEM_NM,@MO_VCH_TY, @MO_VCH_NO,@MO_C_END

			WHILE @@FETCH_STATUS = 0 --檢查是否有讀取到資料; WHILE用來處理迴圈，當為true時則進入迴圈執行
			--print 'true'
			BEGIN
			
					--寫入製令製程狀況
					DECLARE 
					@PRCS_PRCS_NO as nvarchar(30),
					@PRCS_SHORT_NM as nvarchar(30),
					@PRCS_PLAN_QTY as INT,
					@PRCS_IN_QTY as INT,
					@PRCS_FIN_QTY as INT,
					@PRCS_Progress as nVarchar(200),
					@PRCS_QC as nVarchar(200),
					@PRCS_REMK as nVarchar(200),
					@PRCS_Finished as nvarchar(4),
					@i AS INT,
					@Procs1 as nVarchar(200),
					@Procs2 as nVarchar(200),
					@Procs3 as nVarchar(200),
					@Procs4 as nVarchar(200),
					@Procs5 as nVarchar(200),
					@Procs6 as nVarchar(200),
					@Procs7 as nVarchar(200),
					@Procs8 as nVarchar(200),
					@Procs9 as nVarchar(200),
					@Procs10 as nVarchar(200),
					@Procs11 as nVarchar(200),
					@Procs12 as nVarchar(200)
					SET @PRCS_SHORT_NM=''
					SET @PRCS_PLAN_QTY=0
					SET @PRCS_IN_QTY=0
					SET @PRCS_FIN_QTY=0
					SET @PRCS_Finished=''
					SET @PRCS_Progress=''
					SET @PRCS_QC=''
					SET @i=1
					SET @Procs1=''
					SET @Procs2=''
					SET @Procs3=''
					SET @Procs4=''
					SET @Procs5=''
					SET @Procs6=''
					SET @Procs7=''
					SET @Procs8=''
					SET @Procs9=''
					SET @Procs10=''
					SET @Procs11=''
					SET @Procs12=''
					--宣告CURSOR
					DECLARE PRCSicur CURSOR FOR
					SELECT ISNULL(RTRIM(P.PRCS_NO)+RTRIM(S.PRCS_NM),'') AS PRCS_NO,ISNULL(V.SHORT_NM,'') AS SHORT_NM,
						P.PLAN_QTY,P.IN_QTY,P.FIN_QTY,P.REMK
						FROM [192.168.100.19].CCM_Main.dbo.MOPRCS P 
						LEFT JOIN [192.168.100.19].CCM_Main.dbo.VENDOR V ON P.VD_NO=V.VD_NO
						JOIN [192.168.100.19].CCM_Main.dbo.PRCS S ON P.PRCS_NO=S.PRCS_NO
						WHERE P.VCH_TY=@MO_VCH_TY AND P.VCH_NO=@MO_VCH_NO ORDER BY P.RT_SR
					--開啟CURSOR
					OPEN PRCSicur
					--將SELECT的值丟入
					FETCH NEXT FROM PRCSicur INTO @PRCS_PRCS_NO,@PRCS_SHORT_NM,@PRCS_PLAN_QTY, @PRCS_IN_QTY,@PRCS_FIN_QTY,@PRCS_REMK

					WHILE @@FETCH_STATUS = 0 --檢查是否有讀取到資料; WHILE用來處理迴圈，當為true時則進入迴圈執行
					--print 'true'
					BEGIN
					
					
					
					--判斷製程完工
					IF @PRCS_PLAN_QTY=@PRCS_FIN_QTY
						SET @PRCS_Finished='(完工)'
					ELSE IF @PRCS_IN_QTY<>0
						BEGIN
							SET @PRCS_Finished='(派工)'
							--判斷驗退

							SELECT DISTINCT @PRCS_QC=RTRIM(R.SHORT_NM)+'驗退'+CONVERT(NVARCHAR(5),CONVERT(INT,M.RJ_QTY)) FROM [192.168.100.19].CCM_Main.dbo.INSPMT M
								JOIN [192.168.100.19].CCM_Main.dbo.SBCRCV V ON M.SVCH_TY=V.VCH_TY AND M.SVCH_NO=V.VCH_NO
								LEFT JOIN [192.168.100.19].CCM_Main.dbo.VENDOR R ON V.VD_NO=R.VD_NO
								WHERE V.MO_TY=@MO_VCH_TY AND V.MO_NO=@MO_VCH_NO AND M.RJ_QTY<>0 AND R.SHORT_NM=@PRCS_SHORT_NM
							
							--判斷最新進度到哪一家廠商
							SET @PRCS_Progress=@PRCS_SHORT_NM
						END	
					ELSE IF @PRCS_IN_QTY=0
						SET @PRCS_Finished='(未投)'
					
					--製程
					 IF @i=1 
						SET @Procs1=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=2 
						SET @Procs2=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=3 
						SET @Procs3=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=4 
						SET @Procs4=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=5 
						SET @Procs5=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM	 
					 ELSE IF @i=6 
						SET @Procs6=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=7 
						SET @Procs7=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=8 
						SET @Procs8=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM
					 ELSE IF @i=9 
						SET @Procs9=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM		
					 ELSE IF @i=10 
						SET @Procs10=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM	
					 ELSE IF @i=11 
						SET @Procs11=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM	
					 ELSE IF @i=12 
						SET @Procs12=@PRCS_Finished+@PRCS_PRCS_NO+'/'+@PRCS_SHORT_NM			
								
						 FETCH NEXT FROM PRCSicur INTO @PRCS_PRCS_NO,@PRCS_SHORT_NM,@PRCS_PLAN_QTY, @PRCS_IN_QTY,@PRCS_FIN_QTY,@PRCS_REMK 
						 SET @i=@i+1
					END
					
					CLOSE PRCSicur
					DEALLOCATE PRCSicur
			
			--IF @PITEM_NO='6BD174-0002' PRINT @Procs1
			
			
					INSERT INTO ERP_Mo_Progress(ITEM_NO,PITEM_NO,PITEM_NM,MO_NO,DoQty,OKQty,QC,Progress,Procs1,Procs2,Procs3,Procs4,Procs5,Procs6,Procs7,Procs8,Procs9,Procs10,Procs11,Procs12,Finished) 
						VALUES(@ITEM_NO,@PITEM_NO,@PITEM_NM,@MO_VCH_TY+'-'+@MO_VCH_NO,@PRCS_PLAN_QTY,@PRCS_FIN_QTY,@PRCS_QC,@PRCS_Progress,@Procs1,@Procs2,@Procs3,@Procs4,@Procs5,@Procs6,@Procs7,@Procs8,@Procs9,@Procs10,@Procs11,@Procs12,@MO_C_END)
						
				 FETCH NEXT FROM MOcursor INTO @PITEM_NO,@PITEM_NM,@MO_VCH_TY, @MO_VCH_NO,@MO_C_END--將下一筆資料填入變數
			END
			
--全部採購	
			DECLARE 
			@POITEM_NO as nvarchar(24),
			@POITEM_NM as nvarchar(30),
			@PO_VCH_TY as nvarchar(4),
			@PO_VCH_NO as nVarchar(9),
			@PO_QTY as int,
			@PO_RCV_QTY as int,
			@PO_C_CLS as nVarchar(1)
			--宣告CURSOR
			DECLARE POcursor CURSOR FOR
		
			SELECT D.ITEM_NO,D.ITEM_NM,D.PO_TY,D.PO_NO,ISNULL(PD.QTY,0) AS QTY,ISNULL(PD.RCV_QTY,0) AS RCV_QTY,ISNULL(PD.C_CLS,'N') AS C_CLS
				FROM [192.168.100.19].CCM_Main.dbo.RQTDL D
				LEFT JOIN [192.168.100.19].CCM_Main.dbo.PODL PD ON D.PO_TY=PD.VCH_TY AND D.PO_NO=PD.VCH_NO AND D.PO_SR=PD.VCH_SR 
				WHERE D.PLAN_TY=@CO_VCH_TY AND D.PLAN_NO=@CO_VCH_NO
			--開啟CURSOR
			OPEN POcursor

			--將SELECT的值丟入
			FETCH NEXT FROM POcursor INTO @POITEM_NO,@POITEM_NM,@PO_VCH_TY, @PO_VCH_NO,@PO_QTY,@PO_RCV_QTY,@PO_C_CLS

			WHILE @@FETCH_STATUS = 0 --檢查是否有讀取到資料; WHILE用來處理迴圈，當為true時則進入迴圈執行

			--print 'true'

			BEGIN

					
					INSERT INTO ERP_Mo_Progress(ITEM_NO,PITEM_NO,PITEM_NM,MO_NO,DoQty,OKQty,QC,Progress,Procs1,Procs2,Procs3,Procs4,Procs5,Procs6,Procs7,Procs8,Procs9,Procs10,Procs11,Procs12,Finished) 
					VALUES(@ITEM_NO,@POITEM_NO,@POITEM_NM,@PO_VCH_TY+'-'+@PO_VCH_NO,@PO_QTY,@PO_RCV_QTY,'','','','','','','','','','','','','','',@PO_C_CLS)
				 FETCH NEXT FROM POcursor INTO @POITEM_NO,@POITEM_NM,@PO_VCH_TY, @PO_VCH_NO,@PO_QTY,@PO_RCV_QTY,@PO_C_CLS--將下一筆資料填入變數

			END
			

			--關閉CURSOR
			CLOSE MOcursor
			DEALLOCATE MOcursor
			
			CLOSE POcursor
			DEALLOCATE POcursor
		COMMIT TRAN
	END
GO
/****** Object:  StoredProcedure [dbo].[GetOrderReport]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  create procedure [dbo].[GetOrderReport]
  (
      @FromDate datetime,
      @ToDate datetime
  )
  as
  SELECT 
      [ObjectType]
      ,[UseReason]
      ,[Subject]
      ,[Description]
      ,[EmployeeID]
      ,[BookingStartTime]
      ,[BookingEndTime]
      ,[Status]
  FROM [EIP01].[dbo].[PO_PUBLIC_OBJECT_BOOKING] where BookingStartTime between @FromDate and @ToDate
GO
/****** Object:  StoredProcedure [dbo].[SearchAllTables1]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[SearchAllTables1]
(
    @SearchStr nvarchar(100)
)
AS
BEGIN

    CREATE TABLE #Results (ColumnName nvarchar(370), ColumnValue nvarchar(3630))

    SET NOCOUNT ON

    DECLARE @TableName nvarchar(256), @ColumnName nvarchar(128), @SearchStr2 nvarchar(110)
    SET  @TableName = ''
    SET @SearchStr2 = QUOTENAME('%' + @SearchStr + '%','''')

    WHILE @TableName IS NOT NULL

    BEGIN
        SET @ColumnName = ''
        SET @TableName = 
        (
            SELECT MIN(QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME))
            FROM     INFORMATION_SCHEMA.TABLES
            WHERE         TABLE_TYPE = 'BASE TABLE'
                AND    QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME) > @TableName
                AND    OBJECTPROPERTY(
                        OBJECT_ID(
                            QUOTENAME(TABLE_SCHEMA) + '.' + QUOTENAME(TABLE_NAME)
                             ), 'IsMSShipped'
                               ) = 0
        )

        WHILE (@TableName IS NOT NULL) AND (@ColumnName IS NOT NULL)

        BEGIN
            SET @ColumnName =
            (
                SELECT MIN(QUOTENAME(COLUMN_NAME))
                FROM     INFORMATION_SCHEMA.COLUMNS
                WHERE         TABLE_SCHEMA    = PARSENAME(@TableName, 2)
                    AND    TABLE_NAME    = PARSENAME(@TableName, 1)
                    AND    DATA_TYPE IN ('char', 'varchar', 'nchar', 'nvarchar', 'int', 'decimal')
                    AND    QUOTENAME(COLUMN_NAME) > @ColumnName
            )

            IF @ColumnName IS NOT NULL

            BEGIN
                INSERT INTO #Results
                EXEC
                (
                    'SELECT ''' + @TableName + '.' + @ColumnName + ''', LEFT(' + @ColumnName + ', 3630) 
                    FROM ' + @TableName + ' (NOLOCK) ' +
                    ' WHERE ' + @ColumnName + ' LIKE ' + @SearchStr2
                )
            END
        END    
    END

    SELECT ColumnName, ColumnValue FROM #Results
END
GO
/****** Object:  StoredProcedure [dbo].[SP_RECORD_ERPCONNECT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECORD_ERPCONNECT] 
		
	AS
	BEGIN
  DECLARE 
  @V_ONLINE_CNT INT,
  @V_ACCOUNT_CNT INT,
  @V_COMPANY VARCHAR(50)='CCM3S',
  @V_SYS_NAME VARCHAR(50)='ERP',
  @V_MINUTE INT
 
 SELECT @V_MINUTE = DATEPART(MI, GETDATE())
 
 IF (@V_MINUTE IN (0,10,20,30,40,50))
 BEGIN
  --連結數-TW
 SELECT @V_ACCOUNT_CNT = COUNT(*) 
 FROM (
    SELECT session_id, dbid, [host_name],REPLACE(program_name,'MSTMIS\','') as program_name,
           EIP01.dbo.SF_GETEMPNAME(REPLACE(program_name,'MSTMIS\','')) as emp_nm, client_net_address, login_name,db_name
     FROM [192.168.100.19].master.dbo.V_CONN_SESSION
    
 ) C

  BEGIN TRAN
   INSERT INTO PU_CONNECT_COUNT(COMPANY, SYS_NAME, ACCOUNT_CNT) VALUES(@V_COMPANY,@V_SYS_NAME,@V_ACCOUNT_CNT)
  COMMIT TRAN
  
   --連結數-OTHER
 SELECT @V_ACCOUNT_CNT = COUNT(*) 
 FROM (
    SELECT session_id, dbid, [host_name],REPLACE(program_name,'MSTMIS\','') as program_name,
           EIP01.dbo.SF_GETEMPNAME(REPLACE(program_name,'MSTMIS\','')) as emp_nm, client_net_address, login_name,db_name
     FROM [192.168.100.18].master.dbo.V_CONN_SESSION
    
 ) C

  BEGIN TRAN
   INSERT INTO PU_CONNECT_COUNT(COMPANY, SYS_NAME, ACCOUNT_CNT) VALUES('OTHER',@V_SYS_NAME,@V_ACCOUNT_CNT)
  COMMIT TRAN
  
   BEGIN TRAN
    INSERT INTO EIP01.dbo.PU_ERPSESSION(session_id, dbid, host_name, program_name, emp_nm, client_net_address, login_name, db_name)
    SELECT session_id, dbid, [host_name],REPLACE(program_name,'MSTMIS\','') as program_name,
           EIP01.dbo.SF_GETEMPNAME(REPLACE(program_name,'MSTMIS\','')) as emp_nm, client_net_address, login_name,db_name
     FROM [192.168.100.19].master.dbo.V_CONN_SESSION
     UNION
     SELECT session_id, dbid, [host_name],REPLACE(program_name,'MSTMIS\','') as program_name,
           EIP01.dbo.SF_GETEMPNAME(REPLACE(program_name,'MSTMIS\','')) as emp_nm, client_net_address, login_name,db_name
     FROM [192.168.100.18].master.dbo.V_CONN_SESSION
  COMMIT TRAN
 
  END --IF END
  
	END
GO
/****** Object:  StoredProcedure [dbo].[SP_RECORD_PDMCONNECT]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RECORD_PDMCONNECT]
WITH EXEC AS CALLER
AS
BEGIN
  DECLARE 
  @V_ONLINE_CNT INT,
  @V_ACCOUNT_CNT INT,
  @V_COMPANY VARCHAR(50)='CCM3S',
  @V_SYS_NAME VARCHAR(50)='PDM',
  @V_MINUTE INT
  
  SELECT @V_MINUTE = DATEPART(MI, GETDATE())
  
 IF (@V_MINUTE IN (0,10,20,30,40,50))
 BEGIN
  --線上人數
  SELECT @V_ONLINE_CNT = COUNT(*) 
  FROM (
    SELECT CONNECT_TIME, CONNECT_PC, CONNECT_CLASS, CONNECT_USER, B.USERNAME ,
          CONNECT_IP, CONNECT_CLIENTNAME, CONNECT_SESSIONNAME, CONNECT_APPNAME
     FROM [192.168.100.19].VPDM.dbo.PDM_APPCONNECT AS A 
     LEFT OUTER JOIN [192.168.100.19].VPDM.dbo.PDM_LOGONACCOUNT AS B 
     ON A.CONNECT_USER = B.USERID
  ) C

   --連結數
  SELECT @V_ACCOUNT_CNT = COUNT(*) 
  FROM (
  SELECT DISTINCT CONNECT_PC, CONNECT_CLASS, CONNECT_USER, B.USERNAME ,
         CONNECT_IP,  CONNECT_SESSIONNAME, CONNECT_APPNAME
   FROM [192.168.100.19].VPDM.dbo.PDM_APPCONNECT AS A 
   LEFT OUTER JOIN [192.168.100.19].VPDM.dbo.PDM_LOGONACCOUNT AS B 
   ON A.CONNECT_USER = B.USERID
   WHERE A.CONNECT_APPNAME LIKE 'Visual PDM'
  ) C

  BEGIN TRAN
   INSERT INTO PU_CONNECT_COUNT(COMPANY, SYS_NAME,ON_LINE_CNT, ACCOUNT_CNT) VALUES(@V_COMPANY,@V_SYS_NAME,@V_ONLINE_CNT,@V_ACCOUNT_CNT)
 
  COMMIT TRAN
  
  BEGIN TRAN
    INSERT INTO EIP01.dbo.PU_PDMSESSION(CONNECT_PC, CONNECT_CLASS, CONNECT_USER, USERNAME, CONNECT_IP, CONNECT_CLIENTNAME, CONNECT_SESSIONNAME, CONNECT_APPNAME)
    SELECT CONNECT_PC, CONNECT_CLASS, CONNECT_USER, B.USERNAME ,
          CONNECT_IP, CONNECT_CLIENTNAME, CONNECT_SESSIONNAME, CONNECT_APPNAME
     FROM [192.168.100.19].VPDM.dbo.PDM_APPCONNECT AS A 
     LEFT OUTER JOIN [192.168.100.19].VPDM.dbo.PDM_LOGONACCOUNT AS B 
     ON A.CONNECT_USER = B.USERID;
  COMMIT TRAN
  
  END -- IF END
END
GO
/****** Object:  StoredProcedure [dbo].[spWorkflowProcessResetRunningStatus]    Script Date: 2016/11/18 上午 10:08:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[spWorkflowProcessResetRunningStatus]
	AS
	BEGIN
		UPDATE [WorkflowProcessInstanceStatus] SET [WorkflowProcessInstanceStatus].[Status] = 2 WHERE [WorkflowProcessInstanceStatus].[Status] = 1
	END
GO
EXEC sys.sp_addextendedproperty @name=N'V_ITEM_NO', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'FUNCTION',@level1name=N'SF_GETDEPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'OVTM_DailyNoticeTime:寄發郵件通知時間(時)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BE_HR', @level2type=N'COLUMN',@level2name=N'Ref_NM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'留言內容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'Content'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'新增時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'CreateTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回覆內容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'Reply'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回覆時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'BU_GUESTBOOK', @level2type=N'COLUMN',@level2name=N'ReplyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "HR_TICKET (HRSDBR53.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 294
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1680
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HR_TICKET'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'HR_TICKET'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_EMPLYEE_ALL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_EMPLYEE_ALL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "HR_EXTERAL (HRSDBR53.dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GUARDLIST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'V_GUARDLIST'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 446
               Bottom = 95
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 650
               Bottom = 125
               Right = 816
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_ORDERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_ORDERS'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 246
               Bottom = 125
               Right = 412
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 450
               Bottom = 95
               Right = 616
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 654
               Bottom = 125
               Right = 824
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 862
               Bottom = 125
               Right = 1028
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 72' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_ORDERS_DETAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'0
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_ORDERS_DETAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_ORDERS_DETAIL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 446
               Bottom = 125
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY_REPORT01'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY_REPORT01'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY_REPORT02'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_BU_VOTE_REPLY_REPORT02'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_ALLUSERS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_ALLUSERS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_DEPM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_DEPM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_EMPLOYEE_DATA1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_EMPLOYEE_DATA1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 242
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D1"
            Begin Extent = 
               Top = 6
               Left = 446
               Bottom = 125
               Right = 612
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "J"
            Begin Extent = 
               Top = 6
               Left = 650
               Bottom = 125
               Right = 816
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "E"
            Begin Extent = 
               Top = 6
               Left = 854
               Bottom = 110
               Right = 1020
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_Employee_Resign1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_Employee_Resign1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_USERS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_CCM_Main_USERS1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "M"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 195
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 6
               Left = 233
               Bottom = 125
               Right = 399
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_employee'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "derivedtbl_1"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HR_HolidayCombineData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_HR_HolidayCombineData'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 125
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 452
               Bottom = 125
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 110
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 114
               Left = 248
               Bottom = 233
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP_TODAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_ATTEND_EMP_TODAY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 224
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 262
               Bottom = 125
               Right = 434
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 204
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 10
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_CAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_CAR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "C"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 110
               Right = 414
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "D"
            Begin Extent = 
               Top = 234
               Left = 242
               Bottom = 353
               Right = 428
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B"
            Begin Extent = 
               Top = 6
               Left = 452
               Bottom = 125
               Right = 618
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "B1"
            Begin Extent = 
               Top = 6
               Left = 656
               Bottom = 125
               Right = 822
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_PO_PUBLIC_OBJECT_BOOKING_RPT_CARDAILY_TEMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "X"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 11
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3720
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_USR_DETECTERR_OVRTM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_USR_DETECTERR_OVRTM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_WF_NEEDSIGN1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VIEW_WF_NEEDSIGN1'
GO
USE [master]
GO
ALTER DATABASE [EIP01] SET  READ_WRITE 
GO
