-- =============================================
-- Create database template
-- =============================================

/*--
USE master
GO

-- Drop the database if it already exists
IF  EXISTS (
	SELECT name 
		FROM sys.databases 
		WHERE name = N'BookStore'
)
DROP DATABASE BookStore
GO

CREATE DATABASE BookStore;
GO

USE BookStore;

IF OBJECT_ID('dbo.Books', 'U') IS NOT NULL
  DROP TABLE dbo.Books
GO

CREATE TABLE dbo.Books (
    BookID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100),
    Author NVARCHAR(100),
    Quantity INT CHECK (Quantity >= 0),
    Price DECIMAL(10, 2)
);


IF OBJECT_ID('dbo.Sales', 'U') IS NOT NULL
  DROP TABLE dbo.Sales
GO

CREATE TABLE dbo.Sales (
    SaleID INT PRIMARY KEY IDENTITY,
    BookID INT,
    QuantitySold INT,
    SaleDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
  DROP TABLE dbo.Users
GO

CREATE TABLE dbo.Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50),
    Role NVARCHAR(50)
);

IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL
  DROP TABLE dbo.Roles
GO

CREATE TABLE dbo.Roles (
    RoleID INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50)
);

IF OBJECT_ID('dbo.AuditLog', 'U') IS NOT NULL
  DROP TABLE dbo.AuditLog
GO

CREATE TABLE AuditLog (
    AuditID INT PRIMARY KEY IDENTITY,
    UserID INT,
    Operation NVARCHAR(50),
    TableName NVARCHAR(50),
    ChangeDateTime DATETIME DEFAULT GETDATE()
);

-- Populate Roles Table
INSERT INTO dbo.Roles (RoleName) VALUES ('sales_manager'), ('inventory_manager');

-- Populate Users Table
INSERT INTO [dbo].[Users] (Username, [Role]) VALUES ('Alice', 'sales_manager'), ('Bob', 'inventory_manager');

-- Populate Books Table
INSERT INTO dbo.Books (Title, Author, Quantity, Price) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 10, 10.99),
('1984', 'George Orwell', 15, 8.99),
('To Kill a Mockingbird', 'Harper Lee', 12, 7.99),
('The Catcher in the Rye', 'J.D. Salinger', 8, 9.99),
('Pride and Prejudice', 'Jane Austen', 10, 6.99);

-- Populate Sales Table
INSERT INTO dbo.Sales (BookID, QuantitySold) VALUES 
(1, 2), -- Sale of 2 copies of 'The Great Gatsby'
(3, 1); -- Sale of 1 copy of 'To Kill a Mockingbird'


SELECT * FROM [dbo].[Roles]
SELECT * FROM [dbo].[Users]
SELECT * FROM [dbo].[Books]
SELECT * FROM [dbo].[Sales]
SELECT * FROM [dbo].[AuditLog]



-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_AddBook' 
)
   DROP PROCEDURE dbo.sp_AddBook;
GO

-- Stored Procedure to Add a Book
CREATE PROCEDURE dbo.sp_AddBook
    @Title NVARCHAR(100),
    @Author NVARCHAR(100),
    @Quantity INT,
    @Price DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO dbo.Books (Title, Author, Quantity, Price)
    VALUES (@Title, @Author, @Quantity, @Price);
END;

EXECUTE dbo.sp_AddBook
    @Title ='The Secret Government: Invisible Architects: Secrets, Power, and Lies',
    @Author ='Ismael Perez',
    @Quantity = 50,
    @Price = 100.00

SELECT * FROM dbo.Books ORDER BY 1 DESC;

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'sp_SellBook' 
)
   DROP PROCEDURE dbo.sp_SellBook;
GO

-- Stored Procedure to Sell a Book
CREATE PROCEDURE dbo.sp_SellBook
    @BookID INT,
    @QuantitySold INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update book quantity
        -- WRITE YOUR CODE HERE

		UPDATE [dbo].[Books]
		   SET [Quantity] = @QuantitySold			  
		 WHERE [BookID] = @BookID
		
		
        -- Insert into Sales
        -- WRITE YOUR CODE HERE
		INSERT INTO [dbo].[Sales] ([BookID],[QuantitySold])
		VALUES (@BookID, @QuantitySold)

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;

SELECT * FROM [dbo].[Books] WHERE BookID = 6;
SELECT * FROM [dbo].[Sales] WHERE BookID = 6;


EXEC dbo.sp_SellBook
    @BookID = 6,
    @QuantitySold = 4;


-- Trigger trg_UpdateStock on sales table after insert. 
--This trigger will Update Stock. You need to use
--join operation to join Books table with inserted values (magic table).

IF OBJECT_ID ('dbo.trg_PreventNegativeStock','TR') IS NOT NULL
   DROP TRIGGER dbo.trg_PreventNegativeStock;
GO
-- Trigger to Prevent Negative Stock
CREATE TRIGGER dbo.trg_PreventNegativeStock
ON [dbo].[Books]
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Quantity < 0)
    BEGIN
        RAISERROR('Stock quantity cannot be negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Need to update the Books table. 
		--Use join operation with the inserted values (magic table)
        -- WRITE YOUR CODE HERE
			IF UPDATE([Quantity]) 
				UPDATE [dbo].[Books]
				   SET [Quantity] = (d.[Quantity] - i.[Quantity])
				FROM INSERTED i
				   INNER JOIN DELETED d ON d.[BookID] = i.[BookID]
				   INNER JOIN [dbo].[Books] b ON b.BookID = i.[BookID]
				   WHERE d.[Quantity] != i.[Quantity] AND b.BookID = i.[BookID]
				
				PRINT 'Update Quantity Book';

    END
END;

SELECT * FROM [dbo].[Books] WHERE BookID = 6;
SELECT * FROM [dbo].[Sales] WHERE BookID = 6;
SELECT * FROM [dbo].[AuditLog]

EXEC dbo.sp_SellBook
    @BookID = 6,
    @QuantitySold = 7;


IF OBJECT_ID ('dbo.trg_AuditLog','TR') IS NOT NULL
   DROP TRIGGER dbo.trg_AuditLog;
GO

-- Trigger to Log Changes
CREATE TRIGGER dbo.trg_AuditLog
ON [dbo].[Books]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @UserID INT = (SELECT UserID FROM Users WHERE Username = ORIGINAL_LOGIN());

    INSERT INTO dbo.AuditLog (UserID, Operation, TableName)
    VALUES (@UserID, CASE WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN 'UPDATE'
                          WHEN EXISTS (SELECT * FROM inserted) THEN 'INSERT'
                          ELSE 'DELETE'
                     END,
                     'Books');
END;


SELECT * FROM [dbo].[Books] WHERE BookID = 2;
SELECT * FROM [dbo].[Sales] WHERE BookID = 2;
SELECT * FROM [dbo].[AuditLog]

EXEC dbo.sp_SellBook
    @BookID = 2,
    @QuantitySold = 4;


INSERT INTO [dbo].[Users] (Username, [Role]) VALUES ('sa', 'Jose Encarnacion')

select ORIGINAL_LOGIN()

SELECT UserID FROM Users WHERE Username = ORIGINAL_LOGIN()


-- Create roles
CREATE ROLE sales_manager;
CREATE ROLE inventory_manager;

CREATE LOGIN SalesUserLogin WITH PASSWORD = '123456' ,DEFAULT_DATABASE =[BookStore],CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF; 
CREATE LOGIN InventoryUserLogin WITH PASSWORD = '123456' ,DEFAULT_DATABASE =[BookStore],CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF; 
USE [BookStore];

-- Grant permissions to roles
GRANT SELECT, INSERT, UPDATE ON Sales TO /*WRITE THE CODE HERE*/;
GRANT SELECT, INSERT, UPDATE ON Books TO /*WRITE THE CODE HERE*/;

