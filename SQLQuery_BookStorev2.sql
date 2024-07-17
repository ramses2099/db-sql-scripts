
SELECT * FROM [dbo].[Books] WHERE BookID = 3;
SELECT * FROM [dbo].[Sales] WHERE BookID = 3;
SELECT * FROM [dbo].[AuditLog]

EXEC dbo.sp_SellBook
    @BookID = 3,
    @QuantitySold = 4;
	
	select ORIGINAL_LOGIN()

SELECT UserID FROM Users WHERE Username = ORIGINAL_LOGIN()


update [dbo].[Books] set
Quantity = 14
where BookID = 3