USE [MOY001]
GO
EXEC sys.sp_dropextendedproperty @name=N'MS_Description' , @level0type=N'SCHEMA',@level0name=N'SalesLT'
GO
/****** Object:  StoredProcedure [ETL].[RegisterExecution]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP PROCEDURE [ETL].[RegisterExecution]
GO

DROP SEQUENCE [ETL].[SeqExecID] 

GO

/****** Object:  Table [Stage].[AWSalesOrderDetail]    Script Date: 3/14/2025 9:24:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[Stage].[AWSalesOrderDetail]') AND type in (N'U'))
DROP TABLE [Stage].[AWSalesOrderDetail]
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail_Delta]    Script Date: 3/14/2025 9:24:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWSalesOrderDetail_Delta]') AND type in (N'U'))
DROP TABLE [ODS].[AWSalesOrderDetail_Delta]
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail]    Script Date: 3/14/2025 9:24:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ODS].[AWSalesOrderDetail]') AND type in (N'U'))
DROP TABLE [ODS].[AWSalesOrderDetail]
GO
/****** Object:  Table [ETL].[Executions]    Script Date: 3/14/2025 9:24:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[Executions]') AND type in (N'U'))
DROP TABLE [ETL].[Executions]
GO
/****** Object:  Table [ETL].[Batches]    Script Date: 3/14/2025 9:24:10 AM ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[ETL].[Batches]') AND type in (N'U'))
DROP TABLE [ETL].[Batches]
GO
/****** Object:  Schema [Stage]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP SCHEMA [Stage]
GO
/****** Object:  Schema [SalesLT]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP SCHEMA [SalesLT]
GO
/****** Object:  Schema [ODS]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP SCHEMA [ODS]
GO
/****** Object:  Schema [ETL]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP SCHEMA [ETL]
GO
/****** Object:  Schema [DM]    Script Date: 3/14/2025 9:24:10 AM ******/
DROP SCHEMA [DM]
GO
/****** Object:  Schema [DM]    Script Date: 3/14/2025 9:24:10 AM ******/
CREATE SCHEMA [DM]
GO
/****** Object:  Schema [ETL]    Script Date: 3/14/2025 9:24:10 AM ******/
CREATE SCHEMA [ETL]
GO
/****** Object:  Schema [ODS]    Script Date: 3/14/2025 9:24:10 AM ******/
CREATE SCHEMA [ODS]
GO
/****** Object:  Schema [SalesLT]    Script Date: 3/14/2025 9:24:10 AM ******/
CREATE SCHEMA [SalesLT]
GO
/****** Object:  Schema [Stage]    Script Date: 3/14/2025 9:24:10 AM ******/
CREATE SCHEMA [Stage]
GO
/****** Object:  Table [ETL].[Batches]    Script Date: 3/14/2025 9:24:10 AM ******/

CREATE SEQUENCE [ETL].[SeqExecID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO



SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ETL].[Batches](
	[BatchID] [int] NOT NULL,
	[PackageName] [nvarchar](50) NULL,
	[Started] [datetime] NULL,
	[Ended] [date] NULL,
	[Status] [nvarchar](1) NULL,
 CONSTRAINT [PK_Batches] PRIMARY KEY CLUSTERED 
(
	[BatchID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ETL].[Executions]    Script Date: 3/14/2025 9:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ETL].[Executions](
	[ExecutionId] [int] NOT NULL,
	[BatchID] [int] NOT NULL,
	[PackageName] [nvarchar](50) NULL,
	[Started] [datetime] NULL,
	[Ended] [date] NULL,
	[SourceRowCount] [int] NULL,
	[DestRowCount] [int] NULL,
	[Inserted] [int] NULL,
	[Updated] [int] NULL,
	[Deleted] [int] NULL,
	[Status] [nvarchar](1) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail]    Script Date: 3/14/2025 9:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWSalesOrderDetail](
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail_Delta]    Script Date: 3/14/2025 9:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWSalesOrderDetail_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AWSalesOrderDetail]    Script Date: 3/14/2025 9:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AWSalesOrderDetail](
	[SalesOrderID] [int] NULL,
	[SalesOrderDetailID] [int] NULL,
	[OrderQty] [smallint] NULL,
	[ProductID] [int] NULL,
	[UnitPrice] [money] NULL,
	[UnitPriceDiscount] [money] NULL,
	[LineTotal] [numeric](38, 6) NULL,
	[rowguid] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [ETL].[RegisterExecution]    Script Date: 3/14/2025 9:24:11 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [ETL].[RegisterExecution] 
    @BATCH_ID INT,
    @PACKAGE_NAME NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CURRENT_TIME DATETIME = GETDATE();
    DECLARE @EXECUTION_ID INT =0;

    -- Check for running packages with the same name and batch ID, except for BATCH_ID = 0
    IF @BATCH_ID <> 0 AND EXISTS (
        SELECT 1 
        FROM [ETL].[Executions] 
        WHERE [BatchID] = @BATCH_ID 
          AND [PackageName] = @PACKAGE_NAME 
          AND [Status] = 'R'
    )
    BEGIN
           SELECT 'E' AS Status, NULL AS EXEC_ID ; 
			-- Indicate an error
        RETURN;
    END

    -- Get next Execution ID from sequence
    SELECT @EXECUTION_ID = NEXT VALUE FOR [ETL].[SeqExecID];

    -- Insert new execution record
    INSERT INTO [ETL].[Executions] (
        [ExecutionId], 
        [BatchID], 
        [PackageName], 
        [Started], 
        [Status]
    ) VALUES (
        @EXECUTION_ID, 
        @BATCH_ID, 
        @PACKAGE_NAME, 
        @CURRENT_TIME, 
        'R'
    );

    -- Set the output status to indicate success
    SELECT 'R' AS Status, @EXECUTION_ID AS EXEC_ID ;
	RETURN 
END;
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to products, customers, sales orders, and sales territories.' , @level0type=N'SCHEMA',@level0name=N'SalesLT'
GO
