USE [master]
GO
/****** Object:  Database [EIP]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE DATABASE [EIP] ON  PRIMARY 
( NAME = N'EIP', FILENAME = N'D:\DBDATA\EIP.mdf' , SIZE = 54528KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'EIP_log', FILENAME = N'D:\DBDATA\EIP_log.LDF' , SIZE = 167616KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [EIP] SET COMPATIBILITY_LEVEL = 90
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EIP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EIP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EIP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EIP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EIP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EIP] SET ARITHABORT OFF 
GO
ALTER DATABASE [EIP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EIP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EIP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EIP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EIP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EIP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EIP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EIP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EIP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EIP] SET  ENABLE_BROKER 
GO
ALTER DATABASE [EIP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EIP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EIP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EIP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EIP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EIP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EIP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EIP] SET RECOVERY FULL 
GO
ALTER DATABASE [EIP] SET  MULTI_USER 
GO
ALTER DATABASE [EIP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EIP] SET DB_CHAINING OFF 
GO
USE [EIP]
GO
/****** Object:  UserDefinedFunction [dbo].[SF_EMP_NAME]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[SF_EMP_NAME] (@V_EMPLYID NVARCHAR(20))
RETURNS NVARCHAR(500)
WITH EXEC AS CALLER
AS
/****************************************************************************************
'程式代號：dbo.SP_EMP_NAME 
'程式名稱：取得員工姓名
'目　　的：
'參數說明：
(
@V_EMPLYID varchar(12)='' --員工編號
)    
'範　例　：
    EXEC SP_EMP_NAME 'B050501'
****************************************************************************************/
BEGIN
DECLARE
 @V_EMPLYNM nvarchar(500)=''
 
  SELECT @V_EMPLYNM = EMPLYNM
   FROM EIP.dbo.V_EMP_ALLORG
   WHERE EMPLYID = @V_EMPLYID


  RETURN @V_EMPLYNM
END
GO
/****** Object:  Table [dbo].[__MigrationHistory]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[__MigrationHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ContextKey] [nvarchar](300) NOT NULL,
	[Model] [varbinary](max) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC,
	[ContextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[aa]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[aa](
	[aa] [nchar](10) NULL,
	[bb] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Account]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[AccountName] [varchar](50) NULL,
	[Password] [varchar](50) NULL,
	[LoginIP] [varchar](50) NULL,
	[LoginDate] [datetime] NULL,
	[IsUsed] [bit] NULL,
 CONSTRAINT [PK__Account__3213E83F060DEAE8] PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[ActionLog]    Script Date: 2016/11/18 上午 08:53:10 ******/
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
/****** Object:  Table [dbo].[AspNetRoles]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetRoles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserClaims]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserLogins]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUserRoles]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL,
 CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[AspNetUsers]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL,
	[FullName] [nvarchar](max) NULL,
 CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bb]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bb](
	[aa] [nchar](10) NULL,
	[bb] [nchar](10) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[FR_OFFIDOC_ISSUE]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[F_Id] [nvarchar](50) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
	[F_DeleteMark] [bit] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[FR_OFFIDOC_ISSUE_ATTACH_FILE]    Script Date: 2016/11/18 上午 08:53:10 ******/
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
	[UploadPath] [nvarchar](500) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MIS_IP_ADDRESS]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MIS_IP_ADDRESS](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IP_ADDR] [varchar](50) NULL,
	[MAC_ADDR] [varchar](50) NULL,
	[DEPT] [nvarchar](50) NULL,
	[USER] [nchar](50) NULL,
	[DEVICE] [varchar](50) NULL,
	[OS] [varchar](50) NULL,
	[GROUP] [varchar](50) NULL,
	[ANTIVIRUS] [nvarchar](50) NULL,
	[REMARK] [nvarchar](max) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
	[EXC_COMPANY] [nvarchar](10) NULL,
 CONSTRAINT [PK__MIS_IPADDR__3214186C7CF981FA] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY],
 CONSTRAINT [U_dbo_MIS_IPADDR_1] UNIQUE NONCLUSTERED 
(
	[IP_ADDR] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RD_DWG_EXMANAGE_MT]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RD_DWG_EXMANAGE_MT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ORD_NO] [varchar](50) NULL,
	[ORD_DATE] [datetime] NULL,
	[PROD_NO] [varchar](50) NULL,
	[PROD_NAME] [nvarchar](100) NULL,
	[EXPORT_DATE] [datetime] NULL,
	[EXPORT_QTY] [int] NULL,
	[TO_DEPT] [nvarchar](100) NULL,
	[TO_EMP] [nvarchar](100) NULL,
	[FM_DEPT] [nvarchar](100) NULL,
	[FM_EMP] [nvarchar](100) NULL,
	[REMARK] [nvarchar](max) NULL,
	[STATUS] [varchar](1) NULL,
	[ORGANIZATION] [varchar](10) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__RD_DWG_E__3214EC276319B466] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RD_TECH_BULLETIN_DL]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RD_TECH_BULLETIN_DL](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[FILE_TYPE] [varchar](20) NULL,
	[FILE_SIZE] [int] NULL,
	[FILE_PATH] [varchar](200) NULL,
	[FILE_DESCRIPT] [nvarchar](100) NULL,
	[FK_ID] [bigint] NOT NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__RD_TECH___3214EC2748CFD27E] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RD_TECH_BULLETIN_DL1]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RD_TECH_BULLETIN_DL1](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[EMP_NO] [varchar](10) NULL,
	[REPLY] [nvarchar](max) NULL,
	[FK_ID] [bigint] NOT NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__RD_TECH___3214EC275629CD9C] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[RD_TECH_BULLETIN_MT]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RD_TECH_BULLETIN_MT](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[ORD_NO] [varchar](20) NULL,
	[ORD_DATE] [smalldatetime] NULL,
	[EMP_NO] [varchar](10) NULL,
	[TITLE] [nvarchar](100) NULL,
	[DESCRIPT] [nvarchar](500) NULL,
	[RELATE_DEPT] [nvarchar](50) NULL,
	[STATUS] [varchar](1) NULL,
	[ORGANIZATION] [varchar](10) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__RD_TECH___3214EC273E52440B] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SRV_ALBUMS]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SRV_ALBUMS](
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
 CONSTRAINT [PK_SRV_ALBUMS] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_ACTIONLOG]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_ACTIONLOG](
	[LogId] [bigint] IDENTITY(0,1) NOT NULL,
	[Operator] [varchar](10) NOT NULL,
	[Refer] [varchar](300) NULL,
	[Destination] [varchar](300) NOT NULL,
	[Method] [varchar](5) NULL,
	[MobleDevices] [bit] NOT NULL,
	[Browser] [varchar](50) NULL,
	[IPAddress] [varchar](40) NULL,
	[RequestTime] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_SS_ACTIONLOG_1] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_CONNECT_COUNT]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SS_CONNECT_COUNT](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[COMPANY] [nvarchar](100) NULL,
	[SYS_NAME] [nvarchar](50) NULL,
	[CREATE_DATE] [datetime] NOT NULL,
	[ON_LINE_CNT] [int] NULL,
	[ACCOUNT_CNT] [int] NULL,
 CONSTRAINT [PK_SS_CONNECT_COUNT] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SS_ERPSESSION]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_ERPSESSION](
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
 CONSTRAINT [PK_SS_ERPSESSION] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_FMCODE]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SS_FMCODE](
	[FMID] [bigint] IDENTITY(1,1) NOT NULL,
	[FMNM] [nvarchar](40) NULL,
	[FMPRX] [nvarchar](2) NULL,
	[CHKDP] [nvarchar](1) NULL,
	[FMFMT] [nvarchar](1) NULL,
	[FMLEN] [numeric](38, 0) NULL,
	[TAX] [nvarchar](1) NULL,
	[APRVCOL] [nvarchar](254) NULL,
	[TBLNM] [nvarchar](40) NULL,
	[FLDNM] [nvarchar](40) NULL,
	[DPFLD] [nvarchar](40) NULL,
	[FMFLD] [nvarchar](40) NULL,
	[FMSRC] [nvarchar](1) NULL,
	[FMYR] [nvarchar](4) NULL,
	[CURNO] [nvarchar](15) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__SS_FMCOD__9F213C477A672E12] PRIMARY KEY CLUSTERED 
