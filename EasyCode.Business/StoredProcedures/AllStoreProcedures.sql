--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description]
) VALUES (
	@ID,
	@SAPType,
	@Description
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Balance decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Balance is null OR [Balances].[Balance] = @Balance)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Balance' and @SortType = 1 THEN [Balances].[Balance] END ASC,
						CASE WHEN @SortBy = 'Balance' and @SortType = 0 THEN [Balances].[Balance] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Balance is null OR [Balances].[Balance] = @Balance)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Balance decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Balance]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Balance
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Balance decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Balance] = @Balance
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Quantity decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [Balances].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [Balances].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Quantity]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Quantity
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Quantity] = @Quantity
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@IsMarketing bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
						AND (@IsMarketing is null OR [Admins].[IsMarketing] = @IsMarketing)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 1 THEN [Admins].[IsMarketing] END ASC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 0 THEN [Admins].[IsMarketing] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
				AND (@IsMarketing is null OR [Admins].[IsMarketing] = @IsMarketing)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit,
	@IsMarketing bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC],
	[IsMarketing]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC,
	@IsMarketing
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit,
	@IsMarketing bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC,
	[IsMarketing] = @IsMarketing
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Quantity decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [Balances].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [Balances].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Quantity]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Quantity
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Quantity] = @Quantity
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Quantity decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [Balances].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [Balances].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Quantity]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Quantity
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Quantity] = @Quantity
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Quantity decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [Balances].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [Balances].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Quantity]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Quantity
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Quantity] = @Quantity
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Admins_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Insert]

IF OBJECT_ID(N'[dbo].[Admins_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Update]

IF OBJECT_ID(N'[dbo].[Admins_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Delete]

IF OBJECT_ID(N'[dbo].[Admins_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Admins_Select]

--endregion

GO


--region [dbo].[Admins_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@AdminID int = null,
	@FullName nvarchar(250) = null,
	@Phone nvarchar(50) = null,
	@UserName nvarchar(100) = null,
	@PassWord nvarchar(1000) = null,
	@Email nvarchar(255) = null,
	@IsAdmin bit = null,
	@ZIPCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Admins]
					WHERE
					(
						(@AdminID is null OR [Admins].[AdminID] = @AdminID)
						AND (@FullName is null OR [Admins].[FullName] like @FullName)
						AND (@Phone is null OR [Admins].[Phone] like @Phone)
						AND (@UserName is null OR [Admins].[UserName] like @UserName)
						AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
						AND (@Email is null OR [Admins].[Email] like @Email)
						AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
						AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
						AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Admins].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 1 THEN [Admins].[AdminID] END ASC,
						CASE WHEN @SortBy = 'AdminID' and @SortType = 0 THEN [Admins].[AdminID] END DESC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 1 THEN [Admins].[FullName] END ASC,
						CASE WHEN @SortBy = 'FullName' and @SortType = 0 THEN [Admins].[FullName] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Admins].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Admins].[Phone] END DESC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 1 THEN [Admins].[UserName] END ASC,
						CASE WHEN @SortBy = 'UserName' and @SortType = 0 THEN [Admins].[UserName] END DESC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 1 THEN [Admins].[PassWord] END ASC,
						CASE WHEN @SortBy = 'PassWord' and @SortType = 0 THEN [Admins].[PassWord] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Admins].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Admins].[Email] END DESC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 1 THEN [Admins].[IsAdmin] END ASC,
						CASE WHEN @SortBy = 'IsAdmin' and @SortType = 0 THEN [Admins].[IsAdmin] END DESC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 1 THEN [Admins].[ZIPCode] END ASC,
						CASE WHEN @SortBy = 'ZIPCode' and @SortType = 0 THEN [Admins].[ZIPCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Admins].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Admins].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Admins].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Admins].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Admins].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Admins].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Admins].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Admins].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Admins]
			Where 
			(
				(@AdminID is null OR [Admins].[AdminID] = @AdminID)
				AND (@FullName is null OR [Admins].[FullName] like @FullName)
				AND (@Phone is null OR [Admins].[Phone] like @Phone)
				AND (@UserName is null OR [Admins].[UserName] like @UserName)
				AND (@PassWord is null OR [Admins].[PassWord] like @PassWord)
				AND (@Email is null OR [Admins].[Email] like @Email)
				AND (@IsAdmin is null OR [Admins].[IsAdmin] = @IsAdmin)
				AND (@ZIPCode is null OR [Admins].[ZIPCode] like @ZIPCode)
				AND (@ZO1 is null OR [Admins].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Admins].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Admins].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Admins].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Admins_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Admins_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Insert]
	@AdminID int OUTPUT,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit

AS


INSERT INTO [dbo].[Admins] 
(
	[FullName],
	[Phone],
	[UserName],
	[PassWord],
	[Email],
	[IsAdmin],
	[ZIPCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC]
)
VALUES 
(
	@FullName,
	@Phone,
	@UserName,
	@PassWord,
	@Email,
	@IsAdmin,
	@ZIPCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC
)

SET @AdminID = SCOPE_IDENTITY()

--end [dbo].[Admins_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Update]
	@AdminID int,
	@FullName nvarchar(250),
	@Phone nvarchar(50),
	@UserName nvarchar(100),
	@PassWord nvarchar(1000),
	@Email nvarchar(255),
	@IsAdmin bit,
	@ZIPCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit
AS


UPDATE [dbo].[Admins] SET
	[FullName] = @FullName,
	[Phone] = @Phone,
	[UserName] = @UserName,
	[PassWord] = @PassWord,
	[Email] = @Email,
	[IsAdmin] = @IsAdmin,
	[ZIPCode] = @ZIPCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC
WHERE
	[AdminID] = @AdminID

--end [dbo].[Admins_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Admins_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Admins_Delete]
	@AdminID int
AS


DELETE FROM [dbo].[Admins]
WHERE
(
	[AdminID] = @AdminID
)

--end [dbo].[Admins_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ApproveLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Insert]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Update]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Delete]

IF OBJECT_ID(N'[dbo].[ApproveLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ApproveLogs_Select]

--endregion

GO


--region [dbo].[ApproveLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ApproveLogs]
					WHERE
					(
						(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
						AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ApproveLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ApproveLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [ApproveLogs].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [ApproveLogs].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [ApproveLogs].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [ApproveLogs].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ApproveLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ApproveLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ApproveLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ApproveLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ApproveLogs]
			Where 
			(
				(@CreateDate is null OR [ApproveLogs].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [ApproveLogs].[CreateBy] = @CreateBy)
				AND (@OrderID is null OR [ApproveLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ApproveLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ApproveLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ApproveLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Insert]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ApproveLogs] (
	[CreateDate],
	[CreateBy],
	[OrderID],
	[Note]
) VALUES (
	@CreateDate,
	@CreateBy,
	@OrderID,
	@Note
)

--end [dbo].[ApproveLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Update]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ApproveLogs] SET
	[Note] = @Note
WHERE
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID

--end [dbo].[ApproveLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ApproveLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ApproveLogs_Delete]
	@CreateDate datetime,
	@CreateBy int,
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ApproveLogs]
WHERE
(
	[CreateDate] = @CreateDate
	AND [CreateBy] = @CreateBy
	AND [OrderID] = @OrderID
)

--end [dbo].[ApproveLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Article_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Insert]

IF OBJECT_ID(N'[dbo].[Article_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Update]

IF OBJECT_ID(N'[dbo].[Article_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Delete]

IF OBJECT_ID(N'[dbo].[Article_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Article_Select]

--endregion

GO


--region [dbo].[Article_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@MaBC varchar(18) = null,
	@MaHH nvarchar(14) = null,
	@TenHH nvarchar(250) = null,
	@MaNhom varchar(3) = null,
	@Ma_Nhom varchar(2) = null,
	@HangCham varchar(2) = null,
	@DVT varchar(3) = null,
	@DonGia numeric(18, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Article]
					WHERE
					(
						(@MaBC is null OR [Article].[MaBC] like @MaBC)
						AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
						AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
						AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
						AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
						AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
						AND (@DVT is null OR [Article].[DVT] like @DVT)
						AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Article].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 1 THEN [Article].[MaBC] END ASC,
						CASE WHEN @SortBy = 'MaBC' and @SortType = 0 THEN [Article].[MaBC] END DESC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 1 THEN [Article].[MaHH] END ASC,
						CASE WHEN @SortBy = 'MaHH' and @SortType = 0 THEN [Article].[MaHH] END DESC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 1 THEN [Article].[TenHH] END ASC,
						CASE WHEN @SortBy = 'TenHH' and @SortType = 0 THEN [Article].[TenHH] END DESC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 1 THEN [Article].[MaNhom] END ASC,
						CASE WHEN @SortBy = 'MaNhom' and @SortType = 0 THEN [Article].[MaNhom] END DESC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 1 THEN [Article].[Ma_Nhom] END ASC,
						CASE WHEN @SortBy = 'Ma_Nhom' and @SortType = 0 THEN [Article].[Ma_Nhom] END DESC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 1 THEN [Article].[HangCham] END ASC,
						CASE WHEN @SortBy = 'HangCham' and @SortType = 0 THEN [Article].[HangCham] END DESC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 1 THEN [Article].[DVT] END ASC,
						CASE WHEN @SortBy = 'DVT' and @SortType = 0 THEN [Article].[DVT] END DESC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 1 THEN [Article].[DonGia] END ASC,
						CASE WHEN @SortBy = 'DonGia' and @SortType = 0 THEN [Article].[DonGia] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Article]
			Where 
			(
				(@MaBC is null OR [Article].[MaBC] like @MaBC)
				AND (@MaHH is null OR [Article].[MaHH] like @MaHH)
				AND (@TenHH is null OR [Article].[TenHH] like @TenHH)
				AND (@MaNhom is null OR [Article].[MaNhom] like @MaNhom)
				AND (@Ma_Nhom is null OR [Article].[Ma_Nhom] like @Ma_Nhom)
				AND (@HangCham is null OR [Article].[HangCham] like @HangCham)
				AND (@DVT is null OR [Article].[DVT] like @DVT)
				AND (@DonGia is null OR [Article].[DonGia] = @DonGia)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Article_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Article_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Insert]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


INSERT INTO [dbo].[Article] (
	[MaBC],
	[MaHH],
	[TenHH],
	[MaNhom],
	[Ma_Nhom],
	[HangCham],
	[DVT],
	[DonGia]
) VALUES (
	@MaBC,
	@MaHH,
	@TenHH,
	@MaNhom,
	@Ma_Nhom,
	@HangCham,
	@DVT,
	@DonGia
)

--end [dbo].[Article_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Update]
	@MaBC varchar(18),
	@MaHH nvarchar(14),
	@TenHH nvarchar(250),
	@MaNhom varchar(3),
	@Ma_Nhom varchar(2),
	@HangCham varchar(2),
	@DVT varchar(3),
	@DonGia numeric(18, 0)
AS


UPDATE [dbo].[Article] SET
	[MaBC] = @MaBC,
	[TenHH] = @TenHH,
	[MaNhom] = @MaNhom,
	[Ma_Nhom] = @Ma_Nhom,
	[HangCham] = @HangCham,
	[DVT] = @DVT,
	[DonGia] = @DonGia
WHERE
	[MaHH] = @MaHH

--end [dbo].[Article_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Article_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Article_Delete]
	@MaHH nvarchar(14)
AS


DELETE FROM [dbo].[Article]
WHERE
(
	[MaHH] = @MaHH
)

--end [dbo].[Article_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Balances_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Insert]

IF OBJECT_ID(N'[dbo].[Balances_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Update]

IF OBJECT_ID(N'[dbo].[Balances_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Delete]

IF OBJECT_ID(N'[dbo].[Balances_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Balances_Select]

--endregion

GO


--region [dbo].[Balances_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@WareHouseID nvarchar(50) = null,
	@Site nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@Quantity decimal(18, 4) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Balances]
					WHERE
					(
						(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
						AND (@Site is null OR [Balances].[Site] like @Site)
						AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
						AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Balances].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [Balances].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [Balances].[WareHouseID] END DESC,
						CASE WHEN @SortBy = 'Site' and @SortType = 1 THEN [Balances].[Site] END ASC,
						CASE WHEN @SortBy = 'Site' and @SortType = 0 THEN [Balances].[Site] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Balances].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Balances].[ItemID] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [Balances].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [Balances].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Balances]
			Where 
			(
				(@WareHouseID is null OR [Balances].[WareHouseID] like @WareHouseID)
				AND (@Site is null OR [Balances].[Site] like @Site)
				AND (@ItemID is null OR [Balances].[ItemID] like @ItemID)
				AND (@Quantity is null OR [Balances].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Balances_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Balances_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Insert]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


INSERT INTO [dbo].[Balances] (
	[WareHouseID],
	[Site],
	[ItemID],
	[Quantity]
) VALUES (
	@WareHouseID,
	@Site,
	@ItemID,
	@Quantity
)

--end [dbo].[Balances_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Update]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50),
	@Quantity decimal(18, 4)
AS


UPDATE [dbo].[Balances] SET
	[Quantity] = @Quantity
WHERE
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID

--end [dbo].[Balances_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Balances_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Balances_Delete]
	@WareHouseID nvarchar(50),
	@Site nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Balances]
WHERE
(
	[WareHouseID] = @WareHouseID
	AND [Site] = @Site
	AND [ItemID] = @ItemID
)

--end [dbo].[Balances_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Colors_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Insert]

IF OBJECT_ID(N'[dbo].[Colors_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Update]

IF OBJECT_ID(N'[dbo].[Colors_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Delete]

IF OBJECT_ID(N'[dbo].[Colors_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Colors_Select]

--endregion

GO


--region [dbo].[Colors_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ColorID nvarchar(50) = null,
	@ColorName nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Colors]
					WHERE
					(
						(@ColorID is null OR [Colors].[ColorID] like @ColorID)
						AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Colors].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 1 THEN [Colors].[ColorID] END ASC,
						CASE WHEN @SortBy = 'ColorID' and @SortType = 0 THEN [Colors].[ColorID] END DESC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 1 THEN [Colors].[ColorName] END ASC,
						CASE WHEN @SortBy = 'ColorName' and @SortType = 0 THEN [Colors].[ColorName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Colors]
			Where 
			(
				(@ColorID is null OR [Colors].[ColorID] like @ColorID)
				AND (@ColorName is null OR [Colors].[ColorName] like @ColorName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Colors_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Colors_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Insert]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


INSERT INTO [dbo].[Colors] (
	[ColorID],
	[ColorName]
) VALUES (
	@ColorID,
	@ColorName
)

--end [dbo].[Colors_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Update]
	@ColorID nvarchar(50),
	@ColorName nvarchar(50)
AS


UPDATE [dbo].[Colors] SET
	[ColorName] = @ColorName
WHERE
	[ColorID] = @ColorID

--end [dbo].[Colors_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Colors_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Colors_Delete]
	@ColorID nvarchar(50)
AS


DELETE FROM [dbo].[Colors]
WHERE
(
	[ColorID] = @ColorID
)

--end [dbo].[Colors_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Customers_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Insert]

IF OBJECT_ID(N'[dbo].[Customers_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Update]

IF OBJECT_ID(N'[dbo].[Customers_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Delete]

IF OBJECT_ID(N'[dbo].[Customers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Customers_Select]

--endregion

GO


--region [dbo].[Customers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(250) = null,
	@CustomerName nvarchar(250) = null,
	@Address nvarchar(250) = null,
	@CustomerType nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Phone nvarchar(50) = null,
	@Email nvarchar(50) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@IsMarketing bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Customers]
					WHERE
					(
						(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [Customers].[Address] like @Address)
						AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [Customers].[Password] like @Password)
						AND (@Phone is null OR [Customers].[Phone] like @Phone)
						AND (@Email is null OR [Customers].[Email] like @Email)
						AND (@Area is null OR [Customers].[Area] like @Area)
						AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
						AND (@IsMarketing is null OR [Customers].[IsMarketing] = @IsMarketing)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Customers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Customers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Customers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [Customers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [Customers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [Customers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [Customers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [Customers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [Customers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Customers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Customers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [Customers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [Customers].[Phone] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [Customers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [Customers].[Email] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [Customers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [Customers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [Customers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [Customers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [Customers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [Customers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [Customers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [Customers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [Customers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [Customers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [Customers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [Customers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 1 THEN [Customers].[IsMarketing] END ASC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 0 THEN [Customers].[IsMarketing] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Customers]
			Where 
			(
				(@CustomerID is null OR [Customers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [Customers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [Customers].[Address] like @Address)
				AND (@CustomerType is null OR [Customers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [Customers].[Password] like @Password)
				AND (@Phone is null OR [Customers].[Phone] like @Phone)
				AND (@Email is null OR [Customers].[Email] like @Email)
				AND (@Area is null OR [Customers].[Area] like @Area)
				AND (@ZipCode is null OR [Customers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [Customers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [Customers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [Customers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [Customers].[ZOC] = @ZOC)
				AND (@IsMarketing is null OR [Customers].[IsMarketing] = @IsMarketing)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Customers_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Customers_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Insert]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit,
	@IsMarketing bit
AS


INSERT INTO [dbo].[Customers] (
	[CustomerID],
	[CustomerName],
	[Address],
	[CustomerType],
	[Password],
	[Phone],
	[Email],
	[Area],
	[ZipCode],
	[ZO1],
	[ZOD],
	[ZO2],
	[ZOC],
	[IsMarketing]
) VALUES (
	@CustomerID,
	@CustomerName,
	@Address,
	@CustomerType,
	@Password,
	@Phone,
	@Email,
	@Area,
	@ZipCode,
	@ZO1,
	@ZOD,
	@ZO2,
	@ZOC,
	@IsMarketing
)

--end [dbo].[Customers_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Update]
	@CustomerID nvarchar(250),
	@CustomerName nvarchar(250),
	@Address nvarchar(250),
	@CustomerType nvarchar(50),
	@Password nvarchar(50),
	@Phone nvarchar(50),
	@Email nvarchar(50),
	@Area nvarchar(50),
	@ZipCode nvarchar(50),
	@ZO1 bit,
	@ZOD bit,
	@ZO2 bit,
	@ZOC bit,
	@IsMarketing bit
AS


UPDATE [dbo].[Customers] SET
	[CustomerName] = @CustomerName,
	[Address] = @Address,
	[CustomerType] = @CustomerType,
	[Password] = @Password,
	[Phone] = @Phone,
	[Email] = @Email,
	[Area] = @Area,
	[ZipCode] = @ZipCode,
	[ZO1] = @ZO1,
	[ZOD] = @ZOD,
	[ZO2] = @ZO2,
	[ZOC] = @ZOC,
	[IsMarketing] = @IsMarketing
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[Customers_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Customers_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Customers_Delete]
	@CustomerID nvarchar(250)
AS


DELETE FROM [dbo].[Customers]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[Customers_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerSigns_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Insert]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Update]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Delete]

IF OBJECT_ID(N'[dbo].[CustomerSigns_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerSigns_Select]

--endregion

GO


--region [dbo].[CustomerSigns_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerID nvarchar(50) = null,
	@SignImage image = null,
	@Ext nvarchar(5) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerSigns]
					WHERE
					(
						(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
						AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerSigns].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [CustomerSigns].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [CustomerSigns].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 1 THEN [CustomerSigns].[SignImage] END ASC,
						CASE WHEN @SortBy = 'SignImage' and @SortType = 0 THEN [CustomerSigns].[SignImage] END DESC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 1 THEN [CustomerSigns].[Ext] END ASC,
						CASE WHEN @SortBy = 'Ext' and @SortType = 0 THEN [CustomerSigns].[Ext] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerSigns]
			Where 
			(
				(@CustomerID is null OR [CustomerSigns].[CustomerID] like @CustomerID)
				AND (@Ext is null OR [CustomerSigns].[Ext] like @Ext)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerSigns_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerSigns_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Insert]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


INSERT INTO [dbo].[CustomerSigns] (
	[CustomerID],
	[SignImage],
	[Ext]
) VALUES (
	@CustomerID,
	@SignImage,
	@Ext
)

--end [dbo].[CustomerSigns_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Update]
	@CustomerID nvarchar(50),
	@SignImage image,
	@Ext nvarchar(5)
AS


UPDATE [dbo].[CustomerSigns] SET
	[SignImage] = @SignImage,
	[Ext] = @Ext
WHERE
	[CustomerID] = @CustomerID

--end [dbo].[CustomerSigns_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerSigns_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerSigns_Delete]
	@CustomerID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerSigns]
WHERE
(
	[CustomerID] = @CustomerID
)

--end [dbo].[CustomerSigns_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[CustomerTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Insert]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Update]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Delete]

IF OBJECT_ID(N'[dbo].[CustomerTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[CustomerTypes_Select]

--endregion

GO


--region [dbo].[CustomerTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CustomerTypeID nvarchar(50) = null,
	@CustomerTypeName nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[CustomerTypes]
					WHERE
					(
						(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
						AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[CustomerTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeID] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeID' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeID] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [CustomerTypes].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [CustomerTypes].[CustomerTypeName] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[CustomerTypes]
			Where 
			(
				(@CustomerTypeID is null OR [CustomerTypes].[CustomerTypeID] like @CustomerTypeID)
				AND (@CustomerTypeName is null OR [CustomerTypes].[CustomerTypeName] like @CustomerTypeName)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[CustomerTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[CustomerTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Insert]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


INSERT INTO [dbo].[CustomerTypes] (
	[CustomerTypeID],
	[CustomerTypeName]
) VALUES (
	@CustomerTypeID,
	@CustomerTypeName
)

--end [dbo].[CustomerTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Update]
	@CustomerTypeID nvarchar(50),
	@CustomerTypeName nvarchar(250)
AS


UPDATE [dbo].[CustomerTypes] SET
	[CustomerTypeName] = @CustomerTypeName
WHERE
	[CustomerTypeID] = @CustomerTypeID

--end [dbo].[CustomerTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[CustomerTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[CustomerTypes_Delete]
	@CustomerTypeID nvarchar(50)
AS


DELETE FROM [dbo].[CustomerTypes]
WHERE
(
	[CustomerTypeID] = @CustomerTypeID
)

--end [dbo].[CustomerTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Items_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Insert]

IF OBJECT_ID(N'[dbo].[Items_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Update]

IF OBJECT_ID(N'[dbo].[Items_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Delete]

IF OBJECT_ID(N'[dbo].[Items_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Items_Select]

--endregion

GO


--region [dbo].[Items_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
	@StockSAP decimal(18, 0) = null,
	@OrderQuantity decimal(18, 0) = null,
	@UnitPrice money = null,
	@UoM nvarchar(50) = null,
	@ItemType nvarchar(50) = null,
	@ThumbImage nvarchar(250) = null,
	@Sex bit = null,
	@IsNew bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Items]
					WHERE
					(
						(@ItemID is null OR [Items].[ItemID] like @ItemID)
						AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
						AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
						AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
						AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
						AND (@UoM is null OR [Items].[UoM] like @UoM)
						AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
						AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
						AND (@Sex is null OR [Items].[Sex] = @Sex)
						AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Items].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [Items].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [Items].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [Items].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [Items].[ItemName] END DESC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 1 THEN [Items].[StockSAP] END ASC,
						CASE WHEN @SortBy = 'StockSAP' and @SortType = 0 THEN [Items].[StockSAP] END DESC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 1 THEN [Items].[OrderQuantity] END ASC,
						CASE WHEN @SortBy = 'OrderQuantity' and @SortType = 0 THEN [Items].[OrderQuantity] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [Items].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [Items].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [Items].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [Items].[UoM] END DESC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 1 THEN [Items].[ItemType] END ASC,
						CASE WHEN @SortBy = 'ItemType' and @SortType = 0 THEN [Items].[ItemType] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [Items].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [Items].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 1 THEN [Items].[Sex] END ASC,
						CASE WHEN @SortBy = 'Sex' and @SortType = 0 THEN [Items].[Sex] END DESC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 1 THEN [Items].[IsNew] END ASC,
						CASE WHEN @SortBy = 'IsNew' and @SortType = 0 THEN [Items].[IsNew] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Items]
			Where 
			(
				(@ItemID is null OR [Items].[ItemID] like @ItemID)
				AND (@ItemName is null OR [Items].[ItemName] like @ItemName)
				AND (@StockSAP is null OR [Items].[StockSAP] = @StockSAP)
				AND (@OrderQuantity is null OR [Items].[OrderQuantity] = @OrderQuantity)
				AND (@UnitPrice is null OR [Items].[UnitPrice] = @UnitPrice)
				AND (@UoM is null OR [Items].[UoM] like @UoM)
				AND (@ItemType is null OR [Items].[ItemType] like @ItemType)
				AND (@ThumbImage is null OR [Items].[ThumbImage] like @ThumbImage)
				AND (@Sex is null OR [Items].[Sex] = @Sex)
				AND (@IsNew is null OR [Items].[IsNew] = @IsNew)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Items_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Items_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Insert]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


INSERT INTO [dbo].[Items] (
	[ItemID],
	[ItemName],
	[StockSAP],
	[OrderQuantity],
	[UnitPrice],
	[UoM],
	[ItemType],
	[ThumbImage],
	[Sex],
	[IsNew]
) VALUES (
	@ItemID,
	@ItemName,
	@StockSAP,
	@OrderQuantity,
	@UnitPrice,
	@UoM,
	@ItemType,
	@ThumbImage,
	@Sex,
	@IsNew
)

--end [dbo].[Items_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Update]
	@ItemID nvarchar(50),
	@ItemName nvarchar(250),
	@StockSAP decimal(18, 0),
	@OrderQuantity decimal(18, 0),
	@UnitPrice money,
	@UoM nvarchar(50),
	@ItemType nvarchar(50),
	@ThumbImage nvarchar(250),
	@Sex bit,
	@IsNew bit
AS


UPDATE [dbo].[Items] SET
	[ItemName] = @ItemName,
	[StockSAP] = @StockSAP,
	[OrderQuantity] = @OrderQuantity,
	[UnitPrice] = @UnitPrice,
	[UoM] = @UoM,
	[ItemType] = @ItemType,
	[ThumbImage] = @ThumbImage,
	[Sex] = @Sex,
	[IsNew] = @IsNew
WHERE
	[ItemID] = @ItemID

--end [dbo].[Items_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Items_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Items_Delete]
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[Items]
WHERE
(
	[ItemID] = @ItemID
)

--end [dbo].[Items_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Keys_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Insert]

IF OBJECT_ID(N'[dbo].[Keys_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Update]

IF OBJECT_ID(N'[dbo].[Keys_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Delete]

IF OBJECT_ID(N'[dbo].[Keys_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Keys_Select]

--endregion

GO


--region [dbo].[Keys_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@CreateDate datetime = null,
	@MaxNumber int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Keys]
					WHERE
					(
						(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
						AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Keys].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Keys].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Keys].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 1 THEN [Keys].[MaxNumber] END ASC,
						CASE WHEN @SortBy = 'MaxNumber' and @SortType = 0 THEN [Keys].[MaxNumber] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Keys]
			Where 
			(
				(@CreateDate is null OR [Keys].[CreateDate] = @CreateDate)
				AND (@MaxNumber is null OR [Keys].[MaxNumber] = @MaxNumber)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Keys_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Keys_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Insert]
	@CreateDate datetime,
	@MaxNumber int
AS


INSERT INTO [dbo].[Keys] (
	[CreateDate],
	[MaxNumber]
) VALUES (
	@CreateDate,
	@MaxNumber
)

--end [dbo].[Keys_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Update]
	@CreateDate datetime,
	@MaxNumber int
AS


UPDATE [dbo].[Keys] SET
	[MaxNumber] = @MaxNumber
WHERE
	[CreateDate] = @CreateDate

--end [dbo].[Keys_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Keys_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Keys_Delete]
	@CreateDate datetime
AS


DELETE FROM [dbo].[Keys]
WHERE
(
	[CreateDate] = @CreateDate
)

--end [dbo].[Keys_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[l_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Insert]

IF OBJECT_ID(N'[dbo].[l_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Update]

IF OBJECT_ID(N'[dbo].[l_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Delete]

IF OBJECT_ID(N'[dbo].[l_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[l_Select]

--endregion

GO


--region [dbo].[l_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@id int = null,
	@content ntext = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[l]
					WHERE
					(
						(@id is null OR [l].[id] = @id)
						AND (@content is null OR [l].[content] like @content)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[l].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 1 THEN [l].[id] END ASC,
						CASE WHEN @SortBy = 'id' and @SortType = 0 THEN [l].[id] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[l]
			Where 
			(
				(@id is null OR [l].[id] = @id)
				AND (@content is null OR [l].[content] like @content)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[l_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[l_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Insert]
	@id int OUTPUT,
	@content ntext

AS


INSERT INTO [dbo].[l] 
(
	[content]
)
VALUES 
(
	@content
)

SET @id = SCOPE_IDENTITY()

--end [dbo].[l_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Update]
	@id int,
	@content ntext
AS


UPDATE [dbo].[l] SET
	[content] = @content
WHERE
	[id] = @id

--end [dbo].[l_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[l_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[l_Delete]
	@id int
AS


DELETE FROM [dbo].[l]
WHERE
(
	[id] = @id
)

--end [dbo].[l_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[ModifyLogs_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Insert]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Update]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Delete]

IF OBJECT_ID(N'[dbo].[ModifyLogs_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[ModifyLogs_Select]

--endregion

GO


--region [dbo].[ModifyLogs_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ModifyDate datetime = null,
	@ModifyUserID int = null,
	@CustomerID nvarchar(50) = null,
	@OrderID nvarchar(50) = null,
	@Note nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[ModifyLogs]
					WHERE
					(
						(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
						AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
						AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
						AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
						AND (@Note is null OR [ModifyLogs].[Note] like @Note)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[ModifyLogs].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 1 THEN [ModifyLogs].[ModifyDate] END ASC,
						CASE WHEN @SortBy = 'ModifyDate' and @SortType = 0 THEN [ModifyLogs].[ModifyDate] END DESC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 1 THEN [ModifyLogs].[ModifyUserID] END ASC,
						CASE WHEN @SortBy = 'ModifyUserID' and @SortType = 0 THEN [ModifyLogs].[ModifyUserID] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [ModifyLogs].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [ModifyLogs].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [ModifyLogs].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [ModifyLogs].[OrderID] END DESC,
						CASE WHEN @SortBy = 'Note' and @SortType = 1 THEN [ModifyLogs].[Note] END ASC,
						CASE WHEN @SortBy = 'Note' and @SortType = 0 THEN [ModifyLogs].[Note] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[ModifyLogs]
			Where 
			(
				(@ModifyDate is null OR [ModifyLogs].[ModifyDate] = @ModifyDate)
				AND (@ModifyUserID is null OR [ModifyLogs].[ModifyUserID] = @ModifyUserID)
				AND (@CustomerID is null OR [ModifyLogs].[CustomerID] like @CustomerID)
				AND (@OrderID is null OR [ModifyLogs].[OrderID] like @OrderID)
				AND (@Note is null OR [ModifyLogs].[Note] like @Note)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[ModifyLogs_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[ModifyLogs_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Insert]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


INSERT INTO [dbo].[ModifyLogs] (
	[ModifyDate],
	[ModifyUserID],
	[CustomerID],
	[OrderID],
	[Note]
) VALUES (
	@ModifyDate,
	@ModifyUserID,
	@CustomerID,
	@OrderID,
	@Note
)

--end [dbo].[ModifyLogs_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Update]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50),
	@Note nvarchar(50)
AS


UPDATE [dbo].[ModifyLogs] SET
	[Note] = @Note
WHERE
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID

--end [dbo].[ModifyLogs_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[ModifyLogs_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[ModifyLogs_Delete]
	@ModifyDate datetime,
	@ModifyUserID int,
	@CustomerID nvarchar(50),
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[ModifyLogs]
WHERE
(
	[ModifyDate] = @ModifyDate
	AND [ModifyUserID] = @ModifyUserID
	AND [CustomerID] = @CustomerID
	AND [OrderID] = @OrderID
)

--end [dbo].[ModifyLogs_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderDetail_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Insert]

IF OBJECT_ID(N'[dbo].[OrderDetail_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Update]

IF OBJECT_ID(N'[dbo].[OrderDetail_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Delete]

IF OBJECT_ID(N'[dbo].[OrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderDetail_Select]

--endregion

GO


--region [dbo].[OrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@UoM nvarchar(50) = null,
	@UnitPrice money = null,
	@Quantity decimal(18, 0) = null,
	@Discount decimal(8, 4) = null,
	@TotalAmount money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderDetail]
					WHERE
					(
						(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
						AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [OrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [OrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [OrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [OrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [OrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [OrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [OrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [OrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [OrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [OrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [OrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [OrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [OrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [OrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [OrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [OrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderDetail]
			Where 
			(
				(@OrderNo is null OR [OrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [OrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [OrderDetail].[ItemID] like @ItemID)
				AND (@UoM is null OR [OrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [OrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [OrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [OrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [OrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderDetail_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderDetail_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Insert]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


INSERT INTO [dbo].[OrderDetail] (
	[OrderNo],
	[OrderID],
	[ItemID],
	[UoM],
	[UnitPrice],
	[Quantity],
	[Discount],
	[TotalAmount]
) VALUES (
	@OrderNo,
	@OrderID,
	@ItemID,
	@UoM,
	@UnitPrice,
	@Quantity,
	@Discount,
	@TotalAmount
)

--end [dbo].[OrderDetail_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Update]
	@OrderNo int,
	@OrderID nvarchar(50),
	@ItemID nvarchar(50),
	@UoM nvarchar(50),
	@UnitPrice money,
	@Quantity decimal(18, 0),
	@Discount decimal(8, 4),
	@TotalAmount money
AS


UPDATE [dbo].[OrderDetail] SET
	[OrderNo] = @OrderNo,
	[UoM] = @UoM,
	[UnitPrice] = @UnitPrice,
	[Quantity] = @Quantity,
	[Discount] = @Discount,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID

--end [dbo].[OrderDetail_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderDetail_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderDetail_Delete]
	@OrderID nvarchar(50),
	@ItemID nvarchar(50)
AS


DELETE FROM [dbo].[OrderDetail]
WHERE
(
	[OrderID] = @OrderID
	AND [ItemID] = @ItemID
)

--end [dbo].[OrderDetail_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Orders_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Insert]

IF OBJECT_ID(N'[dbo].[Orders_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Update]

IF OBJECT_ID(N'[dbo].[Orders_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Delete]

IF OBJECT_ID(N'[dbo].[Orders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Orders_Select]

--endregion

GO


--region [dbo].[Orders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Orders]
					WHERE
					(
						(@OrderID is null OR [Orders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
						AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
						AND (@Status is null OR [Orders].[Status] = @Status)
						AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Orders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [Orders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [Orders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [Orders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [Orders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [Orders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [Orders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [Orders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [Orders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [Orders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [Orders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [Orders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [Orders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [Orders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [Orders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [Orders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [Orders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [Orders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [Orders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [Orders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [Orders].[CreateBy] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Orders]
			Where 
			(
				(@OrderID is null OR [Orders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [Orders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [Orders].[CustomerID] like @CustomerID)
				AND (@DeliveryAddress is null OR [Orders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [Orders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [Orders].[Ref2] like @Ref2)
				AND (@Status is null OR [Orders].[Status] = @Status)
				AND (@TotalAmount is null OR [Orders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [Orders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [Orders].[CreateBy] = @CreateBy)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Orders_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Orders_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Insert]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


INSERT INTO [dbo].[Orders] (
	[OrderID],
	[OrderType],
	[CustomerID],
	[DeliveryAddress],
	[SAPOrderNumber],
	[Ref2],
	[Status],
	[TotalAmount],
	[CreateDate],
	[CreateBy]
) VALUES (
	@OrderID,
	@OrderType,
	@CustomerID,
	@DeliveryAddress,
	@SAPOrderNumber,
	@Ref2,
	@Status,
	@TotalAmount,
	@CreateDate,
	@CreateBy
)

--end [dbo].[Orders_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Update]
	@OrderID nvarchar(50),
	@OrderType nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@SAPOrderNumber nvarchar(50),
	@Ref2 nvarchar(50),
	@Status int,
	@TotalAmount money,
	@CreateDate datetime,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[OrderType] = @OrderType,
	[CustomerID] = @CustomerID,
	[DeliveryAddress] = @DeliveryAddress,
	[SAPOrderNumber] = @SAPOrderNumber,
	[Ref2] = @Ref2,
	[Status] = @Status,
	[TotalAmount] = @TotalAmount,
	[CreateDate] = @CreateDate,
	[CreateBy] = @CreateBy
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Orders_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Orders_Delete]
	@OrderID nvarchar(50)
AS


DELETE FROM [dbo].[Orders]
WHERE
(
	[OrderID] = @OrderID
)

--end [dbo].[Orders_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[OrderTypes_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Insert]

IF OBJECT_ID(N'[dbo].[OrderTypes_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Update]

IF OBJECT_ID(N'[dbo].[OrderTypes_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Delete]

IF OBJECT_ID(N'[dbo].[OrderTypes_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[OrderTypes_Select]

--endregion

GO


--region [dbo].[OrderTypes_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID nvarchar(50) = null,
	@SAPType nvarchar(50) = null,
	@Description nvarchar(250) = null,
	@WareHouseID nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[OrderTypes]
					WHERE
					(
						(@ID is null OR [OrderTypes].[ID] like @ID)
						AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
						AND (@Description is null OR [OrderTypes].[Description] like @Description)
						AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[OrderTypes].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [OrderTypes].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [OrderTypes].[ID] END DESC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 1 THEN [OrderTypes].[SAPType] END ASC,
						CASE WHEN @SortBy = 'SAPType' and @SortType = 0 THEN [OrderTypes].[SAPType] END DESC,
						CASE WHEN @SortBy = 'Description' and @SortType = 1 THEN [OrderTypes].[Description] END ASC,
						CASE WHEN @SortBy = 'Description' and @SortType = 0 THEN [OrderTypes].[Description] END DESC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 1 THEN [OrderTypes].[WareHouseID] END ASC,
						CASE WHEN @SortBy = 'WareHouseID' and @SortType = 0 THEN [OrderTypes].[WareHouseID] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[OrderTypes]
			Where 
			(
				(@ID is null OR [OrderTypes].[ID] like @ID)
				AND (@SAPType is null OR [OrderTypes].[SAPType] like @SAPType)
				AND (@Description is null OR [OrderTypes].[Description] like @Description)
				AND (@WareHouseID is null OR [OrderTypes].[WareHouseID] like @WareHouseID)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[OrderTypes_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[OrderTypes_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Insert]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


INSERT INTO [dbo].[OrderTypes] (
	[ID],
	[SAPType],
	[Description],
	[WareHouseID]
) VALUES (
	@ID,
	@SAPType,
	@Description,
	@WareHouseID
)

--end [dbo].[OrderTypes_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Update]
	@ID nvarchar(50),
	@SAPType nvarchar(50),
	@Description nvarchar(250),
	@WareHouseID nvarchar(50)
AS


UPDATE [dbo].[OrderTypes] SET
	[SAPType] = @SAPType,
	[Description] = @Description,
	[WareHouseID] = @WareHouseID
WHERE
	[ID] = @ID

--end [dbo].[OrderTypes_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[OrderTypes_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[OrderTypes_Delete]
	@ID nvarchar(50)
AS


DELETE FROM [dbo].[OrderTypes]
WHERE
(
	[ID] = @ID
)

--end [dbo].[OrderTypes_Delete]
--endregion

GO
--=========================================================================================--

--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[Settings_Insert]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Insert]

IF OBJECT_ID(N'[dbo].[Settings_Update]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Update]

IF OBJECT_ID(N'[dbo].[Settings_Delete]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Delete]

IF OBJECT_ID(N'[dbo].[Settings_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[Settings_Select]

--endregion

GO


--region [dbo].[Settings_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ID int = null,
	@SMTP nvarchar(250) = null,
	@EmailSender nvarchar(50) = null,
	@Password nvarchar(50) = null,
	@Port int = null,
	@EmailReceiver nvarchar(50) = null,
	@Domain nvarchar(250) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[Settings]
					WHERE
					(
						(@ID is null OR [Settings].[ID] = @ID)
						AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
						AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
						AND (@Password is null OR [Settings].[Password] like @Password)
						AND (@Port is null OR [Settings].[Port] = @Port)
						AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
						AND (@Domain is null OR [Settings].[Domain] like @Domain)
					)
				)
if(@Page is null)
begin
	Set @Page = 1
end

if(@PageSize is null)
begin
	Set @PageSize = @RowCount
end

if(@SortBy is null)
begin
	Set @SortBy = 'DBNull'
end

if(@SortType is null)
begin
	Set @SortType = 1
end

SELECT *
FROM   (
			SELECT [dbo].[Settings].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 1 THEN [Settings].[ID] END ASC,
						CASE WHEN @SortBy = 'ID' and @SortType = 0 THEN [Settings].[ID] END DESC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 1 THEN [Settings].[SMTP] END ASC,
						CASE WHEN @SortBy = 'SMTP' and @SortType = 0 THEN [Settings].[SMTP] END DESC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 1 THEN [Settings].[EmailSender] END ASC,
						CASE WHEN @SortBy = 'EmailSender' and @SortType = 0 THEN [Settings].[EmailSender] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [Settings].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [Settings].[Password] END DESC,
						CASE WHEN @SortBy = 'Port' and @SortType = 1 THEN [Settings].[Port] END ASC,
						CASE WHEN @SortBy = 'Port' and @SortType = 0 THEN [Settings].[Port] END DESC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 1 THEN [Settings].[EmailReceiver] END ASC,
						CASE WHEN @SortBy = 'EmailReceiver' and @SortType = 0 THEN [Settings].[EmailReceiver] END DESC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 1 THEN [Settings].[Domain] END ASC,
						CASE WHEN @SortBy = 'Domain' and @SortType = 0 THEN [Settings].[Domain] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[Settings]
			Where 
			(
				(@ID is null OR [Settings].[ID] = @ID)
				AND (@SMTP is null OR [Settings].[SMTP] like @SMTP)
				AND (@EmailSender is null OR [Settings].[EmailSender] like @EmailSender)
				AND (@Password is null OR [Settings].[Password] like @Password)
				AND (@Port is null OR [Settings].[Port] = @Port)
				AND (@EmailReceiver is null OR [Settings].[EmailReceiver] like @EmailReceiver)
				AND (@Domain is null OR [Settings].[Domain] like @Domain)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[Settings_Select]
--endregion

GO
--=========================================================================================--

	

--region [dbo].[Settings_Insert]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Insert]
	@ID int OUTPUT,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)

AS


INSERT INTO [dbo].[Settings] 
(
	[SMTP],
	[EmailSender],
	[Password],
	[Port],
	[EmailReceiver],
	[Domain]
)
VALUES 
(
	@SMTP,
	@EmailSender,
	@Password,
	@Port,
	@EmailReceiver,
	@Domain
)

SET @ID = SCOPE_IDENTITY()

--end [dbo].[Settings_Insert]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Update]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Update]
	@ID int,
	@SMTP nvarchar(250),
	@EmailSender nvarchar(50),
	@Password nvarchar(50),
	@Port int,
	@EmailReceiver nvarchar(50),
	@Domain nvarchar(250)
AS


UPDATE [dbo].[Settings] SET
	[SMTP] = @SMTP,
	[EmailSender] = @EmailSender,
	[Password] = @Password,
	[Port] = @Port,
	[EmailReceiver] = @EmailReceiver,
	[Domain] = @Domain
WHERE
	[ID] = @ID

--end [dbo].[Settings_Update]
--endregion

GO
--=========================================================================================--

--region [dbo].[Settings_Delete]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[Settings_Delete]
	@ID int
AS


DELETE FROM [dbo].[Settings]
WHERE
(
	[ID] = @ID
)

--end [dbo].[Settings_Delete]
--endregion

GO
--=========================================================================================--

