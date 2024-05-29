--  SELECT * from dbo.customers;

-- DECLARE @listFirstname VARCHAR(500)
-- SELECT @listFirstname = COALESCE(@listFirstname + ', ','') +  customer_first_name FROM dbo.customers

-- PRINT @listFirstname;

-- -- REMOVE ROWS DUPLICATES
-- IF OBJECT_ID('[dbo].[Duplicates]', 'U') IS NOT NULL
-- DROP TABLE [dbo].[Duplicates]
-- GO
-- -- Create the table in the specified schema
-- CREATE TABLE [dbo].[Duplicates]
-- (
    
--     [Fact_Date] date NOT NULL,
--     [FirstName] NVARCHAR(50) NOT NULL,
--     [LastName] NVARCHAR(50) NOT NULL,
--     [AddressLine1] NVARCHAR(50) NOT NULL,
--     [City] NVARCHAR(50) NOT NULL,
--     [State] NVARCHAR(50) NOT NULL
-- );
-- GO

-- -- Insert rows into table 'TableName' in schema '[dbo]'
-- INSERT INTO [dbo].[Duplicates]
-- ( -- Columns to insert data into
--     [Fact_Date], [FirstName],[LastName],[AddressLine1],[City], [State]
-- )
-- VALUES
-- ('2015-01-02','Juan','Perez','15 Dellroy ave','Kitchener','ON'),
-- ('2015-01-02','Juan','Perez','15 Dellroy ave','Kitchener','ON'),
-- ('2015-01-02','Juana','Perez','15 Dellroy ave','Kitchener','ON'),
-- ('2015-01-02','Juana','Perez','15 Dellroy ave','Kitchener','ON'),
-- ('2015-01-02','Carlos','Martes','15 Dellroy ave','Kitchener','ON'),
-- ('2015-01-02','Carlos','Martes','15 Dellroy ave','Kitchener','ON')

-- SELECT * FROM Duplicates

-- WITH rduplicate ([Fact_Date], [FirstName],[LastName],[AddressLine1],[City], [State],ID) AS(
--     SELECT [Fact_Date], [FirstName],[LastName],[AddressLine1],[City], [State],
--     ROW_NUMBER() OVER (PARTITION BY [Fact_Date], [FirstName],[LastName],[AddressLine1],[City], [State] ORDER BY Fact_Date) as ID
--     FROM dbo.Duplicates
-- )
-- -- SELECT * FROM rduplicate;
-- DELETE FROM rduplicate WHERE ID <> 1

---//--------------------------------------------------------------------------------//---
---//                                   RECURSIVE CTEs                               //---
---//--------------------------------------------------------------------------------//---


-- WITH dates ([Date]) AS (
--     SELECT DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1) AS [Date]
--     UNION ALL
--     SELECT DATEADD(DAY, 1, [Date])
--     FROM dates
--     WHERE [Date] < EOMONTH(GETDATE())
-- )

-- SELECT [Date], 0
-- FROM dates
-- OPTION (maxrecursion 32767)


---//--------------------------------------------------------------------------------//---
---//                                   PIVOT TRANSFORM                              //---
---//--------------------------------------------------------------------------------//---
