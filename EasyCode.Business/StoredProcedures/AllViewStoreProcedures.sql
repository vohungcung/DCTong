--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
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
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
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
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
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
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Thursday, April 19, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VItemHasThumb_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VItemHasThumb_Select]

--endregion

GO


--region [dbo].[VItemHasThumb_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VItemHasThumb_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(9) = null,
	@ItemName nvarchar(250) = null,
	@ThumbImage nvarchar(250) = null,
	@Size nvarchar(2) = null,
	@unitprice money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VItemHasThumb]
					WHERE
					(
						(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
						AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
						AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
						AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
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
			SELECT [dbo].[VItemHasThumb].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VItemHasThumb].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VItemHasThumb].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VItemHasThumb].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VItemHasThumb].[ItemName] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [VItemHasThumb].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [VItemHasThumb].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Size' and @SortType = 1 THEN [VItemHasThumb].[Size] END ASC,
						CASE WHEN @SortBy = 'Size' and @SortType = 0 THEN [VItemHasThumb].[Size] END DESC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 1 THEN [VItemHasThumb].[unitprice] END ASC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 0 THEN [VItemHasThumb].[unitprice] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VItemHasThumb]
			Where 
			(
				(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
				AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
				AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
				AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VItemHasThumb_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VItemHasThumb_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VItemHasThumb_Select]

--endregion

GO


--region [dbo].[VItemHasThumb_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VItemHasThumb_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(9) = null,
	@ItemName nvarchar(250) = null,
	@ThumbImage nvarchar(250) = null,
	@Size nvarchar(2) = null,
	@unitprice money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VItemHasThumb]
					WHERE
					(
						(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
						AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
						AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
						AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
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
			SELECT [dbo].[VItemHasThumb].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VItemHasThumb].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VItemHasThumb].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VItemHasThumb].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VItemHasThumb].[ItemName] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [VItemHasThumb].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [VItemHasThumb].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Size' and @SortType = 1 THEN [VItemHasThumb].[Size] END ASC,
						CASE WHEN @SortBy = 'Size' and @SortType = 0 THEN [VItemHasThumb].[Size] END DESC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 1 THEN [VItemHasThumb].[unitprice] END ASC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 0 THEN [VItemHasThumb].[unitprice] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VItemHasThumb]
			Where 
			(
				(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
				AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
				AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
				AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VItemHasThumb_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VItemHasThumb_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VItemHasThumb_Select]

--endregion

GO


--region [dbo].[VItemHasThumb_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VItemHasThumb_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(9) = null,
	@ItemName nvarchar(250) = null,
	@ThumbImage nvarchar(250) = null,
	@Size nvarchar(2) = null,
	@unitprice money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VItemHasThumb]
					WHERE
					(
						(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
						AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
						AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
						AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
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
			SELECT [dbo].[VItemHasThumb].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VItemHasThumb].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VItemHasThumb].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VItemHasThumb].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VItemHasThumb].[ItemName] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [VItemHasThumb].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [VItemHasThumb].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Size' and @SortType = 1 THEN [VItemHasThumb].[Size] END ASC,
						CASE WHEN @SortBy = 'Size' and @SortType = 0 THEN [VItemHasThumb].[Size] END DESC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 1 THEN [VItemHasThumb].[unitprice] END ASC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 0 THEN [VItemHasThumb].[unitprice] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VItemHasThumb]
			Where 
			(
				(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
				AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
				AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
				AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VItemHasThumb_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VCustomers_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VCustomers_Select]

--endregion

GO


--region [dbo].[VCustomers_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VCustomers_Select]
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
	@CustomerTypeName nvarchar(250) = null,
	@Area nvarchar(50) = null,
	@ZipCode nvarchar(50) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null,
	@Email nvarchar(50) = null,
	@IsMarketing bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VCustomers]
					WHERE
					(
						(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
						AND (@Address is null OR [VCustomers].[Address] like @Address)
						AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
						AND (@Password is null OR [VCustomers].[Password] like @Password)
						AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
						AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
						AND (@Area is null OR [VCustomers].[Area] like @Area)
						AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
						AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
						AND (@Email is null OR [VCustomers].[Email] like @Email)
						AND (@IsMarketing is null OR [VCustomers].[IsMarketing] = @IsMarketing)
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
			SELECT [dbo].[VCustomers].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VCustomers].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VCustomers].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VCustomers].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VCustomers].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'Address' and @SortType = 1 THEN [VCustomers].[Address] END ASC,
						CASE WHEN @SortBy = 'Address' and @SortType = 0 THEN [VCustomers].[Address] END DESC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 1 THEN [VCustomers].[CustomerType] END ASC,
						CASE WHEN @SortBy = 'CustomerType' and @SortType = 0 THEN [VCustomers].[CustomerType] END DESC,
						CASE WHEN @SortBy = 'Password' and @SortType = 1 THEN [VCustomers].[Password] END ASC,
						CASE WHEN @SortBy = 'Password' and @SortType = 0 THEN [VCustomers].[Password] END DESC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 1 THEN [VCustomers].[Phone] END ASC,
						CASE WHEN @SortBy = 'Phone' and @SortType = 0 THEN [VCustomers].[Phone] END DESC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 1 THEN [VCustomers].[CustomerTypeName] END ASC,
						CASE WHEN @SortBy = 'CustomerTypeName' and @SortType = 0 THEN [VCustomers].[CustomerTypeName] END DESC,
						CASE WHEN @SortBy = 'Area' and @SortType = 1 THEN [VCustomers].[Area] END ASC,
						CASE WHEN @SortBy = 'Area' and @SortType = 0 THEN [VCustomers].[Area] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VCustomers].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VCustomers].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VCustomers].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VCustomers].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VCustomers].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VCustomers].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VCustomers].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VCustomers].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VCustomers].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VCustomers].[ZOC] END DESC,
						CASE WHEN @SortBy = 'Email' and @SortType = 1 THEN [VCustomers].[Email] END ASC,
						CASE WHEN @SortBy = 'Email' and @SortType = 0 THEN [VCustomers].[Email] END DESC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 1 THEN [VCustomers].[IsMarketing] END ASC,
						CASE WHEN @SortBy = 'IsMarketing' and @SortType = 0 THEN [VCustomers].[IsMarketing] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VCustomers]
			Where 
			(
				(@CustomerID is null OR [VCustomers].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VCustomers].[CustomerName] like @CustomerName)
				AND (@Address is null OR [VCustomers].[Address] like @Address)
				AND (@CustomerType is null OR [VCustomers].[CustomerType] like @CustomerType)
				AND (@Password is null OR [VCustomers].[Password] like @Password)
				AND (@Phone is null OR [VCustomers].[Phone] like @Phone)
				AND (@CustomerTypeName is null OR [VCustomers].[CustomerTypeName] like @CustomerTypeName)
				AND (@Area is null OR [VCustomers].[Area] like @Area)
				AND (@ZipCode is null OR [VCustomers].[ZipCode] like @ZipCode)
				AND (@ZO1 is null OR [VCustomers].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VCustomers].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VCustomers].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VCustomers].[ZOC] = @ZOC)
				AND (@Email is null OR [VCustomers].[Email] like @Email)
				AND (@IsMarketing is null OR [VCustomers].[IsMarketing] = @IsMarketing)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VCustomers_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VItemHasThumb_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VItemHasThumb_Select]

