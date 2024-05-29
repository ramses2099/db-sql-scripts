-- Create Sales Order Database

USE MASTER;
SET NOCOUNT ON;

DECLARE @version NVARCHAR(10);
DECLARE @dbname NVARCHAR(20);

SET @version = '0.1';
SET @dbname = 'SalesOrders';

PRINT '***********************************************************';
PRINT 'CreateSalesOrdersDatabase.sql Starting';
PRINT 'Script Version ' + @version;
PRINT '***********************************************************';


PRINT '>>> Does an SalesOrders database already exist?';


IF EXISTS (SELECT [name] FROM sys.databases WHERE [name] = 'SalesOrders')
    BEGIN
        PRINT '>>> Yes, an ' + @dbname +'Database already exists';
        PRINT '>>> Rolling back pending ' + @dbname + 'transactions';

        ALTER DATABASE SalesOrders
            SET SINGLE_USER
            WITH ROLLBACK IMMEDIATE;

        PRINT '>>> Dropping the existing ' + @dbname + 'database';
        DROP DATABASE SalesOrders;
    END
ELSE
    BEGIN
        PRINT '>>> No, there is  no ' + @dbname + 'database'; 
    END


PRINT '>>> Creating a new '  + @dbname + 'database';

CREATE DATABASE SalesOrders;

GO

USE SalesOrders;

