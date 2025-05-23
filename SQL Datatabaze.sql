

/****** Object:  Schema [DM]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SCHEMA [DM]
GO
/****** Object:  Schema [ETL]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SCHEMA [ETL]
GO
/****** Object:  Schema [ODS]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SCHEMA [ODS]
GO
/****** Object:  Schema [Stage]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SCHEMA [Stage]
GO
/****** Object:  UserDefinedDataType [dbo].[AccountNumber]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[AccountNumber] FROM [nvarchar](15) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Flag]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[Flag] FROM [bit] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Name]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[Name] FROM [nvarchar](50) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[NameStyle]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[NameStyle] FROM [bit] NOT NULL
GO
/****** Object:  UserDefinedDataType [dbo].[OrderNumber]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[OrderNumber] FROM [nvarchar](25) NULL
GO
/****** Object:  UserDefinedDataType [dbo].[Phone]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE TYPE [dbo].[Phone] FROM [nvarchar](25) NULL
GO

GO
/****** Object:  Sequence [ETL].[SeqBatchID]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SEQUENCE [ETL].[SeqBatchID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO

GO
/****** Object:  Sequence [ETL].[SeqExecID]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SEQUENCE [ETL].[SeqExecID] 
 AS [int]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -2147483648
 MAXVALUE 2147483647
 CACHE 
GO

GO
/****** Object:  Sequence [ETL].[SeqExecutionID]    Script Date: 4/23/2025 10:33:29 AM ******/
CREATE SEQUENCE [ETL].[SeqExecutionID] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  Table [ETL].[Batches]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [ETL].[Executions]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [ODS].[AWAddress]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWAddress](
	[AddressID] [int] NOT NULL,
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
/****** Object:  Table [ODS].[AWAddress_Delta]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWAddress_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[AddressID] [int] NOT NULL,
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
/****** Object:  Table [ODS].[AWProductCategory]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWProductCategory](
	[ProductCategoryID] [int] NULL,
	[ParentProductCategoryID] [int] NULL,
	[Name] [dbo].[Name] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWProductCategory_Delta]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWProductCategory_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[ProductCategoryID] [int] NULL,
	[ParentProductCategoryID] [int] NULL,
	[Name] [dbo].[Name] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWProductModel]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWProductModel](
	[ProductModelID] [int] NULL,
	[Name] [dbo].[Name] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWProductModel_Delta]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[AWProductModel_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[ProductModelID] [int] NULL,
	[Name] [dbo].[Name] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [ODS].[AWSalesOrderDetail]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [ODS].[AWSalesOrderDetail_Delta]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [ODS].[Customer_Delta]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ODS].[Customer_Delta](
	[Action] [nvarchar](16) NULL,
	[Action_LOAD_ID] [int] NULL,
	[CustomerID] [int] NULL,
	[NameStyle] [dbo].[NameStyle] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [dbo].[Name] NOT NULL,
	[MiddleName] [dbo].[Name] NULL,
	[LastName] [dbo].[Name] NOT NULL,
	[Suffix] [nvarchar](10) NULL,
	[CompanyName] [nvarchar](128) NULL,
	[SalesPerson] [nvarchar](256) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[Phone] [dbo].[Phone] NULL,
	[PasswordHash] [varchar](128) NOT NULL,
	[PasswordSalt] [varchar](10) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AWAddress]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [Stage].[AWProductCategory]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AWProductCategory](
	[ProductCategoryID] [int] NULL,
	[ParentProductCategoryID] [int] NULL,
	[Name] [dbo].[Name] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AWProductModel]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[AWProductModel](
	[ProductModelID] [int] NULL,
	[Name] [dbo].[Name] NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [Stage].[AWSalesOrderDetail]    Script Date: 4/23/2025 10:33:29 AM ******/
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
/****** Object:  Table [Stage].[Customer]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Stage].[Customer](
	[CustomerID] [int] NULL,
	[NameStyle] [dbo].[NameStyle] NOT NULL,
	[Title] [nvarchar](8) NULL,
	[FirstName] [dbo].[Name] NOT NULL,
	[MiddleName] [dbo].[Name] NULL,
	[LastName] [dbo].[Name] NOT NULL,
	[Suffix] [nvarchar](10) NULL,
	[CompanyName] [nvarchar](128) NULL,
	[SalesPerson] [nvarchar](256) NULL,
	[EmailAddress] [nvarchar](50) NULL,
	[Phone] [dbo].[Phone] NULL,
	[PasswordHash] [varchar](128) NOT NULL,
	[PasswordSalt] [varchar](10) NOT NULL,
	[rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[ModifiedDate] [datetime] NOT NULL,
	[SOURCE_SYSTEM] [nvarchar](4) NULL,
	[LOAD_DATE] [datetime] NULL,
	[LOAD_ID] [int] NULL,
	[HASH] [nvarchar](32) NULL
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [ETL].[RegisterExecution]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE   PROCEDURE [ETL].[RegisterExecution] 
    @BATCH_ID INT,
    @PACKAGE_NAME NVARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CURRENT_TIME DATETIME = GETDATE();
    DECLARE @EXECUTION_ID INT =0;
	DECLARE @EXECUTION_COUNT INT =0;

	--Select count of of executions
	 SET @EXECUTION_COUNT = 
	 (
	 SELECT COUNT(1)
	 FROM [ETL].[Executions] 
	 WHERE [PackageName] = @PACKAGE_NAME 
	 )





    -- Check for running packages with the same name and batch ID, except for BATCH_ID = 0
    IF @BATCH_ID <> 0 AND EXISTS (
        SELECT 1 
        FROM [ETL].[Executions] 
        WHERE [BatchID] = @BATCH_ID 
          AND [PackageName] = @PACKAGE_NAME 
          AND [Status] = 'R'
    )
    BEGIN
           SELECT 'E' AS Status, NULL AS EXEC_ID, @EXECUTION_COUNT AS ExecutionCount ; 
			-- Indicate an error
        RETURN;
    END



	-- Check for finished packages with the same name and batch ID, except for BATCH_ID = 0
    IF @BATCH_ID <> 0 AND EXISTS (
        SELECT 1 
        FROM [ETL].[Executions] 
        WHERE [BatchID] = @BATCH_ID 
          AND [PackageName] = @PACKAGE_NAME 
          AND [Status] = 'F'
    )
    BEGIN
           SELECT 'F' AS Status, NULL AS EXEC_ID, @EXECUTION_COUNT AS ExecutionCount ; 
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
    SELECT 'R' AS Status, @EXECUTION_ID AS EXEC_ID,@EXECUTION_COUNT As ExecutionCount ;
	RETURN 
END;
GO
/****** Object:  StoredProcedure [ETL].[SetExecutionStatus]    Script Date: 4/23/2025 10:33:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [ETL].[SetExecutionStatus]
    @ExecutionId INT,
    @BatchID INT,
    @Status NVARCHAR(1),
    @SourceRowCount INT,
    @DestRowCount INT,
    @Inserted INT,
    @Updated INT,
    @Deleted INT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @CURRENT_TIME DATETIME = GETDATE();



    -- Update the execution record with the provided parameters
    UPDATE [ETL].[Executions]
    SET 
        [Status] = @Status,
        [SourceRowCount] = @SourceRowCount,
        [DestRowCount] = @DestRowCount,
        [Inserted] = @Inserted,
        [Updated] = @Updated,
        [Deleted] = @Deleted,
        [Ended] = CASE WHEN @Status = 'C' THEN @CURRENT_TIME ELSE [Ended] END
    WHERE 
        [ExecutionId] = @ExecutionId
        AND [BatchID] = @BatchID;

    -- Return the status
    SELECT @Status AS Status;
END;