--endregion

GO


--region [dbo].[VItemHasThumb_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VItemHasThumb_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@ItemID nvarchar(9) = null,
	@ItemName nvarchar(250) = null,
	@ThumbImage nvarchar(250) = null,
	@Size nvarchar(2) = null,
	@unitprice money = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VItemHasThumb]
					WHERE
					(
						(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
						AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
						AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
						AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
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
			SELECT [dbo].[VItemHasThumb].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VItemHasThumb].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VItemHasThumb].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VItemHasThumb].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VItemHasThumb].[ItemName] END DESC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 1 THEN [VItemHasThumb].[ThumbImage] END ASC,
						CASE WHEN @SortBy = 'ThumbImage' and @SortType = 0 THEN [VItemHasThumb].[ThumbImage] END DESC,
						CASE WHEN @SortBy = 'Size' and @SortType = 1 THEN [VItemHasThumb].[Size] END ASC,
						CASE WHEN @SortBy = 'Size' and @SortType = 0 THEN [VItemHasThumb].[Size] END DESC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 1 THEN [VItemHasThumb].[unitprice] END ASC,
						CASE WHEN @SortBy = 'unitprice' and @SortType = 0 THEN [VItemHasThumb].[unitprice] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VItemHasThumb]
			Where 
			(
				(@ItemID is null OR [VItemHasThumb].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VItemHasThumb].[ItemName] like @ItemName)
				AND (@ThumbImage is null OR [VItemHasThumb].[ThumbImage] like @ThumbImage)
				AND (@Size is null OR [VItemHasThumb].[Size] like @Size)
				AND (@unitprice is null OR [VItemHasThumb].[unitprice] = @unitprice)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VItemHasThumb_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrderDetail_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrderDetail_Select]

--endregion

GO


