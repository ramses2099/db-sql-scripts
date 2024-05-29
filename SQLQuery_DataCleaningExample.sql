-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'DATAHR'
)
CREATE DATABASE DATAHR
GO

USE DATAHR;

-- Create a new table called '[employees]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[employees]', 'U') IS NOT NULL
DROP TABLE [dbo].[employees]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[employees]
(
    [employee_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Primary Key column
    [employee_name] NVARCHAR(100) NULL,
    [department_id] INT NULL,
    [gender] NVARCHAR(100) NULL,
    [salary] DECIMAL(9,2) NULL,
    [hire_date] DATETIME NULL                
    -- Specify more columns here
);
GO

-- Create a new table called '[departments]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[departments]', 'U') IS NOT NULL
DROP TABLE [dbo].[departments]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[departments]
(
    [department_id] INT NOT NULL IDENTITY(1,1) PRIMARY KEY, -- Primary Key column
    [department_name] NVARCHAR(50) NOT NULL
);
GO


INSERT INTO dbo.departments(department_name) values('Human Resources');
INSERT INTO dbo.departments(department_name) values('Marketing');
INSERT INTO dbo.departments(department_name) values('Finance');

INSERT INTO dbo.employees(employee_name,department_id,gender,salary,hire_date)
VALUES
('John Doe',1,'M',60000.00,'2022-01-15'),
('Jane Smith',2,'Female',75000.00,'2022-02-20'),
('Bob Johnson',1,'m',55000.00,'2022-03-10'),
('Alice Brown',3,'f',80000.00,'2022-04-05'),
('Charlie White',2,'male',70000.00,'2022-05-12'); 

INSERT INTO dbo.employees(employee_name,department_id,gender,salary,hire_date)
VALUES
('Eva Green',3,NULL,72000.00,'2022-06-18'),
('Frank Red',NULL,'F',60000.00,'2022-09-05'),
('Sophie Grey',2,NULL,65000.00,'2022-08-30')


INSERT INTO dbo.employees(employee_name,department_id,gender,salary,hire_date)
VALUES
('John Doe',1,'m',60000.00,'2022-01-15'),
('Jane Smith',2,'female',75000.00,'2022-02-20'),
('Bob Johnson',1,'m',55000.00,'2022-03-10')

SELECT * FROM departments;
SELECT * FROM employees;


SELECT COUNT(*)
FROM(
    SELECT employee_name,department_id,gender,salary,hire_date, COUNT(*) as quantity
    FROM employees
    GROUP BY employee_name,department_id,gender,salary,hire_date
) subquery
WHERE quantity > 1


SELECT * FROM employees
WHERE employee_name IS NULL OR 
department_id IS NULL OR
gender IS NULL;


 SELECT employee_name,department_id,
 CASE WHEN gender IS NULL THEN 'F' ELSE UPPER(SUBSTRING(gender,1,1)) END AS gender,salary,hire_date
    FROM employees


SELECT d.department_name, CAST(AVG(e.salary) AS DECIMAL(9,2)) as 'Avg Salary' 
 FROM employees e INNER JOIN departments d 
 ON e.department_id = d.department_id
 GROUP BY d.department_name