(
	[FMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SS_PARAMETER]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_PARAMETER](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TYPE] [varchar](50) NULL,
	[PARAM] [nvarchar](50) NULL,
	[DESCRIPT] [nvarchar](100) NULL,
	[STATUS] [varchar](1) NULL,
	[SEQ] [int] NULL,
	[ORGANIZATION] [varchar](10) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
	[EXC_COMPANY] [nvarchar](10) NULL,
 CONSTRAINT [PK__SS_PARAM__3214EC27251C81ED] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_PDMSESSION]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_PDMSESSION](
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
 CONSTRAINT [PK_SS_PDMSESSION] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_PROGRAM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_PROGRAM](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PROJECT] [varchar](50) NULL,
	[AREA] [varchar](50) NULL,
	[CONTROL] [varchar](50) NULL,
	[VIEW] [varchar](50) NULL,
	[MODEL] [varchar](100) NULL,
	[DESCRIPT] [nvarchar](500) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
 CONSTRAINT [PK__SS_PROGR__3214EC270A338187] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SS_SEQ_NO]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SS_SEQ_NO](
	[ID] [bigint] IDENTITY(1,1) NOT NULL,
	[NAME] [nvarchar](40) NULL,
	[TYPE] [varchar](12) NULL,
	[PREFIX] [varchar](20) NULL,
	[CODEFORMAT] [varchar](20) NULL,
	[NO_LENGTH] [int] NULL,
	[CURRENT_NO] [int] NULL,
	[CURRENT_ORDNO] [varchar](20) NULL,
	[CURRENT_YM] [varchar](20) NULL,
	[STATUS] [varchar](1) NULL,
	[ORGANIZATION] [varchar](10) NULL,
	[EXC_INSDBID] [nvarchar](13) NULL,
	[EXC_INSDATE] [smalldatetime] NULL,
	[EXC_UPDDBID] [nvarchar](13) NULL,
	[EXC_UPDDATE] [smalldatetime] NULL,
	[EXC_SYSOWNR] [nvarchar](5) NULL,
	[EXC_ISLOCKED] [nvarchar](1) NULL,
	[EXC_COMPANY] [nvarchar](10) NULL,
 CONSTRAINT [PK__SS_SEQ_N__3214EC270D0FEE32] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Area]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Area](
	[F_Id] [varchar](50) NOT NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_Layers] [int] NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_SimpleSpelling] [varchar](50) NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_AREA] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_DbBackup]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_DbBackup](
	[F_Id] [varchar](50) NOT NULL,
	[F_BackupType] [varchar](50) NULL,
	[F_DbName] [varchar](50) NULL,
	[F_FileName] [varchar](50) NULL,
	[F_FileSize] [varchar](50) NULL,
	[F_FilePath] [varchar](500) NULL,
	[F_BackupTime] [datetime] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_DBBACKUP] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_FilterIP]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_FilterIP](
	[F_Id] [varchar](50) NOT NULL,
	[F_Type] [bit] NULL,
	[F_StartIP] [varchar](50) NULL,
	[F_EndIP] [varchar](50) NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_FILTERIP] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Items]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Items](
	[F_Id] [varchar](50) NOT NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_IsTree] [bit] NULL,
	[F_Layers] [int] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_ITEMS] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_ItemsDetail]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_ItemsDetail](
	[F_Id] [varchar](50) NOT NULL,
	[F_ItemId] [varchar](50) NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_ItemCode] [varchar](50) NULL,
	[F_ItemName] [varchar](50) NULL,
	[F_SimpleSpelling] [varchar](500) NULL,
	[F_IsDefault] [bit] NULL,
	[F_Layers] [int] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_ITEMDETAIL] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Log]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Log](
	[F_Id] [varchar](50) NOT NULL,
	[F_Date] [datetime] NULL,
	[F_Account] [varchar](50) NULL,
	[F_NickName] [nvarchar](50) NULL,
	[F_Type] [varchar](50) NULL,
	[F_IPAddress] [varchar](50) NULL,
	[F_IPAddressName] [nvarchar](50) NULL,
	[F_ModuleId] [varchar](50) NULL,
	[F_ModuleName] [nvarchar](50) NULL,
	[F_Result] [bit] NULL,
	[F_Description] [nvarchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_LOG] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Module]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Module](
	[F_Id] [varchar](50) NOT NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_Layers] [int] NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_Icon] [varchar](50) NULL,
	[F_UrlAddress] [varchar](500) NULL,
	[F_Target] [varchar](50) NULL,
	[F_IsMenu] [bit] NULL,
	[F_IsExpand] [bit] NULL,
	[F_IsPublic] [bit] NULL,
	[F_AllowEdit] [bit] NULL,
	[F_AllowDelete] [bit] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_MODULE] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_ModuleButton]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_ModuleButton](
	[F_Id] [varchar](50) NOT NULL,
	[F_ModuleId] [varchar](50) NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_Layers] [int] NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_Icon] [varchar](50) NULL,
	[F_Location] [int] NULL,
	[F_JsEvent] [varchar](50) NULL,
	[F_UrlAddress] [varchar](500) NULL,
	[F_Split] [bit] NULL,
	[F_IsPublic] [bit] NULL,
	[F_AllowEdit] [bit] NULL,
	[F_AllowDelete] [bit] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_MODULEBUTTON] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_ModuleForm]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_ModuleForm](
	[F_Id] [varchar](50) NOT NULL,
	[F_ModuleId] [varchar](50) NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_FormJson] [varchar](max) NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_MODULEFORM] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_ModuleFormInstance]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_ModuleFormInstance](
	[F_Id] [varchar](50) NOT NULL,
	[F_FormId] [varchar](50) NOT NULL,
	[F_ObjectId] [varchar](50) NULL,
	[F_InstanceJson] [varchar](max) NULL,
	[F_SortCode] [int] NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_MODULEFORMINSTANCE] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Organize]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Organize](
	[F_Id] [varchar](50) NOT NULL,
	[F_ParentId] [varchar](50) NULL,
	[F_Layers] [int] NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_ShortName] [varchar](50) NULL,
	[F_CategoryId] [varchar](50) NULL,
	[F_ManagerId] [varchar](50) NULL,
	[F_TelePhone] [varchar](20) NULL,
	[F_MobilePhone] [varchar](20) NULL,
	[F_WeChat] [varchar](50) NULL,
	[F_Fax] [varchar](20) NULL,
	[F_Email] [varchar](50) NULL,
	[F_AreaId] [varchar](50) NULL,
	[F_Address] [varchar](500) NULL,
	[F_AllowEdit] [bit] NULL,
	[F_AllowDelete] [bit] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_ORGANIZE] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_Role]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_Role](
	[F_Id] [varchar](50) NOT NULL,
	[F_OrganizeId] [varchar](50) NULL,
	[F_Category] [int] NULL,
	[F_EnCode] [varchar](50) NULL,
	[F_FullName] [varchar](50) NULL,
	[F_Type] [varchar](50) NULL,
	[F_AllowEdit] [bit] NULL,
	[F_AllowDelete] [bit] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_ROLE] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_RoleAuthorize]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_RoleAuthorize](
	[F_Id] [varchar](50) NOT NULL,
	[F_ItemType] [int] NULL,
	[F_ItemId] [varchar](50) NULL,
	[F_ObjectType] [int] NULL,
	[F_ObjectId] [varchar](50) NULL,
	[F_SortCode] [int] NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_ROLEAUTHORIZE] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_User]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_User](
	[F_Id] [varchar](50) NOT NULL,
	[F_Account] [varchar](50) NULL,
	[F_RealName] [varchar](50) NULL,
	[F_NickName] [varchar](50) NULL,
	[F_HeadIcon] [varchar](50) NULL,
	[F_Gender] [bit] NULL,
	[F_Birthday] [datetime] NULL,
	[F_MobilePhone] [varchar](20) NULL,
	[F_Email] [varchar](50) NULL,
	[F_WeChat] [varchar](50) NULL,
	[F_ManagerId] [varchar](50) NULL,
	[F_SecurityLevel] [int] NULL,
	[F_Signature] [varchar](500) NULL,
	[F_OrganizeId] [varchar](50) NULL,
	[F_DepartmentId] [varchar](500) NULL,
	[F_RoleId] [varchar](500) NULL,
	[F_DutyId] [varchar](500) NULL,
	[F_IsAdministrator] [bit] NULL,
	[F_SortCode] [int] NULL,
	[F_DeleteMark] [bit] NULL,
	[F_EnabledMark] [bit] NULL,
	[F_Description] [varchar](500) NULL,
	[F_CreatorTime] [datetime] NULL,
	[F_CreatorUserId] [varchar](50) NULL,
	[F_LastModifyTime] [datetime] NULL,
	[F_LastModifyUserId] [varchar](50) NULL,
	[F_DeleteTime] [datetime] NULL,
	[F_DeleteUserId] [varchar](500) NULL,
 CONSTRAINT [PK_SYS_USER] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Sys_UserLogOn]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Sys_UserLogOn](
	[F_Id] [varchar](50) NOT NULL,
	[F_UserId] [varchar](50) NULL,
	[F_UserPassword] [varchar](50) NULL,
	[F_UserSecretkey] [varchar](50) NULL,
	[F_AllowStartTime] [datetime] NULL,
	[F_AllowEndTime] [datetime] NULL,
	[F_LockStartDate] [datetime] NULL,
	[F_LockEndDate] [datetime] NULL,
	[F_FirstVisitTime] [datetime] NULL,
	[F_PreviousVisitTime] [datetime] NULL,
	[F_LastVisitTime] [datetime] NULL,
	[F_ChangePasswordDate] [datetime] NULL,
	[F_MultiUserLogin] [bit] NULL,
	[F_LogOnCount] [int] NULL,
	[F_UserOnLine] [bit] NULL,
	[F_Question] [varchar](50) NULL,
	[F_AnswerQuestion] [varchar](500) NULL,
	[F_CheckIPAddress] [bit] NULL,
	[F_Language] [varchar](50) NULL,
	[F_Theme] [varchar](50) NULL,
 CONSTRAINT [PK_SYS_USERLOGON] PRIMARY KEY NONCLUSTERED 
(
	[F_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[Id] [int] NOT NULL,
	[Column_3] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[V_CUSTOMER]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_CUSTOMER]
AS
SELECT CS_NO, SHORT_NM, CLAS_NO, FULL_NM, FULL_NM2, ADDR_IVC, ADDR_IVC2, ADDR_OFC, ADDR_OFC2, TO_ADDR, TO_ADDR2, ADDR_DOC, ADDR_DOC2, ZNO_IVC, ZNO_OFC, ZNO_TO, ZNO_DOC, PROPRIETOR, CONTACTER, CONTACTER2, CONTACTER3, TEL_NO, TEL_NO2, TEL_NO3, FAX_NO, E_MAIL, WWW, UNIQUE_NO, TAX_NO, EMP_NO, DEPM_NO, SCHL_NO, CS_TY_NO, SLN_NO, NATION_NO, AREA_NO, PRC_NO, PRC_NO1, PRC_NO2, PRC_NO3, OPEN_DT, FST_DT, LST_DT, CAPITAL, EMP_TOT, C_SAL, C_CRD, AR_CS_NO, AR_ACT_NO, AR_BCH_NO, NR_ACT_NO, NR_BCH_NO, PR_ACT_NO, PR_BCH_NO, EAR_ACT_NO, EAR_BCH_NO, CURRENCY, TAX_TY, TAX_RT, IVC_PAGE, PRC_CDT, PAY_CDT, C_CTL, MAX_CRD, OVER_RT, AR_DAY, NR_DAY, CASH_DAY, BRAND, DESTINATION, SEA_PORT, SEA_CORP, AIR_PORT, AIR_CORP, SHIP_CORP, AGT_CORP, CLR_CORP, INSP_CORP, COMS_RATE, INSU_RATE, PRICING_SEQ, C_PRICING, DISC_RT, C_VCH, ACC_TY, RCV_TY, NOT_TY, SHIP_TY, BANK, BANK2, BANK3, ACC_NO, ACC_NO2, ACC_NO3, C_APF, REMK, EFF_DT, EXP_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, IP_NM, CP_NM, UPDUSER, UPDDATETIME, CS_TYPE, COMPID, TEMPCS_NO, CS_NO_RULE
 FROM CRMDBR01.dbo.SA_CSTM
GO
/****** Object:  View [dbo].[V_SRVDATAMT_CCM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVDATAMT_CCM]
AS
SELECT A.VCH_TY, A.VCH_NO, A.VCH_DT, A.RCV_MODE, A.EMP_NO,dbo.SF_EMP_NAME(A.EMP_NO) ENPLYNM, A.PROD_NO, A.CS_NO,B.SHORT_NM, 
A.PROB_REC, A.TO_ADDR, A.CURRENCY, A.EXCH_RATE, A.IVC_PAGE, A.TAX_TY, A.TAX_RT, A.PART_AMT, A.MMT_AMT, A.PLAN_DT, A.REAL_DT, 
A.REMK, A.C_CLS, A.N_PRT, A.C_CFM, A.CFM_DT, A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.CFM_USR_NO, A.IP_NM,A.CP_NM
 FROM [192.168.100.19].CCM_Main.dbo.SRVDATAMT A,V_CUSTOMER B
 WHERE A.CS_NO = B.CS_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[V_SRVDATAMT_KSC]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVDATAMT_KSC]
AS
SELECT A.VCH_TY, A.VCH_NO, A.VCH_DT, A.RCV_MODE, A.EMP_NO,dbo.SF_EMP_NAME(A.EMP_NO) ENPLYNM, A.PROD_NO, A.CS_NO,B.SHORT_NM, 
A.PROB_REC, A.TO_ADDR, A.CURRENCY, A.EXCH_RATE, A.IVC_PAGE, A.TAX_TY, A.TAX_RT, A.PART_AMT, A.MMT_AMT, A.PLAN_DT, A.REAL_DT, 
A.REMK, A.C_CLS, A.N_PRT, A.C_CFM, A.CFM_DT, A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.CFM_USR_NO, A.IP_NM,A.CP_NM
 FROM [192.168.100.18].KSC_15.dbo.SRVDATAMT A,V_CUSTOMER B
 WHERE A.CS_NO = B.CS_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[V_SRVDATAMT_NGB]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVDATAMT_NGB]
AS
SELECT A.VCH_TY, A.VCH_NO, A.VCH_DT, A.RCV_MODE, A.EMP_NO,dbo.SF_EMP_NAME(A.EMP_NO) ENPLYNM, A.PROD_NO, A.CS_NO,B.SHORT_NM, 
A.PROB_REC, A.TO_ADDR, A.CURRENCY, A.EXCH_RATE, A.IVC_PAGE, A.TAX_TY, A.TAX_RT, A.PART_AMT, A.MMT_AMT, A.PLAN_DT, A.REAL_DT, 
A.REMK, A.C_CLS, A.N_PRT, A.C_CFM, A.CFM_DT, A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.CFM_USR_NO, A.IP_NM,A.CP_NM
 FROM [192.168.100.18].NGB_15.dbo.SRVDATAMT A,V_CUSTOMER B
 WHERE A.CS_NO = B.CS_NO COLLATE Chinese_Taiwan_Stroke_CI_AS
GO
/****** Object:  View [dbo].[V_SRVDATAMT_ALL]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVDATAMT_ALL]
AS
SELECT  ISNULL(CONVERT(VARCHAR(36), newid()),'') AS ID,VCH_TY, VCH_NO, VCH_DT, RCV_MODE, EMP_NO, ENPLYNM, PROD_NO, CS_NO, SHORT_NM, PROB_REC, TO_ADDR, 
        CURRENCY, EXCH_RATE, IVC_PAGE, TAX_TY, TAX_RT, PART_AMT, MMT_AMT, PLAN_DT, REAL_DT, REMK, C_CLS, N_PRT, 
        C_CFM, CFM_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, CFM_USR_NO,ORG
FROM (
  SELECT VCH_TY, VCH_NO, VCH_DT, RCV_MODE, EMP_NO, ENPLYNM, PROD_NO, CS_NO, SHORT_NM, PROB_REC, TO_ADDR, 
  CURRENCY, EXCH_RATE, IVC_PAGE, TAX_TY, TAX_RT, PART_AMT, MMT_AMT, PLAN_DT, REAL_DT, REMK, C_CLS, N_PRT, 
  C_CFM, CFM_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, CFM_USR_NO,'總廠' AS ORG
   FROM EIP.dbo.V_SRVDATAMT_CCM
  UNION ALL
  SELECT VCH_TY, VCH_NO, VCH_DT, RCV_MODE, EMP_NO, ENPLYNM, PROD_NO, CS_NO, SHORT_NM, PROB_REC, TO_ADDR, 
  CURRENCY, EXCH_RATE, IVC_PAGE, TAX_TY, TAX_RT, PART_AMT, MMT_AMT, PLAN_DT, REAL_DT, REMK, C_CLS, N_PRT, 
  C_CFM, CFM_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, CFM_USR_NO,'昆山' AS ORG
   FROM EIP.dbo.V_SRVDATAMT_KSC
  UNION ALL
  SELECT VCH_TY, VCH_NO, VCH_DT, RCV_MODE, EMP_NO, ENPLYNM, PROD_NO, CS_NO, SHORT_NM, PROB_REC, TO_ADDR, 
  CURRENCY, EXCH_RATE, IVC_PAGE, TAX_TY, TAX_RT, PART_AMT, MMT_AMT, PLAN_DT, REAL_DT, REMK, C_CLS, N_PRT, 
  C_CFM, CFM_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, CFM_USR_NO,'寧波' AS ORG
   FROM EIP.dbo.V_SRVDATAMT_NGB
 ) TBL
GO
/****** Object:  View [dbo].[V_CUSTOMER_CCM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_CUSTOMER_CCM]
AS
SELECT CS_NO, SHORT_NM, CLAS_NO, FULL_NM, FULL_NM2, ADDR_IVC, ADDR_IVC2, ADDR_OFC, ADDR_OFC2, TO_ADDR, TO_ADDR2, ADDR_DOC, ADDR_DOC2, ZNO_IVC, ZNO_OFC, ZNO_TO, ZNO_DOC, PROPRIETOR, CONTACTER, CONTACTER2, CONTACTER3, TEL_NO, TEL_NO2, TEL_NO3, FAX_NO, E_MAIL, WWW, UNIQUE_NO, TAX_NO, EMP_NO, DEPM_NO, SCHL_NO, CS_TY_NO, SLN_NO, NATION_NO, AREA_NO, PRC_NO, PRC_NO1, PRC_NO2, PRC_NO3, OPEN_DT, FST_DT, LST_DT, CAPITAL, EMP_TOT, C_SAL, C_CRD, AR_CS_NO, AR_ACT_NO, AR_BCH_NO, NR_ACT_NO, NR_BCH_NO, PR_ACT_NO, PR_BCH_NO, EAR_ACT_NO, EAR_BCH_NO, CURRENCY, TAX_TY, TAX_RT, IVC_PAGE, PRC_CDT, PAY_CDT, C_CTL, MAX_CRD, OVER_RT, AR_DAY, NR_DAY, CASH_DAY, BRAND, DESTINATION, SEA_PORT, SEA_CORP, AIR_PORT, AIR_CORP, SHIP_CORP, AGT_CORP, CLR_CORP, INSP_CORP, COMS_RATE, INSU_RATE, PRICING_SEQ, C_PRICING, DISC_RT, C_VCH, ACC_TY, RCV_TY, NOT_TY, SHIP_TY, BANK, BANK2, BANK3, ACC_NO, ACC_NO2, ACC_NO3, C_APF, REMK, EFF_DT, EXP_DT, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT
 FROM [192.168.100.19].CCM_Main.dbo.customer
GO
/****** Object:  View [dbo].[V_EMP_ALLORG]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_EMP_ALLORG]
AS
--全集團員工資料
 SELECT     EMPLYID ,  EMPLYNM ,  PIDNO , BPLACE , SEX , BRTHDT , MARY , REGADRS , MAILADRS , MAILADRS2 , HP ,
     CONTEL , DEPID , LBRTP , REGDT , JOBID , DEGREE , SERVICE , RNO ,  LRTDT , LLFDT , NATION , FORMAL , EXMN ,
     PERD_05 , PERD_06 , RANKID , EMAIL ,  COMID , WBSID   FROM HRSDBR53.dbo.HR_EMPLYM 
 UNION
  SELECT     EMPLYID ,  EMPLYNM ,  PIDNO , BPLACE , SEX , BRTHDT , MARY , REGADRS , MAILADRS , MAILADRS2 , HP ,
     CONTEL , DEPID , LBRTP , REGDT , JOBID , DEGREE , SERVICE , RNO ,  LRTDT , LLFDT , NATION , FORMAL , EXMN ,
      PERD_05 , PERD_06 , RANKID , EMAIL ,  COMID , WBSID   FROM HRCDBR53.dbo.HR_EMPLYM
     WHERE PIDNO IS NOT NULL
 UNION
  SELECT     EMPLYID ,  EMPLYNM ,  PIDNO , BPLACE , SEX , BRTHDT , MARY , REGADRS , MAILADRS , MAILADRS2 , HP ,
     CONTEL , DEPID , LBRTP , REGDT , JOBID , DEGREE , SERVICE , RNO ,  LRTDT , LLFDT , NATION , FORMAL , EXMN ,
      PERD_05 , PERD_06 , RANKID , EMAIL ,  COMID , WBSID   FROM NBGDBR50.dbo.HR_EMPLYM
GO
/****** Object:  View [dbo].[V_ITEM_CCM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_ITEM_CCM]
AS
SELECT ITEM_NO, ITEM_NM, ITEM_SP, ITEM_NM_E, ITEM_SP_E, ITEM_NO_O, C_STA, GRAT_NO, CLAS_NO, CLAS_NO1, CLAS_NO2, CLAS_NO3, CLAS_NO4, CLAS_NO5, CLAS_NO6, CLAS_NO7, CLAS_NO8, CLAS_NO9, CLAS_NO10, CLAS_NO11, CLAS_NO12, ACT_NO, INV_TY, FIN_ITEM_NO, UNIT, UNIT1, UNIT2, UNIT3, EXCH_RATE1, EXCH_RATE2, EXCH_RATE3, C_AU, A_UNIT, W_UNIT, L_UNIT, S_UNIT, V_UNIT, WEIGHT, WEIGHT_DNN, LENGTH, LENGTH_DNN, AREA, AREA_DNN, VOLUMN, VOLUMN_DNN, SAFE_QTY, ROR_POT, SUP_POT, MIN_QTY, PCH_QTY, ISS_QTY, UNIT_QTY, FIX_LT, LEAD_TIME, INSP_LT, LOT_QTY, C_LT, WAHO_NO, LOCA_NO, VD_NO, PLINE_NO, EMP_NO, INV_EMP_NO, PUR_EMP_NO, MOC_EMP_NO, TIN_CODE, LLC_BOM, LLC_CST, C_SOURCE, C_BONDED, C_PHANT, C_BCH, C_SR, C_LOCA, C_ROR, C_CYC, C_ISS, C_INSP, VLD_DAY, CHK_DAY, C_ABC, MTR_CST, LAB_CST, OVH_CST, SBC_CST, LAB_ADD, OVH_ADD, SBC_ADD, MTR_ADD, MTR_RT, LAB_RT, OVH_RT, SBC_RT, STD_PCHPRC, STD_SALPRC, STD_SALEXP, SAL_PRC, C_TAX, PACK_NO, C_CTL, C_INV, ITEM_DSCP, ITEM_DSCP1, ITEM_DSCP2, ITEM_DSCP3, REMK, IMG_NO, IMG_NO1, IMG_NO2, IMG_NO3, RT_ITEM_NO, RT_NO, DOC_NO, BAR_CODE, EFF_DT, EXP_DT, C_MPS, C_OUT, OUT_RT, C_OVR, OVR_RT, QM_NO, PINE_DAY, PURE_DAY, GD_NO, [SIZE], CTS_RT, PO_TY, MO_TY, C_COST, OWNER_USR_NO, OWNER_GRP_NO, ADD_DT, MDY_USR_NO, MDY_DT
 FROM [192.168.100.19].CCM_Main.dbo.ITEM
GO
/****** Object:  View [dbo].[V_SRVPRODDL_CCM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODDL_CCM]
AS
 SELECT PROD_NO, PROD_SR, ENTRY, DSCP_1, DSCP_2, DSCP_3
 FROM [192.168.100.19].CCM_Main.dbo.SRVPRODDL
GO
/****** Object:  View [dbo].[V_SRVPRODDL_KSC]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODDL_KSC]
AS
 SELECT PROD_NO, PROD_SR, ENTRY, DSCP_1, DSCP_2, DSCP_3
 FROM [192.168.100.18].KSC_15.dbo.SRVPRODDL
GO
/****** Object:  View [dbo].[V_SRVPRODDL_NGB]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODDL_NGB]
AS
 SELECT PROD_NO, PROD_SR, ENTRY, DSCP_1, DSCP_2, DSCP_3
 FROM [192.168.100.18].NGB_15.dbo.SRVPRODDL
GO
/****** Object:  View [dbo].[V_SRVPRODMT_CCM]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODMT_CCM]
AS
 SELECT A.PROD_NO, A.PROD_TY, A.ITEM_NO,B.ITEM_NM,B.ITEM_SP, A.M_ITEM_NO, A.M_ITEM_ID, A.SO_DT, A.SO_TY, A.SO_NO, A.SO_SR, 
A.SO_CS_NO, A.SO_CS_NM, A.FA_NO, A.CS_NO, A.CS_NM, A.TO_ADDR, A.PROD_GUAR_MM, A.PROD_GUAR_DT,
A.M_ITEM_GUAR_MM, A.M_ITEM_GUAR_DT, A.REMK, A.CO_TY, A.CO_NO, A.CO_SR, A.CS_VCH_NO, A.QT_TY, A.QT_NO, A.QT_SR, 
A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.IP_NM,A.CP_NM
 FROM [192.168.100.19].CCM_Main.dbo.V_SRVPRODMT A,[192.168.100.19].CCM_Main.dbo.ITEM B
 WHERE A.ITEM_NO = B.ITEM_NO
GO
/****** Object:  View [dbo].[V_SRVPRODMT_KSC]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODMT_KSC]
AS
SELECT A.PROD_NO, A.PROD_TY, A.ITEM_NO,B.ITEM_NM,B.ITEM_SP, A.M_ITEM_NO, A.M_ITEM_ID, A.SO_DT, A.SO_TY, A.SO_NO, A.SO_SR, 
A.SO_CS_NO, A.SO_CS_NM, A.FA_NO, A.CS_NO, A.CS_NM, A.TO_ADDR, A.PROD_GUAR_MM, A.PROD_GUAR_DT,
A.M_ITEM_GUAR_MM, A.M_ITEM_GUAR_DT, A.REMK, A.CO_TY, A.CO_NO, A.CO_SR, A.CS_VCH_NO, A.QT_TY, A.QT_NO, A.QT_SR, 
A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.IP_NM,A.CP_NM
 FROM [192.168.100.18].KSC_15.dbo.V_SRVPRODMT A,[192.168.100.18].KSC_15.dbo.ITEM B
 WHERE A.ITEM_NO = B.ITEM_NO
GO
/****** Object:  View [dbo].[V_SRVPRODMT_NGB]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SRVPRODMT_NGB]
AS
SELECT A.PROD_NO, A.PROD_TY, A.ITEM_NO,B.ITEM_NM,B.ITEM_SP, A.M_ITEM_NO, A.M_ITEM_ID, A.SO_DT, A.SO_TY, A.SO_NO, A.SO_SR, 
A.SO_CS_NO, A.SO_CS_NM, A.FA_NO, A.CS_NO, A.CS_NM, A.TO_ADDR, A.PROD_GUAR_MM, A.PROD_GUAR_DT,
A.M_ITEM_GUAR_MM, A.M_ITEM_GUAR_DT, A.REMK, A.CO_TY, A.CO_NO, A.CO_SR, A.CS_VCH_NO, A.QT_TY, A.QT_NO, A.QT_SR, 
A.OWNER_USR_NO, A.OWNER_GRP_NO, A.ADD_DT, A.IP_NM,A.CP_NM
 FROM [192.168.100.18].NGB_15.dbo.V_SRVPRODMT A,[192.168.100.18].NGB_15.dbo.ITEM B
 WHERE A.ITEM_NO = B.ITEM_NO
GO
/****** Object:  View [dbo].[V_SS_ACTIONLOG]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[V_SS_ACTIONLOG]
AS
SELECT LogId,Operator, EIP.dbo.SF_EMP_NAME(Operator)emplynm,Refer, Destination, Method, MobleDevices, Browser, IPAddress, RequestTime
 FROM EIP.dbo.SS_ACTIONLOG
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [RoleNameIndex]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE UNIQUE NONCLUSTERED INDEX [RoleNameIndex] ON [dbo].[AspNetRoles]
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserClaims]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserLogins]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_RoleId]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE NONCLUSTERED INDEX [IX_RoleId] ON [dbo].[AspNetUserRoles]
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [IX_UserId]    Script Date: 2016/11/18 上午 08:53:10 ******/
CREATE NONCLUSTERED INDEX [IX_UserId] ON [dbo].[AspNetUserRoles]
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ('getdate()') FOR [LoginDate]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  CONSTRAINT [D_dbo_MIS_IP_ADDRESS_1]  DEFAULT (getdate()) FOR [EXC_UPDDATE]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[MIS_IP_ADDRESS] ADD  DEFAULT ('CCM') FOR [EXC_COMPANY]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT ('CCM') FOR [ORGANIZATION]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[RD_DWG_EXMANAGE_MT] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT (getdate()) FOR [ORD_DATE]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  CONSTRAINT [D_dbo_RD_TECH_BULLETIN_MT_1]  DEFAULT ('N') FOR [STATUS]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT ('CCM') FOR [ORGANIZATION]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_MT] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[SS_CONNECT_COUNT] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[SS_ERPSESSION] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ('N') FOR [CHKDP]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ((0)) FOR [FMLEN]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ('N') FOR [TAX]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ('IK/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ('ERP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[SS_FMCODE] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('Y') FOR [STATUS]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('CCM') FOR [ORGANIZATION]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[SS_PARAMETER] ADD  DEFAULT ('CCM') FOR [EXC_COMPANY]
GO
ALTER TABLE [dbo].[SS_PDMSESSION] ADD  DEFAULT (getdate()) FOR [CREATE_DATE]
GO
ALTER TABLE [dbo].[SS_PROGRAM] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[SS_PROGRAM] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[SS_PROGRAM] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[SS_PROGRAM] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ((3)) FOR [NO_LENGTH]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ((0)) FOR [CURRENT_NO]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('Y') FOR [STATUS]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('CCM') FOR [ORGANIZATION]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('EIP/Unknown') FOR [EXC_INSDBID]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT (getdate()) FOR [EXC_INSDATE]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('EIP') FOR [EXC_SYSOWNR]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('N') FOR [EXC_ISLOCKED]
GO
ALTER TABLE [dbo].[SS_SEQ_NO] ADD  DEFAULT ('CCM') FOR [EXC_COMPANY]
GO
ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[AspNetRoles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL]  WITH CHECK ADD  CONSTRAINT [FK_dbo_RD_TECH_BULLETIN_DL_1] FOREIGN KEY([FK_ID])
REFERENCES [dbo].[RD_TECH_BULLETIN_MT] ([ID])
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL] CHECK CONSTRAINT [FK_dbo_RD_TECH_BULLETIN_DL_1]
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1]  WITH CHECK ADD  CONSTRAINT [FK_dbo_RD_TECH_BULLETIN_DL1_1] FOREIGN KEY([FK_ID])
REFERENCES [dbo].[RD_TECH_BULLETIN_MT] ([ID])
GO
ALTER TABLE [dbo].[RD_TECH_BULLETIN_DL1] CHECK CONSTRAINT [FK_dbo_RD_TECH_BULLETIN_DL1_1]
GO
ALTER TABLE [dbo].[SS_FMCODE]  WITH CHECK ADD  CONSTRAINT [CK__SS_FMCODE__EXC_I__4A8310C6] CHECK  (([EXC_ISLOCKED]='N' OR [EXC_ISLOCKED]='Y'))
GO
ALTER TABLE [dbo].[SS_FMCODE] CHECK CONSTRAINT [CK__SS_FMCODE__EXC_I__4A8310C6]
GO
ALTER TABLE [dbo].[SS_FMCODE]  WITH CHECK ADD  CONSTRAINT [CK__SS_FMCODE__EXC_S__489AC854] CHECK  (([EXC_SYSOWNR]='CAPP' OR [EXC_SYSOWNR]='PDM' OR [EXC_SYSOWNR]='ERP' OR [EXC_SYSOWNR]='EIP'))
GO
ALTER TABLE [dbo].[SS_FMCODE] CHECK CONSTRAINT [CK__SS_FMCODE__EXC_S__489AC854]
GO
ALTER TABLE [dbo].[SS_FMCODE]  WITH CHECK ADD  CONSTRAINT [Z_SS_FMCODE_CHKDP_YesOrNo_1031140141] CHECK  (([CHKDP]='N' OR [CHKDP]='Y'))
GO
ALTER TABLE [dbo].[SS_FMCODE] CHECK CONSTRAINT [Z_SS_FMCODE_CHKDP_YesOrNo_1031140141]
GO
ALTER TABLE [dbo].[SS_FMCODE]  WITH CHECK ADD  CONSTRAINT [Z_SS_FMCODE_FMLEN_LARGER_THEN_ZERO_159088522] CHECK  (([FMLEN]>=(0)))
GO
ALTER TABLE [dbo].[SS_FMCODE] CHECK CONSTRAINT [Z_SS_FMCODE_FMLEN_LARGER_THEN_ZERO_159088522]
GO
ALTER TABLE [dbo].[SS_FMCODE]  WITH CHECK ADD  CONSTRAINT [Z_SS_FMCODE_TAX_YesOrNo_929776746] CHECK  (([TAX]='N' OR [TAX]='Y'))
GO
ALTER TABLE [dbo].[SS_FMCODE] CHECK CONSTRAINT [Z_SS_FMCODE_TAX_YesOrNo_929776746]
GO
/****** Object:  StoredProcedure [dbo].[SP_EMP_NAME]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_EMP_NAME] 
/****************************************************************************************
'程式代號：dbo.SP_EMP_NAME 
'程式名稱：取得員工姓名
'目　　的：
'參數說明：
(
@V_EMPLYID varchar(12)='' --員工編號
)    
'範　例　：
    EXEC SP_EMP_NAME 'B050501'
****************************************************************************************/
(
  @V_EMPLYID NVARCHAR(20)
)

