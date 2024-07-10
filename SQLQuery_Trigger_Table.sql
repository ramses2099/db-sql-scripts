
-- Create a new table called '[PersonUpdateLog]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[PersonUpdateLog]', 'U') IS NOT NULL
DROP TABLE [Person].[PersonUpdateLog]
GO
-- Create the table in the specified schema
CREATE TABLE [Person].[PersonUpdateLog]
(
    [BusinessEntityID] INT NOT NULL,
    [OldFirstName] NVARCHAR(50) NOT NULL,
    [NewFirstName] NVARCHAR(50) NOT NULL,
    [OldLastName] NVARCHAR(50) NOT NULL,
    [NewLastName] NVARCHAR(50) NOT NULL,
    [UpdateDate] DATETIME DEFAULT (getdate()) 
    -- Specify more columns here
);
GO

GO
IF OBJECT_ID ('Person.trgAfterUpdatePerson','TR') IS NOT NULL
   DROP TRIGGER Person.trgAfterUpdatePerson;
GO
-- This trigger prevents a row from being inserted in the Purchasing.PurchaseOrderHeader table
-- when the credit rating of the specified vendor is set to 5 (below average).  
  
CREATE TRIGGER Person.trgAfterUpdatePerson ON [Person].[Person]  
FOR UPDATE  
AS  
    
    DECLARE @BusinessEntityID INT
    DECLARE @OldFirstName NVARCHAR(50)
    DECLARE @NewFirstName NVARCHAR(50)
    DECLARE @OldLastName NVARCHAR(50) 
    DECLARE @NewLastName NVARCHAR(50)

    SELECT      
       @BusinessEntityID = BusinessEntityID
    FROM INSERTED i

    SELECT 
      @OldFirstName = d.[FirstName],
      @OldLastName = d.[LastName]
    FROM DELETED d
        
    SELECT      
       @NewFirstName = i.[FirstName],
       @NewLastName = i.[LastName]
    FROM INSERTED i

    INSERT INTO [Person].[PersonUpdateLog]([BusinessEntityID], [OldFirstName],[NewFirstName],[OldLastName], [NewLastName])
    VALUES(@BusinessEntityID, @OldFirstName, @NewFirstName, @OldLastName , @NewLastName);



SELECT * FROM [Person].[Person] WHERE  [BusinessEntityID] = 3

UPDATE [Person].[Person] SET
[FirstName] = 'JOSE',
[LastName] = 'PEREZ'
 WHERE  [BusinessEntityID] = 3


SELECT * FROM [Person].[PersonUpdateLog];

