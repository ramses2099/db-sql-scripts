-- Create a new database called 'ASSING02'
-- Assignment 02   
-- Name: Jose Encarnacion
-- Stundent No.:  8982860
-- Date 2024-05-29

USE master
GO
IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'ASSING02')
BEGIN      
    DROP DATABASE ASSING02;
END

GO
CREATE DATABASE ASSING02;

GO

USE ASSING02;

GO

PRINT 'CREATE DATABASE ASSING02';

GO


-- Create a new table called '[SalesPerson]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[SalesPerson]', 'U') IS NOT NULL
DROP TABLE [dbo].[SalesPerson]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[SalesPerson]
(
    [SalesPersonID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [SalesPerson_Name] NVARCHAR(250) NOT NULL,
    [SalesPerson_Telephone] NVARCHAR(50) NOT NULL,
    [SalesPerson_Fax] NVARCHAR(50) NOT NULL
    -- Specify more columns here
);
GO

PRINT 'CREATE TABLE SalesPerson';

GO

INSERT INTO [dbo].[SalesPerson] ( [SalesPerson_Name], [SalesPerson_Telephone],[SalesPerson_Fax]) VALUES('Jose Encarnacion','519-879-8958','591-897-4589');

GO

-- Create a new table called '[Territory]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Territory]', 'U') IS NOT NULL
DROP TABLE [dbo].[Territory]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Territory]
(
    [TerritoryID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [Territory_Name] NVARCHAR(250) NOT NULL    
);
GO


PRINT 'CREATE TABLE Territory';

GO
INSERT INTO Territory(Territory_Name)VALUES('Kitchener');
INSERT INTO Territory(Territory_Name)VALUES('Toronto');
INSERT INTO Territory(Territory_Name)VALUES('Waterloo');
GO

-- Create a new table called '[SalesPerson_Territory]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[SalesPerson_Territory]', 'U') IS NOT NULL
DROP TABLE [dbo].[SalesPerson_Territory]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[SalesPerson_Territory]
(
    [SalesPerson_TerritoryID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [SalesPersonID] INT NOT NULL,
    [TerritoryID] INT NOT NULL,
    CONSTRAINT FK_SalesPerson_Territory_SalesPersonID FOREIGN KEY (SalesPersonID)
    REFERENCES SalesPerson(SalesPersonID), 
    CONSTRAINT FK_SalesPerson_Territory_TerritoryID FOREIGN KEY (TerritoryID)
    REFERENCES Territory(TerritoryID)
    -- Specify more columns here
);
GO

PRINT 'CREATE TABLE SalesPerson_Territory';

GO
INSERT INTO [dbo].[SalesPerson_Territory]( [SalesPersonID],[TerritoryID])VALUES(1,1);

GO

-- Create a new table called '[Customer]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Customer]', 'U') IS NOT NULL
DROP TABLE [dbo].[Customer]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Customer]
(
    [CustomerID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [Customer_Name] NVARCHAR(250) NOT NULL,
    [Customer_Address] NVARCHAR(250) NOT NULL,
    [Customer_PostalCode] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Chet O''Mullaney', 'Room 1526', 'PO BS901');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Deck Garstan', 'Room 1593', 'PO BS501');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Sonnie Trivett', 'PO Box 33112', '67130');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Trever Gaitley', '14th Floor', '87-410');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Yorgo Dono', 'Apt 1477', 'PO B5S01');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Tremayne Stinton', 'Apt 60', '84200-000');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Eleen Roebuck', 'Suite 24', 'PO BS701');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Farlay Sturdey', 'Suite 78', 'PO BS501');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Sherie Barrick', 'Suite 37', '74982 CEDEX 9');
INSERT INTO Customer (Customer_Name, Customer_Address, Customer_PostalCode) VALUES ('Murry Maypowder', '19th Floor', 'PO BS021');

GO

PRINT 'CREATE TABLE Customer';

GO