AS
BEGIN
DECLARE
 @V_EMPLYNM nvarchar(50)=''
 
  SELECT EMPNM = EMPLYNM
   FROM EIP.dbo.V_EMP_ALLORG
   WHERE EMPLYID = @V_EMPLYID

END
GO
/****** Object:  StoredProcedure [dbo].[SP_GEN_ORDNO]    Script Date: 2016/11/18 上午 08:53:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GEN_ORDNO]
/****************************************************************************************
'程式代號：dbo.SP_GET_ORDNO 
'程式名稱：取得流水單號
'目　　的：
'參數說明：
(
@TYPE varchar(12)='', --類別
@PREFIX varchar(20)='', -- 前置詞
@COUNT int=1           --取得筆數
)    
'範　例　：
    EXEC USP_GET_SYS_SEQ_NO '財務', 'PREFIX',  1
    EXEC USP_GET_SYS_SEQ_NO '財務', 'PREFIX',  3
****************************************************************************************/
(
@TYPE varchar(12)='',   --申請類別 RD
@PREFIX varchar(20)='' ,-- 前置詞
@COUNT int=1            --取得筆數
)
AS BEGIN
  DECLARE 
  @TO_NO INT,
  @V_CODEFORMAT VARCHAR(20),
  @V_MIDCODE VARCHAR(20),
  @V_CURRENT_NO INT,
  @V_NOLENGTH INT,
  @V_ORD_NO NVARCHAR(20)='',
  @V_YM         VARCHAR(10),
  @V_CURRENT_YM VARCHAR(10)
