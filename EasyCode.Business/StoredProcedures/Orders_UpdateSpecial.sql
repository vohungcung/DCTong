
ALTER PROCEDURE [dbo].[Orders_UpdateSpecial]
	@OrderID nvarchar(50),
	@CustomerID nvarchar(50),
	@DeliveryAddress nvarchar(250),
	@District nvarchar(250),
	@Description nvarchar(25),
	@TotalAmount money,
	@CreateBy int
AS


UPDATE [dbo].[Orders] SET
	[CustomerID] = @CustomerID,
	Description=@Description,
	[DeliveryAddress] = @DeliveryAddress,
	District = @District,
	[TotalAmount] = @TotalAmount
WHERE
	[OrderID] = @OrderID

--end [dbo].[Orders_Update]
--endregion