-- Create a new table called '[DoesBusinessIn]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[DoesBusinessIn]', 'U') IS NOT NULL
DROP TABLE [dbo].[DoesBusinessIn]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[DoesBusinessIn]
(
    [DoesBusinessInID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [TerritoryID] INT NOT NULL,
    [CustomerID] INT NOT NULL,
    CONSTRAINT FK_DoesBusinessIn_Territory_TerritoryID FOREIGN KEY (TerritoryID)
    REFERENCES Territory(TerritoryID), 
    CONSTRAINT FK_DoesBusinessIn_Customer FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
    -- Specify more columns here
);
GO

INSERT INTO DoesBusinessIn(TerritoryID,CustomerID)VALUES(1,1);
INSERT INTO DoesBusinessIn(TerritoryID,CustomerID)VALUES(2,2);
INSERT INTO DoesBusinessIn(TerritoryID,CustomerID)VALUES(3,8);

GO

PRINT 'CREATE TABLE DoesBusinessIn';

GO

-- Create a new table called '[ProductLine]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[ProductLine]', 'U') IS NOT NULL
DROP TABLE [dbo].[ProductLine]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[ProductLine]
(
    [ProductLineID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [ProductLine_Name] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO ProductLine(ProductLine_Name)VALUES('LINE 1');
INSERT INTO ProductLine(ProductLine_Name)VALUES('LINE 2');
INSERT INTO ProductLine(ProductLine_Name)VALUES('LINE 3');

GO

PRINT 'CREATE TABLE ProductLine';

GO
-- Create a new table called '[Product]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Product]', 'U') IS NOT NULL
DROP TABLE [dbo].[Product]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Product]
(
    [ProductID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [ProductLineID] INT NOT NULL,
    [Product_Description] NVARCHAR(250) NOT NULL,
    [Product_Finish] NVARCHAR(250) NOT NULL,
    [Product_Standard_Price] DECIMAL(10,2) NOT NULL
    -- Specify more columns here
    CONSTRAINT FK_Product_ProductLine_ProductLineID FOREIGN KEY (ProductLineID)
    REFERENCES ProductLine(ProductLineID)
);
GO

INSERT INTO Product(ProductLineID, Product_Description, Product_Finish, Product_Standard_Price)VALUES(1,'TABLE','YES',25.20);
INSERT INTO Product(ProductLineID, Product_Description, Product_Finish, Product_Standard_Price)VALUES(2,'CELLPHONE','NO',255.20);
INSERT INTO Product(ProductLineID, Product_Description, Product_Finish, Product_Standard_Price)VALUES(3,'CABLE','YES',500.20);

GO

PRINT 'CREATE TABLE Product';

GO

-- Create a new table called '[Order]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Order]', 'U') IS NOT NULL
DROP TABLE [dbo].[Order]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Order]
(
    [OrderID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [CustomerID] INT NOT NULL,
    [Order_Date] DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Order_Customer_CustomerID FOREIGN KEY (CustomerID)
    REFERENCES Customer(CustomerID)
    -- Specify more columns here
);
GO

INSERT INTO [Order](CustomerID)VALUES(5);
INSERT INTO [Order](CustomerID)VALUES(3);
INSERT INTO [Order](CustomerID)VALUES(1);
INSERT INTO [Order](CustomerID)VALUES(3);
INSERT INTO [Order](CustomerID)VALUES(8);

GO

PRINT 'CREATE TABLE Order';

GO
-- Create a new table called '[OrderLine]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[OrderLine]', 'U') IS NOT NULL
DROP TABLE [dbo].[OrderLine]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[OrderLine]
(
    [OrderLineID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [OrderID] INT NOT NULL,
    [ProductID] INT NOT NULL,
    [Ordered_Quantity] INT NOT NULL,
    -- Specify more columns here
    CONSTRAINT FK_OrderLine_Order_OrderID FOREIGN KEY (OrderID)
    REFERENCES [Order](OrderID),
    CONSTRAINT FK_OrderLine_Product_ProductID FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)

);
GO

INSERT INTO OrderLine(OrderID,ProductID,Ordered_Quantity)VALUES(1,1,30);
INSERT INTO OrderLine(OrderID,ProductID,Ordered_Quantity)VALUES(4,2,10);
INSERT INTO OrderLine(OrderID,ProductID,Ordered_Quantity)VALUES(3,3,20);
INSERT INTO OrderLine(OrderID,ProductID,Ordered_Quantity)VALUES(2,2,3);
INSERT INTO OrderLine(OrderID,ProductID,Ordered_Quantity)VALUES(5,3,5);