/*  
SELECT ID, [NAME], [TYPE], PREFIX, CODEFORMAT, CURRENT_NO, EXC_COMPANY
 FROM EIP.dbo.SS_SEQ_NO
 */  
 SELECT @V_CODEFORMAT = CODEFORMAT, @V_CURRENT_NO = CURRENT_NO,@V_NOLENGTH = NO_LENGTH,@V_CURRENT_YM = CURRENT_YM
 FROM dbo.SS_SEQ_NO
 WHERE TYPE=@TYPE AND PREFIX = @PREFIX
 
 -- 先判斷是否已換月
 SELECT @V_YM=LEFT(CONVERT(VARCHAR(10),GETDATE(),112),6)
 IF (@V_YM > @V_CURRENT_YM)
 BEGIN
    BEGIN TRAN
      --更新
      UPDATE dbo.SS_SEQ_NO
         SET CURRENT_YM = @V_YM
           , CURRENT_NO = 0
       WHERE TYPE=@TYPE AND PREFIX=@PREFIX
    COMMIT TRAN
 END
 
 
 IF (@V_CODEFORMAT = 'YYMM')
  BEGIN
    SELECT @V_MIDCODE =LEFT(RIGHT(CONVERT(VARCHAR(10),GETDATE(),112),6),4)
  END
 ELSE IF (@V_CODEFORMAT = 'YYMMDD')
  BEGIN
   
   SELECT @V_MIDCODE =RIGHT(CONVERT(VARCHAR(10),GETDATE(),112),6)
  END
 ELSE  -- YYYYMMDD
 BEGIN
   SELECT @V_MIDCODE =CONVERT(VARCHAR(10),GETDATE(),112)
 END
 
   BEGIN TRAN
      --取出流水號並更新資料
      UPDATE dbo.SS_SEQ_NO
         SET CURRENT_NO = CURRENT_NO+@COUNT
           , @TO_NO = CURRENT_NO+@COUNT
       WHERE TYPE=@TYPE
         AND PREFIX=@PREFIX
   COMMIT TRAN
   BEGIN TRAN
      --取出流水號並更新資料
      UPDATE dbo.SS_SEQ_NO
         SET CURRENT_ORDNO = @PREFIX + @V_MIDCODE + RIGHT('0000000000' + CONVERT(VARCHAR, @TO_NO-@COUNT+1), @V_NOLENGTH)
       WHERE TYPE=@TYPE
         AND PREFIX=@PREFIX
   COMMIT TRAN

