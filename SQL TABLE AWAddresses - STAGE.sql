USE [MOY001]
GO
/****** Object:  Table [Stage].[AWAddress]    Script Date: 3/28/2025 9:49:41 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AWAddress](
	[AddressID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[AddressLine1] [nvarchar](60) NOT NULL,
	[AddressLine2] [nvarchar](60) NULL,
	[City] [nvarchar](30) NOT NULL,
	[StateProvince] [nvarchar](50) NOT NULL,
	[CountryRegion] [nvarchar](50) NOT NULL,
	[PostalCode] [nvarchar](15) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
