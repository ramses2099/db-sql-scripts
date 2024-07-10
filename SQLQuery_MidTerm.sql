USE AdventureWorks2019;
GO
CREATE SCHEMA Filtering; 
GO
-- Create a new table called 'UserRatings' in schema '[Filtering]'
-- Drop the table if it already exists
IF OBJECT_ID('[Filtering].[UserRatings]', 'U') IS NOT NULL
DROP TABLE [Filtering].[UserRatings]
GO
-- Create the table in the specified schema
CREATE TABLE [Filtering].[UserRatings]
(
    UserRatingID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    Rating DECIMAL(2, 1) CHECK (Rating >= 0 AND Rating <= 5),
    RatingDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Person.Person(BusinessEntityID),
    FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
    -- Specify more columns here
);
GO
-- Create a new table called '[UserSimilarity]' in schema '[Filtering]'
-- Drop the table if it already exists
IF OBJECT_ID('[Filtering].[UserSimilarity ]', 'U') IS NOT NULL
DROP TABLE [Filtering].[UserSimilarity]
GO
-- Create the table in the specified schema
CREATE TABLE [Filtering].[UserSimilarity]
(
    UserSimilarityID INT PRIMARY KEY IDENTITY(1,1),
    UserID1 INT NOT NULL,
    UserID2 INT NOT NULL,
    SimilarityScore DECIMAL(3, 2) CHECK (SimilarityScore >= 0 AND SimilarityScore <= 1),
    FOREIGN KEY (UserID1) REFERENCES Person.Person(BusinessEntityID),
    FOREIGN KEY (UserID2) REFERENCES Person.Person(BusinessEntityID),
    CONSTRAINT CHK_UserIDPair CHECK (UserID1 < UserID2)
    -- Specify more columns here
);
GO
-- Create a new table called '[UserInteractions]' in schema '[Filtering]'
-- Drop the table if it already exists
IF OBJECT_ID('[Filtering].[UserInteractions]', 'U') IS NOT NULL
DROP TABLE [Filtering].[UserInteractions]
GO
-- Create the table in the specified schema
CREATE TABLE [Filtering].[UserInteractions]
(
    UserInteractionID INT PRIMARY KEY IDENTITY(1,1),
    UserID INT NOT NULL,
    ProductID INT NOT NULL,
    InteractionType NVARCHAR(50) NOT NULL,
    InteractionDate DATETIME NOT NULL DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Person.Person(BusinessEntityID),
    FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID)
    -- Specify more columns here
);
GO
-- Create a new table called '[ProductCategories]' in schema '[Filtering]'
-- Drop the table if it already exists
IF OBJECT_ID('[Filtering].[ProductCategories]', 'U') IS NOT NULL
DROP TABLE [Filtering].[ProductCategories]
GO
-- Create the table in the specified schema
CREATE TABLE [Filtering].[ProductCategories]
(
    ProductCategoryID INT PRIMARY KEY IDENTITY(1,1),
    ProductID INT NOT NULL,
    CategoryID INT NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Production.Product(ProductID),
    FOREIGN KEY (CategoryID) REFERENCES Production.ProductCategory(ProductCategoryID)
    -- Specify more columns here
);
GO


-- UserRatings Table
INSERT INTO [Filtering].[UserRatings] (UserID, ProductID, Rating)
VALUES 
(1, 322, 4.5),
(2, 324, 3.0),
(3, 327, 5.0),
(1, 329, 2.5),
(2, 328, 4.0),
(3, 341, 1.0);

SELECT * FROM [Filtering].[UserRatings]

-- UserSimilarity Table
INSERT INTO [Filtering].[UserSimilarity] (UserID1, UserID2, SimilarityScore)
VALUES 
(1, 2, 0.75),
(1, 3, 0.60),
(2, 3, 0.80);

SELECT * FROM [Filtering].[UserSimilarity];

-- UserInteractions Table
INSERT INTO [Filtering].[UserInteractions] (UserID, ProductID, InteractionType)
VALUES 
(1, 322, 'View'),
(2, 324, 'Click'),
(3, 327, 'Purchase'),
(1, 329, 'View'),
(2, 328, 'Click'),
(3, 341, 'View');

SELECT * FROM [Filtering].[UserInteractions];


-- ProductCategories Table
INSERT INTO [Filtering].[ProductCategories] (ProductID, CategoryID)
VALUES 
(322, 1),
(324, 2),
(327, 1),
(329, 4),
(328, 3),
(341, 2);


-- Retrieve all ratings given by a specific user:
SELECT * FROM [Filtering].[UserRatings] WHERE UserID = 1;
-- Retrieve all interactions for a specific product:
SELECT * FROM [Filtering].[UserInteractions] WHERE ProductID = 322;
-- Retrieve similarity scores for a specific user:
SELECT * FROM [Filtering].[UserSimilarity] WHERE UserID1 = 1 OR UserID2 = 1;
-- Retrieve product categories:
SELECT * FROM [Filtering].[ProductCategories];


-- User rating product interations
SELECT  
ur.UserRatingID,
p.FirstName + ' ' + p.LastName as FullName,
ui.InteractionType,
pt.name as ProductName,
ur.Rating,
ur.RatingDate
FROM [Filtering].[UserRatings] ur
INNER JOIN  Person.Person p ON p.BusinessEntityID = ur.UserID 
INNER JOIN Production.Product pt ON pt.ProductID = ur.ProductID
INNER JOIN [Filtering].[UserInteractions] ui ON ui.UserID = ur.UserID and ui.ProductID = ur.ProductID
WHERE ur.UserID = 1;