/*
  SELECT FROM_NO=@PREFIX + RIGHT('0000000000' + CONVERT(VARCHAR, @TO_NO-@COUNT+1), @NO_LENGTH)
       , TO_NO=@PREFIX + RIGHT('0000000000' + CONVERT(VARCHAR, @TO_NO), @NO_LENGTH)
 */   
 
 SELECT FROM_NO=@PREFIX + @V_MIDCODE + RIGHT('0000000000' + CONVERT(VARCHAR, @TO_NO-@COUNT+1), @V_NOLENGTH)
       ,TO_NO = @PREFIX + @V_MIDCODE + RIGHT('0000000000' + CONVERT(VARCHAR, @TO_NO), @V_NOLENGTH)
       

END
GO
/****** Object:  StoredProcedure [dbo].[SP_RECORD_ERPCONNECT]    Script Date: 2016/11/18 上午 08:53:10 ******/
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
   INSERT INTO SS_CONNECT_COUNT(COMPANY, SYS_NAME, ACCOUNT_CNT) VALUES(@V_COMPANY,@V_SYS_NAME,@V_ACCOUNT_CNT)
  COMMIT TRAN
  
   --連結數-OTHER
 SELECT @V_ACCOUNT_CNT = COUNT(*) 
 FROM (
    SELECT session_id, dbid, [host_name],REPLACE(program_name,'MSTMIS\','') as program_name,
           EIP01.dbo.SF_GETEMPNAME(REPLACE(program_name,'MSTMIS\','')) as emp_nm, client_net_address, login_name,db_name
     FROM [192.168.100.18].master.dbo.V_CONN_SESSION
    
 ) C

  BEGIN TRAN
   INSERT INTO SS_CONNECT_COUNT(COMPANY, SYS_NAME, ACCOUNT_CNT) VALUES('OTHER',@V_SYS_NAME,@V_ACCOUNT_CNT)
  COMMIT TRAN
  
  
  -- ERP 連線人員
   BEGIN TRAN
    INSERT INTO EIP.dbo.SS_ERPSESSION(session_id, dbid, host_name, program_name, emp_nm, client_net_address, login_name, db_name)
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
/****** Object:  StoredProcedure [dbo].[SP_RECORD_PDMCONNECT]    Script Date: 2016/11/18 上午 08:53:10 ******/
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
   INSERT INTO SS_CONNECT_COUNT(COMPANY, SYS_NAME,ON_LINE_CNT, ACCOUNT_CNT) VALUES(@V_COMPANY,@V_SYS_NAME,@V_ONLINE_CNT,@V_ACCOUNT_CNT)
 
  COMMIT TRAN
  
  BEGIN TRAN
    INSERT INTO EIP.dbo.SS_PDMSESSION(CONNECT_PC, CONNECT_CLASS, CONNECT_USER, USERNAME, CONNECT_IP, CONNECT_CLIENTNAME, CONNECT_SESSIONNAME, CONNECT_APPNAME)
    SELECT CONNECT_PC, CONNECT_CLASS, CONNECT_USER, B.USERNAME ,
          CONNECT_IP, CONNECT_CLIENTNAME, CONNECT_SESSIONNAME, CONNECT_APPNAME
     FROM [192.168.100.19].VPDM.dbo.PDM_APPCONNECT AS A 
     LEFT OUTER JOIN [192.168.100.19].VPDM.dbo.PDM_LOGONACCOUNT AS B 
     ON A.CONNECT_USER = B.USERID;
  COMMIT TRAN
  
  END -- IF END
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出圖編號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'ORD_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'戳章日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'ORD_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組號/品號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'PROD_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'品名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'PROD_NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出圖日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'EXPORT_DATE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'數量(張/組)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'EXPORT_QTY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收圖單位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'TO_DEPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'收圖人員' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'TO_EMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出圖單位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'FM_DEPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'出圖人員' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_DWG_EXMANAGE_MT', @level2type=N'COLUMN',@level2name=N'FM_EMP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案類型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'FILE_TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'FILE_SIZE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案路徑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'FILE_PATH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案說明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'FILE_DESCRIPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外來鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL', @level2type=N'COLUMN',@level2name=N'FK_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'序號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL1', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'員工編號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL1', @level2type=N'COLUMN',@level2name=N'EMP_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'回覆內容' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL1', @level2type=N'COLUMN',@level2name=N'REPLY'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'外來鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_DL1', @level2type=N'COLUMN',@level2name=N'FK_ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'GUID' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'ID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'ORD_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'建立人員' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'EMP_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'標題' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'TITLE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述說明' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'DESCRIPT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'相關部門' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT', @level2type=N'COLUMN',@level2name=N'RELATE_DEPT'
GO
EXEC sys.sp_addextendedproperty @name=N'ORD_NO', @value=N'單號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'RD_TECH_BULLETIN_MT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據代碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMID'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMNM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據字首' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMPRX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部門識別' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'CHKDP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼格式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMFMT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼長度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMLEN'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'保稅使用' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'TAX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'簽核欄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'APRVCOL'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'TBLNM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據欄位名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FLDNM'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部門欄位名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'DPFLD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據日期欄位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMFLD'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編訂方式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMSRC'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'適用年度' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'FMYR'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目前編號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_FMCODE', @level2type=N'COLUMN',@level2name=N'CURNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'NAME'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分類' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'TYPE'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'前置碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'PREFIX'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'單據格式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'CODEFORMAT'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'流水號碼數' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'NO_LENGTH'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'現在號碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'CURRENT_NO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'現在單號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'SS_SEQ_NO', @level2type=N'COLUMN',@level2name=N'CURRENT_ORDNO'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'簡拼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_SimpleSpelling'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'行政區域表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Area'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'備份主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'備份類型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_BackupType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'資料庫名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_DbName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔案名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_FileName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'文件大小' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_FileSize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'檔路徑' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_FilePath'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'備份時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_BackupTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'資料庫備份' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_DbBackup'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'過濾主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'類型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'開始IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_StartIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'結束IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_EndIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'過濾IP' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_FilterIP'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主表主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'樹型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_IsTree'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'選項主表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Items'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'明細主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主表主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_ItemId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_ItemCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_ItemName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'簡拼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_SimpleSpelling'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'默認' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_IsDefault'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'選項明細表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ItemsDetail'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日誌主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Date'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'類型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_IPAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'IP所在城市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_IPAddressName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統模組Id' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_ModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統模組' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_ModuleName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'結果' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Result'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統日誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Log'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'圖示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_Icon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'連接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_UrlAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'目標' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_Target'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'菜單' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_IsMenu'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'展開' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_IsExpand'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公共' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_IsPublic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許編輯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_AllowEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許刪除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_AllowDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統模組' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Module'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'按鈕主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_ModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'圖示' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Icon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'位置' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Location'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'事件' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_JsEvent'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'連接' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_UrlAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分開線' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Split'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'公共' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_IsPublic'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許編輯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_AllowEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許刪除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_AllowDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組按鈕' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleButton'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表單主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_ModuleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表單控制項Json' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_FormJson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組表單' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleForm'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表單實例主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表單主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_FormId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'對象主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_ObjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'表單實例Json' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_InstanceJson'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'模組表單實例' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_ModuleFormInstance'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'組織主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'父級' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_ParentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'層次' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Layers'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'簡稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_ShortName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分類' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_CategoryId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'負責人' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_ManagerId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'電話' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_TelePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手機' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_WeChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'傳真' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Fax'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'郵箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'歸屬區域' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_AreaId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'聯繫地址' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Address'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許編輯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_AllowEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許刪除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_AllowDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'組織表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Organize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'組織主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_OrganizeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'分類:1-角色2-崗位' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_Category'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'編號' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_EnCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_FullName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'類型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_Type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許編輯' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_AllowEdit'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許刪除' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_AllowDelete'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_Role'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色授權主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'專案類型1-模組2-按鈕3-清單' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_ItemType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'項目主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_ItemId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'物件分類1-角色2-部門-3用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_ObjectType'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'對象主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_ObjectId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色授權表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_RoleAuthorize'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'帳戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Account'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'姓名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_RealName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'呢稱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_NickName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'頭像' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_HeadIcon'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性別' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'手機' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_MobilePhone'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'郵箱' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Email'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'微信' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_WeChat'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'主管主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_ManagerId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'安全級別' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_SecurityLevel'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'個性簽名' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Signature'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'組織主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_OrganizeId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'部門主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_DepartmentId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'角色主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_RoleId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'崗位主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_DutyId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否管理員' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_IsAdministrator'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'排序碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_SortCode'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_DeleteMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'有效標誌' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_EnabledMark'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'描述' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_Description'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_CreatorTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'創建用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_CreatorUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_LastModifyTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_LastModifyUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_DeleteTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'刪除用戶' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User', @level2type=N'COLUMN',@level2name=N'F_DeleteUserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_User'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶登錄主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_Id'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶主鍵' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_UserId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用者密碼' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_UserPassword'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'用戶秘鑰' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_UserSecretkey'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許登錄時間開始' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_AllowStartTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許登錄時間結束' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_AllowEndTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'暫停用戶開始日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_LockStartDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'暫停用戶結束日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_LockEndDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'第一次存取時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_FirstVisitTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'上一次存取時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_PreviousVisitTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後存取時間' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_LastVisitTime'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'最後修改密碼日期' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_ChangePasswordDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'允許同時有多用戶登錄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_MultiUserLogin'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'登錄次數' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_LogOnCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'線上狀態' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_UserOnLine'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密碼提示問題' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_Question'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'密碼提示答案' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_AnswerQuestion'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'是否訪問限制' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_CheckIPAddress'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統語言' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_Language'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'系統樣式' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn', @level2type=N'COLUMN',@level2name=N'F_Theme'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'使用者登錄資訊表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Sys_UserLogOn'
GO
USE [master]
GO
ALTER DATABASE [EIP] SET  READ_WRITE 
GO
