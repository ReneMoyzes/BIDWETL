/****** Object:  Table [Stage].[Teams]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[Teams]') AND type in (N'U'))
DROP TABLE [Stage].[Teams]
GO
/****** Object:  Table [Stage].[StravaActivity]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[StravaActivity]') AND type in (N'U'))
DROP TABLE [Stage].[StravaActivity]
GO
/****** Object:  Table [Stage].[SportMapping]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[SportMapping]') AND type in (N'U'))
DROP TABLE [Stage].[SportMapping]
GO
/****** Object:  Table [Stage].[Sport]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[Sport]') AND type in (N'U'))
DROP TABLE [Stage].[Sport]
GO
/****** Object:  Table [Stage].[Competition]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[Competition]') AND type in (N'U'))
DROP TABLE [Stage].[Competition]
GO
/****** Object:  Table [Stage].[AspNetUsers]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[AspNetUsers]') AND type in (N'U'))
DROP TABLE [Stage].[AspNetUsers]
GO
/****** Object:  Table [ODS].[Teams_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Teams_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[Teams_Delta]
GO
/****** Object:  Table [ODS].[Teams]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Teams]') AND type in (N'U'))
DROP TABLE [ODS].[Teams]
GO
/****** Object:  Table [ODS].[StravaActivity_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[StravaActivity_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[StravaActivity_Delta]
GO
/****** Object:  Table [ODS].[StravaActivity]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[StravaActivity]') AND type in (N'U'))
DROP TABLE [ODS].[StravaActivity]
GO
/****** Object:  Table [ODS].[SportMapping_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[SportMapping_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[SportMapping_Delta]
GO
/****** Object:  Table [ODS].[SportMapping]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[SportMapping]') AND type in (N'U'))
DROP TABLE [ODS].[SportMapping]
GO
/****** Object:  Table [ODS].[Sport_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Sport_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[Sport_Delta]
GO
/****** Object:  Table [ODS].[Sport]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Sport]') AND type in (N'U'))
DROP TABLE [ODS].[Sport]
GO
/****** Object:  Table [ODS].[Competition_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Competition_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[Competition_Delta]
GO
/****** Object:  Table [ODS].[Competition]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[Competition]') AND type in (N'U'))
DROP TABLE [ODS].[Competition]
GO
/****** Object:  Table [ODS].[AspNetUsers_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AspNetUsers_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[AspNetUsers_Delta]
GO
/****** Object:  Table [ODS].[AspNetUsers]    Script Date: 3/4/2026 9:03:46 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AspNetUsers]') AND type in (N'U'))
DROP TABLE [ODS].[AspNetUsers]
GO
/****** Object:  Table [ODS].[AspNetUsers]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AspNetUsers](
	[Id] [nvarchar](36) NOT NULL,
	[FirstName] [nvarchar](32) NULL,
	[LastName] [nvarchar](32) NULL,
	[NickName] [nvarchar](100) NULL,
	[EldomondoName] [nvarchar](100) NULL,
	[TeamId] [int] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[LastLoad] [datetime2](7) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DeactivatedOn] [datetime2](7) NOT NULL,
	[ProfileImageUrl] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AspNetUsers_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AspNetUsers_Delta](
	[Id] [nvarchar](36) NOT NULL,
	[FirstName] [nvarchar](32) NULL,
	[LastName] [nvarchar](32) NULL,
	[NickName] [nvarchar](100) NULL,
	[EldomondoName] [nvarchar](100) NULL,
	[TeamId] [int] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[LastLoad] [datetime2](7) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DeactivatedOn] [datetime2](7) NOT NULL,
	[ProfileImageUrl] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Competition]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Competition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[LastDate] [datetime2](7) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[LastRegistrationDate] [datetime2](7) NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Competition_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Competition_Delta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[LastDate] [datetime2](7) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[LastRegistrationDate] [datetime2](7) NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Sport]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Sport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[SortIndex] [int] NOT NULL,
	[Measure] [nvarchar](max) NULL,
	[MeasureRatio] [float] NOT NULL,
	[MeasureTitle] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Sport_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Sport_Delta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[SortIndex] [int] NOT NULL,
	[Measure] [nvarchar](max) NULL,
	[MeasureRatio] [float] NOT NULL,
	[MeasureTitle] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [ODS].[SportMapping]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[SportMapping](
	[SportId] [int] NOT NULL,
	[ActivityTypeName] [nvarchar](64) NOT NULL,
	[Weight] [float] NOT NULL,
	[Measure] [nvarchar](16) NOT NULL,
	[Minimum] [float] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[SportMapping_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[SportMapping_Delta](
	[SportId] [int] NOT NULL,
	[ActivityTypeName] [nvarchar](64) NOT NULL,
	[Weight] [float] NOT NULL,
	[Measure] [nvarchar](16) NOT NULL,
	[Minimum] [float] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[StravaActivity]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[StravaActivity](
	[Id] [bigint] NOT NULL,
	[StravaId] [bigint] NOT NULL,
	[DateTimeStart] [datetime2](7) NOT NULL,
	[ElapsedTime] [int] NOT NULL,
	[Distance] [int] NOT NULL,
	[Type] [nvarchar](64) NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[YbaracupWebUserId] [nvarchar](36) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DistanceDown] [int] NULL,
	[DistanceUp] [int] NULL,
	[ElevationGain] [int] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[StravaActivity_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[StravaActivity_Delta](
	[Id] [bigint] NOT NULL,
	[StravaId] [bigint] NOT NULL,
	[DateTimeStart] [datetime2](7) NOT NULL,
	[ElapsedTime] [int] NOT NULL,
	[Distance] [int] NOT NULL,
	[Type] [nvarchar](64) NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[YbaracupWebUserId] [nvarchar](36) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DistanceDown] [int] NULL,
	[DistanceUp] [int] NULL,
	[ElevationGain] [int] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Teams]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Teams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](32) NULL,
	[Style] [nvarchar](32) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[Teams_Delta]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Teams_Delta](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](32) NULL,
	[Style] [nvarchar](32) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_Operation] [nvarchar](1) NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AspNetUsers]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AspNetUsers](
	[Id] [nvarchar](36) NOT NULL,
	[FirstName] [nvarchar](32) NULL,
	[LastName] [nvarchar](32) NULL,
	[NickName] [nvarchar](100) NULL,
	[EldomondoName] [nvarchar](100) NULL,
	[TeamId] [int] NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[LastLoad] [datetime2](7) NOT NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DeactivatedOn] [datetime2](7) NOT NULL,
	[ProfileImageUrl] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[Competition]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[Competition](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[LastDate] [datetime2](7) NOT NULL,
	[StartDate] [datetime2](7) NOT NULL,
	[LastRegistrationDate] [datetime2](7) NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[Sport]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[Sport](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](64) NOT NULL,
	[NormalizedName] [nvarchar](64) NOT NULL,
	[SortIndex] [int] NOT NULL,
	[Measure] [nvarchar](max) NULL,
	[MeasureRatio] [float] NOT NULL,
	[MeasureTitle] [nvarchar](max) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Stage].[SportMapping]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[SportMapping](
	[SportId] [int] NOT NULL,
	[ActivityTypeName] [nvarchar](64) NOT NULL,
	[Weight] [float] NOT NULL,
	[Measure] [nvarchar](16) NOT NULL,
	[Minimum] [float] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[StravaActivity]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[StravaActivity](
	[Id] [bigint] NOT NULL,
	[StravaId] [bigint] NOT NULL,
	[DateTimeStart] [datetime2](7) NOT NULL,
	[ElapsedTime] [int] NOT NULL,
	[Distance] [int] NOT NULL,
	[Type] [nvarchar](64) NULL,
	[LoadDate] [datetime2](7) NOT NULL,
	[YbaracupWebUserId] [nvarchar](36) NULL,
	[CreatedDate] [datetime2](7) NOT NULL,
	[UpdatedDate] [datetime2](7) NOT NULL,
	[DistanceDown] [int] NULL,
	[DistanceUp] [int] NULL,
	[ElevationGain] [int] NOT NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[Teams]    Script Date: 3/4/2026 9:03:46 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[Teams](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](32) NULL,
	[Style] [nvarchar](32) NULL,
	[_LoadDate] [datetime2](7) NULL,
	[_LoadId] [int] NULL,
	[_HASH] [char](32) NULL
) ON [PRIMARY]
GO
