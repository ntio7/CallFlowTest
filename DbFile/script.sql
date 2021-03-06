USE [master]
GO
/****** Object:  Database [FlowDB]    Script Date: 24/11/2021 12:42:51 ******/
CREATE DATABASE [FlowDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'FlowDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FlowDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'FlowDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\FlowDB_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [FlowDB] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [FlowDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [FlowDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [FlowDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [FlowDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [FlowDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [FlowDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [FlowDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [FlowDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [FlowDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [FlowDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [FlowDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [FlowDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [FlowDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [FlowDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [FlowDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [FlowDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [FlowDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [FlowDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [FlowDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [FlowDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [FlowDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [FlowDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [FlowDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [FlowDB] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [FlowDB] SET  MULTI_USER 
GO
ALTER DATABASE [FlowDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [FlowDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [FlowDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [FlowDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [FlowDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [FlowDB] SET QUERY_STORE = OFF
GO
USE [FlowDB]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 24/11/2021 12:42:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[idNumber] [nvarchar](10) NOT NULL,
	[phone] [nvarchar](10) NOT NULL,
	[firstName] [nvarchar](50) NULL,
	[lastName] [nvarchar](50) NULL,
	[DateOfBirth] [datetime] NULL,
	[comments] [nvarchar](max) NULL,
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

/****** Object:  StoredProcedure [dbo].[SP_CreateUser]    Script Date: 24/11/2021 12:42:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Netanel>
-- Create date: <23.11.2021>
-- Description:	<SP_CreateUser>
-- =============================================
CREATE PROCEDURE [dbo].[SP_CreateUser] 

	@idNumber NVARCHAR(10),
	@phone NVARCHAR(10),
	@firstName NVARCHAR(50),
	@lastName NVARCHAR(50),
	@DateOfBirth datetime,
	@comments NVARCHAR(1000)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF NOT EXISTS(SELECT * FROM [Clients] WHERE [idNumber] = @idNumber)
	BEGIN
		INSERT INTO 
			[Clients] ( [idNumber]
						,[phone]
						,[firstName]
						,[lastName]
						,[DateOfBirth]
						,[comments])
			VALUES (@idNumber, @phone, @firstName, @lastName,@DateOfBirth,@comments)
			SELECT '1' AS [STATUS]
		END
	ELSE 
	    BEGIN
		  UPDATE [Clients]
			 SET [phone] = @phone
				,[firstName] = @firstName
				,[lastName] = @lastName
				,[DateOfBirth] = @DateOfBirth
				,[comments] = @comments
		   WHERE [idNumber] = @idNumber ;
			SELECT '2' AS [STATUS]
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_getFilteredClients]    Script Date: 24/11/2021 12:42:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:		<Netanel>
-- Create date: <23.11.2021>
-- Description:	<GetTitle>
-- =============================================
CREATE PROCEDURE [dbo].[SP_getFilteredClients] 

	@searchParam NVARCHAR(1),
	@searchValue NVARCHAR(100)

AS
BEGIN
	SELECT TOP (1000) [Id]
		  ,[idNumber]
		  ,[phone]
		  ,[firstName]
		  ,[lastName]
		  ,[DateOfBirth]
		  ,[comments]
	  FROM [FlowDB].[dbo].[Clients]
	  WHERE @searchParam = '1' AND [idNumber] LIKE '%'+ @searchValue + '%'
	  OR  @searchParam = '2' AND [phone] LIKE '%'+ @searchValue + '%'
	  
END
GO