--region [dbo].[VOrderDetail_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrderDetail_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderNo int = null,
	@OrderID nvarchar(50) = null,
	@ItemID nvarchar(50) = null,
	@ItemName nvarchar(250) = null,
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
					From [dbo].[VOrderDetail]
					WHERE
					(
						(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
						AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
						AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
						AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
						AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
						AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
						AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
						AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
						AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
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
			SELECT [dbo].[VOrderDetail].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 1 THEN [VOrderDetail].[OrderNo] END ASC,
						CASE WHEN @SortBy = 'OrderNo' and @SortType = 0 THEN [VOrderDetail].[OrderNo] END DESC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrderDetail].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrderDetail].[OrderID] END DESC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 1 THEN [VOrderDetail].[ItemID] END ASC,
						CASE WHEN @SortBy = 'ItemID' and @SortType = 0 THEN [VOrderDetail].[ItemID] END DESC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 1 THEN [VOrderDetail].[ItemName] END ASC,
						CASE WHEN @SortBy = 'ItemName' and @SortType = 0 THEN [VOrderDetail].[ItemName] END DESC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 1 THEN [VOrderDetail].[UoM] END ASC,
						CASE WHEN @SortBy = 'UoM' and @SortType = 0 THEN [VOrderDetail].[UoM] END DESC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 1 THEN [VOrderDetail].[UnitPrice] END ASC,
						CASE WHEN @SortBy = 'UnitPrice' and @SortType = 0 THEN [VOrderDetail].[UnitPrice] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrderDetail].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrderDetail].[Quantity] END DESC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 1 THEN [VOrderDetail].[Discount] END ASC,
						CASE WHEN @SortBy = 'Discount' and @SortType = 0 THEN [VOrderDetail].[Discount] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrderDetail].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrderDetail].[TotalAmount] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrderDetail]
			Where 
			(
				(@OrderNo is null OR [VOrderDetail].[OrderNo] = @OrderNo)
				AND (@OrderID is null OR [VOrderDetail].[OrderID] like @OrderID)
				AND (@ItemID is null OR [VOrderDetail].[ItemID] like @ItemID)
				AND (@ItemName is null OR [VOrderDetail].[ItemName] like @ItemName)
				AND (@UoM is null OR [VOrderDetail].[UoM] like @UoM)
				AND (@UnitPrice is null OR [VOrderDetail].[UnitPrice] = @UnitPrice)
				AND (@Quantity is null OR [VOrderDetail].[Quantity] = @Quantity)
				AND (@Discount is null OR [VOrderDetail].[Discount] = @Discount)
				AND (@TotalAmount is null OR [VOrderDetail].[TotalAmount] = @TotalAmount)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrderDetail_Select]
--endregion

GO
--=========================================================================================--


--region Drop Existing Procedures

IF OBJECT_ID(N'[dbo].[VOrders_Select]') IS NOT NULL
	DROP PROCEDURE [dbo].[VOrders_Select]

--endregion

GO


--region [dbo].[VOrders_Select]

-- Create By: Hung Cung
-- Date Generated: Friday, April 20, 2018

CREATE PROCEDURE [dbo].[VOrders_Select]
	@Page int = null,
	@PageSize int = null,
    @SortBy nvarchar(255) = null,
	@SortType bit = null,
	@OrderID nvarchar(50) = null,
	@OrderType nvarchar(50) = null,
	@CustomerID nvarchar(50) = null,
	@CustomerName nvarchar(250) = null,
	@DeliveryAddress nvarchar(250) = null,
	@SAPOrderNumber nvarchar(50) = null,
	@Ref2 nvarchar(50) = null,
	@Status int = null,
	@TotalAmount money = null,
	@CreateDate datetime = null,
	@CreateBy int = null,
	@ZipCode nvarchar(50) = null,
	@Quantity decimal(38, 0) = null,
	@ZO1 bit = null,
	@ZOD bit = null,
	@ZO2 bit = null,
	@ZOC bit = null
AS

SET TRANSACTION ISOLATION LEVEL READ COMMITTED

