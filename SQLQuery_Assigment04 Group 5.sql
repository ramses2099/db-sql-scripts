
-- [HumanResources].[EmployeePayHistory]
-- Create a new table called '[EmployeePayHistoryLog]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[HumanResources].[EmployeePayHistoryLog]', 'U') IS NOT NULL
DROP TABLE [HumanResources].[EmployeePayHistoryLog]
GO
-- Create the table in the specified schema
CREATE TABLE [HumanResources].[EmployeePayHistoryLog]
(
    [BusinessEntityID] INT NOT NULL,
    [OldRate] NVARCHAR(50) NOT NULL,
    [NewRate ] MONEY NOT NULL,
    [ModifiedDate] DATETIME DEFAULT (getdate()) 
    -- Specify more columns here
);
GO
GO
IF OBJECT_ID ('HumanResources.trgAfterUpdateEmployeePayHistory','TR') IS NOT NULL
   DROP TRIGGER HumanResources.trgAfterUpdateEmployeePayHistory;
GO
-- This trigger prevents a row from being inserted in the Purchasing.PurchaseOrderHeader table
-- when the credit rating of the specified vendor is set to 5 (below average).  
  
CREATE TRIGGER HumanResources.trgAfterUpdateEmployeePayHistory ON [HumanResources].[EmployeePayHistory]  
FOR UPDATE  
AS  
    
    DECLARE @BusinessEntityID INT
    DECLARE @OldRate MONEY
    DECLARE @NewRate MONEY
    

    IF UPDATE([Rate])
       INSERT INTO [HumanResources].[EmployeePayHistoryLog]([BusinessEntityID],[OldRate],[NewRate])
       SELECT 
        i.BusinessEntityID,
        d.[Rate],
        i.[Rate]
       FROM INSERTED i
       INNER JOIN DELETED d ON i.BusinessEntityID = d.BusinessEntityID
       WHERE i.[Rate] != d.[Rate]

GO
SELECT * FROM [HumanResources].[EmployeePayHistory] WHERE BusinessEntityID = 1
GO
SELECT * FROM [HumanResources].[EmployeePayHistoryLog]
GO
-- OLD RATE
-- Rate = 125.50
GO
UPDATE [HumanResources].[EmployeePayHistory] SET 
Rate = 130.50
WHERE BusinessEntityID = 1
GO
SELECT * FROM [HumanResources].[EmployeePayHistory] WHERE BusinessEntityID = 1
GO
SELECT * FROM [HumanResources].[EmployeePayHistoryLog]
GO


-- Create a stored procedure named usp_UpdateEmployeeTitle that takes two parameters: @BusinessEntityID and @NewJobTitle.
-- The procedure should update the JobTitle of the specified employee in the HumanResources.Employee table.
-- If the update is successful, the procedure should return a success message. If not, it should return an error message.
-- Test the Stored Procedure:
-- Call the stored procedure to update the job title of an employee and verify the result.


-- Create a new stored procedure called 'usp_UpdateEmployeeTitle' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'HumanResources'
    AND SPECIFIC_NAME = N'usp_UpdateEmployeeTitle'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE HumanResources.usp_UpdateEmployeeTitle
GO
-- Create the stored procedure in the specified schema
CREATE OR ALTER PROCEDURE HumanResources.usp_UpdateEmployeeTitle
   @BusinessEntityID INT,
   @NewJobTitle NVARCHAR(50)
-- add more stored procedure parameters here
AS
BEGIN
    -- body of the stored procedure

    DECLARE @Valida INT;

    SELECT @Valida = COUNT(*)
    FROM [HumanResources].[Employee] WHERE [BusinessEntityID] = @BusinessEntityID;

    -- PRINT 'TEST' + CAST(@Valida AS VARCHAR) 

    IF @Valida = 0
    BEGIN
        PRINT 'BusinessEntityID doesnt exits'
    END
    ELSE
    BEGIN
        UPDATE [HumanResources].[Employee] SET
        [JobTitle] = @NewJobTitle
        WHERE [BusinessEntityID] = @BusinessEntityID;
        PRINT 'JodTitle was successfully updated the JodTitle new ' + @NewJobTitle;
    END 
END
GO
-- Chief Executive Officer -- Design Engineer
SELECT * FROM [HumanResources].[Employee] WHERE [BusinessEntityID] = 1 
GO
-- example to execute the stored procedure we just created
EXECUTE HumanResources.usp_UpdateEmployeeTitle @BusinessEntityID =0, @NewJobTitle = 'Design Engineer';
GO
SELECT * FROM [HumanResources].[Employee] WHERE [BusinessEntityID] = 1 