-- Create users and assign roles
CREATE USER SalesUser FOR LOGIN SalesUserLogin;
CREATE USER InventoryUser FOR LOGIN InventoryUserLogin;

GRANT SELECT, INSERT, UPDATE ON Sales TO SalesUser
GRANT SELECT, INSERT, UPDATE ON Books TO SalesUser

GRANT SELECT, INSERT, UPDATE ON Sales TO InventoryUser
GRANT SELECT, INSERT, UPDATE ON Books TO InventoryUser

-- Create users and assign roles
CREATE USER SalesUser FOR LOGIN SalesUserLogin;
CREATE USER InventoryUser FOR LOGIN InventoryUserLogin;

ALTER ROLE sales_manager ADD MEMBER SalesUser;
ALTER ROLE inventory_manager ADD MEMBER InventoryUser;

SELECT * FROM [dbo].[Books] WHERE BookID = 3;
SELECT * FROM [dbo].[Sales] WHERE BookID = 3;
SELECT * FROM [dbo].[AuditLog]

SELECT * FROM [dbo].[Users]

EXEC dbo.sp_SellBook
    @BookID = 2,
    @QuantitySold = 4;

INSERT INTO [dbo].[Users] (Username, [Role]) VALUES ('SalesUserLogin', 'sales_manager')
INSERT INTO [dbo].[Users] (Username, [Role]) VALUES ('InventoryUserLogin', 'inventory_manager')

--*/

REVOKE UPDATE ON Books TO InventoryUser;
REVOKE UPDATE ON Books TO SalesUser