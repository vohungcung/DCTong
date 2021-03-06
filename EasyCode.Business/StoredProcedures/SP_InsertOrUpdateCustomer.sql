
ALTER proc [dbo].[SP_InsertOrUpdateCustomer]
(
@CustomerID nvarchar(250), 
@CustomerName nvarchar(250), 
@Address nvarchar(250), 
@CustomerType nvarchar(50), 
@Phone nvarchar(50),
@Area nvarchar(50),
@ZipCode nvarchar(50),
@District nvarchar(250)=null
)
as
if(not exists(select CustomerID from Customers where CustomerID=@CustomerID))
insert into Customers
(
CustomerID, CustomerName, Address, CustomerType, Password, Phone,Area,ZipCode,District
)
values(
@CustomerID, @CustomerName, @Address, @CustomerType, '123', @Phone,@Area,@ZipCode,@District
)
else
update customers
set
 CustomerName=@CustomerName, 
Address=@Address, 
CustomerType=@CustomerType, 
 Phone=@Phone,
Area=@Area,
ZipCode=@ZipCode,
District=@District
where CustomerID=@CustomerID