GO

PRINT 'CREATE TABLE OrderLine';

GO
-- Create a new table called '[WorkCenter]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[WorkCenter]', 'U') IS NOT NULL
DROP TABLE [dbo].[WorkCenter]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[WorkCenter]
(
    [WorkCenterID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [WorkCenter_Location] NVARCHAR(250) NOT NULL,
     -- Specify more columns here
);
GO

INSERT INTO WorkCenter(WorkCenter_Location)VALUES('Kitchener');
INSERT INTO WorkCenter(WorkCenter_Location)VALUES('Toronto');
INSERT INTO WorkCenter(WorkCenter_Location)VALUES('Waterloo');

GO

PRINT 'CREATE TABLE WorkCenter';

GO
-- Create a new table called '[ProducedIn]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[ProducedIn]', 'U') IS NOT NULL
DROP TABLE [dbo].[ProducedIn]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[ProducedIn]
(
    [ProducedInID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [WorkCenterID] INT NOT NULL,
    [ProductID] INT NOT NULL,
    -- Specify more columns here
    CONSTRAINT FK_ProducedIn_WorkCenter_WorkCenterID FOREIGN KEY (WorkCenterID)
    REFERENCES [WorkCenter](WorkCenterID),
    CONSTRAINT FK_ProducedIn_Product_ProductID FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);
GO

INSERT INTO ProducedIn(WorkCenterID,ProductID)VALUES(1,1);
INSERT INTO ProducedIn(WorkCenterID,ProductID)VALUES(2,2);
INSERT INTO ProducedIn(WorkCenterID,ProductID)VALUES(3,3);

GO

PRINT 'CREATE TABLE ProducedIn';

GO
-- Create a new table called '[Employee]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Employee]', 'U') IS NOT NULL
DROP TABLE [dbo].[Employee]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Employee]
(
    [EmployeeID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [SupervisesID] INT NULL,
    [Employee_Name] NVARCHAR(250) NOT NULL,
    [Employee_Address] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Employee(SupervisesID,Employee_Name,Employee_Address)VALUES(NULL, 'Juan Perez','47 Dellroy Ave');
INSERT INTO Employee(SupervisesID,Employee_Name,Employee_Address)VALUES(1, 'Juana Cardenas','50 Dellroy Ave');
INSERT INTO Employee(SupervisesID,Employee_Name,Employee_Address)VALUES(2, 'Carlos Matos','7 Dellroy Ave');

GO

PRINT 'CREATE TABLE Employee';


GO

-- Create a new table called '[Skill]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Skill]', 'U') IS NOT NULL
DROP TABLE [dbo].[Skill]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Skill]
(
    [SkillID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [Skill_Name] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Skill(Skill_Name)VALUES('Hard Worker');
INSERT INTO Skill(Skill_Name)VALUES('Slave');

GO

PRINT 'CREATE TABLE Skill';


GO
-- Create a new table called '[HasSkill]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[HasSkill]', 'U') IS NOT NULL
DROP TABLE [dbo].[HasSkill]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[HasSkill]
(
    [HasSkillID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [SkillID] INT NOT NULL,
    [EmployeeID] INT NOT NULL,
    -- Specify more columns here
    CONSTRAINT FK_HasSkill_Skill_SkillID FOREIGN KEY (SkillID)
    REFERENCES [Skill](SkillID),
    CONSTRAINT FK_HasSkill_Employee_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES Employee(EmployeeID)
);
GO

INSERT INTO [dbo].[HasSkill](SkillID,EmployeeID)VALUES(1,2);
INSERT INTO [dbo].[HasSkill](SkillID,EmployeeID)VALUES(2,2);
INSERT INTO [dbo].[HasSkill](SkillID,EmployeeID)VALUES(1,1);
INSERT INTO [dbo].[HasSkill](SkillID,EmployeeID)VALUES(2,1);

GO

PRINT 'CREATE TABLE HasSkill';

GO
-- Create a new table called '[WorkIn]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[WorkIn]', 'U') IS NOT NULL
DROP TABLE [dbo].[WorkIn]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[WorkIn]
(
    [WorkInID] INT NOT NULL PRIMARY KEY IDENTITY(1,1),  -- Primary Key column
    [EmployeeID] INT NOT NULL,
    [WorkCenterID] INT NOT NULL,
    -- Specify more columns here
    CONSTRAINT FK_WorkIn_Employee_EmployeeID FOREIGN KEY (EmployeeID)
    REFERENCES [Employee](EmployeeID),
    CONSTRAINT FK_HasSkill_WorkCenter_WorkCenterID FOREIGN KEY (WorkCenterID)
    REFERENCES WorkCenter(WorkCenterID)
);
GO

INSERT INTO WorkIn(EmployeeID,WorkCenterID)VALUES(1,1);
INSERT INTO WorkIn(EmployeeID,WorkCenterID)VALUES(2,1);
INSERT INTO WorkIn(EmployeeID,WorkCenterID)VALUES(3,2);

GO

PRINT 'CREATE TABLE WorkIn';

GO

-- Create a new table called '[Vendor]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Vendor]', 'U') IS NOT NULL
DROP TABLE [dbo].[Vendor]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Vendor]
(
    [VendorID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [Vendor_Name] NVARCHAR(50) NOT NULL
);
GO

INSERT INTO Vendor(Vendor_Name)VALUES('Carlos Perkins');
INSERT INTO Vendor(Vendor_Name)VALUES('Paula Martinez');

GO

PRINT 'CREATE TABLE Vendor';

GO
-- Create a new table called '[Supplies]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Supplies]', 'U') IS NOT NULL
DROP TABLE [dbo].[Supplies]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Supplies]
(
    [SuppliesID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [VendorID] INT NOT NULL,
    [SupplyUnitPrice] DECIMAL NOT NULL
    -- Specify more columns here
    CONSTRAINT FK_Supplies_Vendor_VendorID FOREIGN KEY (VendorID)
    REFERENCES [Vendor](VendorID)
);
GO

INSERT INTO [dbo].[Supplies]([VendorID],SupplyUnitPrice)VALUES(1,10.10);
INSERT INTO [dbo].[Supplies]([VendorID],SupplyUnitPrice)VALUES(2,100.10);

GO

PRINT 'CREATE TABLE Supplies';

GO
-- Create a new table called '[RawMaterial]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[RawMaterial]', 'U') IS NOT NULL
DROP TABLE [dbo].[RawMaterial]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[RawMaterial]
(
    [MaterialId] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [SuppliesID] INT NOT NULL,
    [Material_Name] NVARCHAR(250) NOT NULL,
    [Material_StandardCost] DECIMAL(10,2) NOT NULL,
    [Material_UnitOfMesure] NVARCHAR(250) NOT NULL
    -- Specify more columns here
    CONSTRAINT FK_RawMaterial_Supplies_SuppliesID FOREIGN KEY (SuppliesID)
    REFERENCES [Supplies](SuppliesID),
);
GO

INSERT INTO [dbo].[RawMaterial](SuppliesID,Material_Name,Material_StandardCost,Material_UnitOfMesure)VALUES(1,'Wood',25.00,'Meter');

GO

PRINT 'CREATE TABLE RawMaterial';

GO

-- Create a new table called '[Uses]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Uses]', 'U') IS NOT NULL
DROP TABLE [dbo].[Uses]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Uses]
(
    [UsesID] INT NOT NULL PRIMARY KEY IDENTITY(1,1), -- Primary Key column
    [MaterialId] INT NOT NULL, 
    [ProductID] INT NOT NULL,
    -- Specify more columns here
    CONSTRAINT FK_Uses_RawMaterial_MaterialId FOREIGN KEY (MaterialId)
    REFERENCES [RawMaterial](MaterialId),
    CONSTRAINT FK_Uses_Product_ProductID FOREIGN KEY (ProductID)
    REFERENCES Product(ProductID)
);
GO

INSERT INTO Uses(MaterialId,ProductID)VALUES(1,1);
INSERT INTO Uses(MaterialId,ProductID)VALUES(1,2);

PRINT 'CREATE TABLE Uses';
PRINT 'END';
GO