Declare @RowCount int  
Set @RowCount = (
					Select Count (*) 
					From [dbo].[VOrders]
					WHERE
					(
						(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
						AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
						AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
						AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
						AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
						AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
						AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
						AND (@Status is null OR [VOrders].[Status] = @Status)
						AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
						AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
						AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
						AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
						AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
						AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
						AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
						AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
						AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
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
			SELECT [dbo].[VOrders].*,
                   ROW_NUMBER() OVER 
                   (ORDER BY 
                        CASE WHEN @SortBy = 'DBNull' THEN NewID() END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 1 THEN [VOrders].[OrderID] END ASC,
						CASE WHEN @SortBy = 'OrderID' and @SortType = 0 THEN [VOrders].[OrderID] END DESC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 1 THEN [VOrders].[OrderType] END ASC,
						CASE WHEN @SortBy = 'OrderType' and @SortType = 0 THEN [VOrders].[OrderType] END DESC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 1 THEN [VOrders].[CustomerID] END ASC,
						CASE WHEN @SortBy = 'CustomerID' and @SortType = 0 THEN [VOrders].[CustomerID] END DESC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 1 THEN [VOrders].[CustomerName] END ASC,
						CASE WHEN @SortBy = 'CustomerName' and @SortType = 0 THEN [VOrders].[CustomerName] END DESC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 1 THEN [VOrders].[DeliveryAddress] END ASC,
						CASE WHEN @SortBy = 'DeliveryAddress' and @SortType = 0 THEN [VOrders].[DeliveryAddress] END DESC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 1 THEN [VOrders].[SAPOrderNumber] END ASC,
						CASE WHEN @SortBy = 'SAPOrderNumber' and @SortType = 0 THEN [VOrders].[SAPOrderNumber] END DESC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 1 THEN [VOrders].[Ref2] END ASC,
						CASE WHEN @SortBy = 'Ref2' and @SortType = 0 THEN [VOrders].[Ref2] END DESC,
						CASE WHEN @SortBy = 'Status' and @SortType = 1 THEN [VOrders].[Status] END ASC,
						CASE WHEN @SortBy = 'Status' and @SortType = 0 THEN [VOrders].[Status] END DESC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 1 THEN [VOrders].[TotalAmount] END ASC,
						CASE WHEN @SortBy = 'TotalAmount' and @SortType = 0 THEN [VOrders].[TotalAmount] END DESC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 1 THEN [VOrders].[CreateDate] END ASC,
						CASE WHEN @SortBy = 'CreateDate' and @SortType = 0 THEN [VOrders].[CreateDate] END DESC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 1 THEN [VOrders].[CreateBy] END ASC,
						CASE WHEN @SortBy = 'CreateBy' and @SortType = 0 THEN [VOrders].[CreateBy] END DESC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 1 THEN [VOrders].[ZipCode] END ASC,
						CASE WHEN @SortBy = 'ZipCode' and @SortType = 0 THEN [VOrders].[ZipCode] END DESC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 1 THEN [VOrders].[Quantity] END ASC,
						CASE WHEN @SortBy = 'Quantity' and @SortType = 0 THEN [VOrders].[Quantity] END DESC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 1 THEN [VOrders].[ZO1] END ASC,
						CASE WHEN @SortBy = 'ZO1' and @SortType = 0 THEN [VOrders].[ZO1] END DESC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 1 THEN [VOrders].[ZOD] END ASC,
						CASE WHEN @SortBy = 'ZOD' and @SortType = 0 THEN [VOrders].[ZOD] END DESC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 1 THEN [VOrders].[ZO2] END ASC,
						CASE WHEN @SortBy = 'ZO2' and @SortType = 0 THEN [VOrders].[ZO2] END DESC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 1 THEN [VOrders].[ZOC] END ASC,
						CASE WHEN @SortBy = 'ZOC' and @SortType = 0 THEN [VOrders].[ZOC] END DESC                   
                    ) AS RowNumber 
			FROM [dbo].[VOrders]
			Where 
			(
				(@OrderID is null OR [VOrders].[OrderID] like @OrderID)
				AND (@OrderType is null OR [VOrders].[OrderType] like @OrderType)
				AND (@CustomerID is null OR [VOrders].[CustomerID] like @CustomerID)
				AND (@CustomerName is null OR [VOrders].[CustomerName] like @CustomerName)
				AND (@DeliveryAddress is null OR [VOrders].[DeliveryAddress] like @DeliveryAddress)
				AND (@SAPOrderNumber is null OR [VOrders].[SAPOrderNumber] like @SAPOrderNumber)
				AND (@Ref2 is null OR [VOrders].[Ref2] like @Ref2)
				AND (@Status is null OR [VOrders].[Status] = @Status)
				AND (@TotalAmount is null OR [VOrders].[TotalAmount] = @TotalAmount)
				AND (@CreateDate is null OR [VOrders].[CreateDate] = @CreateDate)
				AND (@CreateBy is null OR [VOrders].[CreateBy] = @CreateBy)
				AND (@ZipCode is null OR [VOrders].[ZipCode] like @ZipCode)
				AND (@Quantity is null OR [VOrders].[Quantity] = @Quantity)
				AND (@ZO1 is null OR [VOrders].[ZO1] = @ZO1)
				AND (@ZOD is null OR [VOrders].[ZOD] = @ZOD)
				AND (@ZO2 is null OR [VOrders].[ZO2] = @ZO2)
				AND (@ZOC is null OR [VOrders].[ZOC] = @ZOC)
			)
		) AS Temp
WHERE  RowNumber Between (@Page * @PageSize - @PageSize + 1) And @Page * @PageSize
Return @RowCount


--end [dbo].[VOrders_Select]
--endregion

GO
--=========================================================================================--


