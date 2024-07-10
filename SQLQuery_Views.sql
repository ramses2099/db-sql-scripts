--1 Create a view named EmployeeNames that selects the FirstName and LastName columns from the HumanResources.Employee table.


CREATE VIEW dbo.EmployeeNames AS
SELECT 
     p.[FirstName]
    ,p.[LastName]
FROM [HumanResources].[Employee] e
	INNER JOIN [Person].[Person] p
	ON p.[BusinessEntityID] = e.[BusinessEntityID]


SELECT * FROM dbo.EmployeeNames

--2 Create a view named RecentOrders that includes SalesOrderID, OrderDate, and TotalDue from the Sales.SalesOrderHeader table for orders placed after January 1, 2015.

CREATE VIEW dbo.RecentOrders AS
SELECT
SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader 
WHERE OrderDate > '2015-01-01'

SELECT * FROM dbo.RecentOrders

--3 Create a view named TotalSalesPerProduct that shows ProductID and the total quantity sold for each product from the Sales.SalesOrderDetail table.  

CREATE VIEW dbo.TotalSalesPerProduct AS
SELECT 
ss.ProductID,
pd.name as ProductName,
SUM(ss.OrderQty) AS Total_Quantity
FROM Sales.SalesOrderDetail ss 
    INNER JOIN [Production].[vProductAndDescription] pd ON pd.ProductID = ss.ProductID
GROUP BY ss.ProductID,pd.name 

SELECT * FROM dbo.TotalSalesPerProduct;

--4 Create a view named EmployeeStatus that selects EmployeeID, FirstName, LastName, and a new column Status which shows 'Active' if the employee is currently employed and 'Inactive' otherwise.

CREATE VIEW EmployeeStatus
AS
SELECT e.BusinessEntityID AS EmployeeID, p.FirstName, p.LastName,*
 FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p ON e.BusinessEntityID = p.BusinessEntityID;

select * from  
[Person].[BusinessEntity]

-- AdventureWorks2019.HumanResources.EmployeePayHistory: FK_EmployeePayHistory_Employee_BusinessEntityID
sp_help 'HumanResources.EmployeePayHistory'



-- Create a view named EmployeeContact that includes EmployeeID, FirstName, LastName, and EmailAddress from the HumanResources.Employee and Person.EmailAddress tables. Allow updates to the EmailAddress. 

-- Create an indexed view named ProductOrderSummary that includes ProductID, OrderQty, and the total sales amount TotalDue. Ensure to use SCHEMABINDING.

-- Create a view named TopSellingProducts that shows ProductID, Name, and the total quantity sold for the top 5 products based on quantity sold.

-- Create a view named CustomerOrders that shows CustomerID, SalesOrderID, and OrderDate from the Sales.Customer and Sales.SalesOrderHeader tables. Write a stored procedure that takes CustomerID as a parameter and returns all orders for that customer using the view.

-- Create a view named AllContacts that combines the Person.Person table for employee contacts and the Person.Contact table for customer contacts, including ContactID, FirstName, LastName, and ContactType ('Employee' or 'Customer').
