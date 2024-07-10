--//-----------------------------------------------------------------------------------------------------------//--
-- Assigment 03
-- Date: 2024-06-12
-- Name: Jose Encarnacion
-- Student no: 8982860
--//-----------------------------------------------------------------------------------------------------------//--
USE AdventureWorks2019;


--1 Display All Columns of All Products:

GO

SELECT * FROM Production.Product;

--2 Display Primary Key, Product Name, Number, and List Price of All Products:

GO

SELECT ProductID, Name AS ProductName, ProductNumber, ListPrice FROM Production.Product;

--3 Display Product ID, Product Name, Number, and List Price of All Products Where List Price is $0.00:

GO

SELECT ProductID, Name AS ProductName, ProductNumber, ListPrice 
FROM Production.Product
WHERE ListPrice = 0.00;

--4 Display Product ID, Product Name, Number, and List Price of All Products Where List Price is Greater than $0 but Less Than $10:

GO

SELECT ProductID, Name AS ProductName, ProductNumber, ListPrice 
FROM Production.Product
WHERE ListPrice > 0.00 AND ListPrice < 10.00;

--5 Display Product ID, Product Name, Number, and List Price of All Products Where List Price is Either $9.5 or $2.29:

GO

SELECT ProductID, Name AS ProductName, ProductNumber, ListPrice 
FROM Production.Product
WHERE ListPrice IN (9.50, 2.29);

--6 Concatenate Last Name, First Name, and Middle Name from the Person Table with Appropriate Commas and Spaces Between the Data:

GO

SELECT LastName + ', ' + FirstName + ISNULL(', ' + MiddleName, '') AS FullName
FROM Person.Person;

--7 Display Distinct Job Titles from the Employee Table and Sort Them in Descending Order:

GO

SELECT DISTINCT JobTitle 
FROM HumanResources.Employee
ORDER BY JobTitle DESC;

--8 Display Employee ID as “ID”, Job Title as “Job Title”, and Hire Date as “Date Hired”:

GO

SELECT BusinessEntityID AS ID, JobTitle AS [Job Title], HireDate AS [Date Hired]
FROM HumanResources.Employee;

--9 Display Employee Last and First Name as “Employee Name”, Job Title as “Job Title”, Hire Date as “Date Hired”, and Sort Data by Last then First Name:

GO

SELECT 
    LastName + ', ' + FirstName AS [Employee Name], 
    JobTitle AS [Job Title], 
    HireDate AS [Date Hired]
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY 
    LastName, FirstName;

--10 Display Employee Name, Job Title, and Age:

GO

SELECT 
    LastName + ', ' + FirstName AS [Employee Name], 
    JobTitle, 
    DATEDIFF(YEAR, BirthDate, GETDATE()) AS Age
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID;

--11 Display Only One Employee Who Has the Most Vacation Hours. Display Employee Name, Job Title, and Vacation Hours:

GO

SELECT TOP 1 
    LastName + ', ' + FirstName AS [Employee Name], 
    JobTitle, 
    VacationHours
FROM 
    HumanResources.Employee e
JOIN 
    Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
ORDER BY 
    VacationHours DESC;

--12 Display the Number of Sales Territories as “Number of Sales Territories”:

GO

SELECT COUNT(*) AS [Number of Sales Territories]
FROM Sales.SalesTerritory;

--13 Add Up the Sales Year to Date for All Sales Territories and Display as “Sum of All Sales”:

GO

SELECT SUM(SalesYTD) AS [Sum of All Sales]
FROM Sales.SalesTerritory;

--14 Display Sum of All Sales Year to Date, Average Sale, Minimum Sale, and Maximum Sale:

GO

SELECT 
    SUM(SalesYTD) AS [Sum of All Sales], 
    AVG(SalesYTD) AS [Average Sale], 
    MIN(SalesYTD) AS [Minimum Sale], 
    MAX(SalesYTD) AS [Maximum Sale]
FROM 
    Sales.SalesTerritory;

--15 Insert a New CountryRegion Record in [Person].[CountryRegion]. Display New Region That Has Been Inserted:

GO

INSERT INTO Person.CountryRegion (CountryRegionCode, Name, ModifiedDate)
VALUES ('XYZ', 'New Region', GETDATE());

SELECT * FROM Person.CountryRegion WHERE CountryRegionCode = 'XYZ';

--16 Update New Country Region. Display New Region That Has Been Updated:

GO

UPDATE Person.CountryRegion
SET Name = 'Updated Region'
WHERE CountryRegionCode = 'XYZ';

SELECT * FROM Person.CountryRegion WHERE CountryRegionCode = 'XYZ';

--17 Delete New Country Region. Display Results of Query That Shows That New Region Does Not Exist Anymore:

GO

DELETE FROM Person.CountryRegion
WHERE CountryRegionCode = 'XYZ';

SELECT * FROM Person.CountryRegion WHERE CountryRegionCode = 'XYZ';

--18 Display the Current Date and Time as “Current Date and Time”:

GO

SELECT GETDATE() AS [Current Date and Time];

--19 Display the Current Month Only as “Current Month”:

GO

SELECT MONTH(GETDATE()) AS [Current Month];

--20 Display Today’s Date One Year from Now:

GO

SELECT DATEADD(YEAR, 1, GETDATE()) AS [Date One Year from Now];
