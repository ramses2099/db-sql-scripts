USE AdventureWorks2019
-- DATA CONTROL

USE master;
GO
CREATE LOGIN test_2 WITH PASSWORD='1234',
DEFAULT_DATABASE=master, CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
GO
USE AdventureWorks2019
GO
CREATE USER test_2 FOR LOGIN test_2

-- Grant
GRANT SELECT, INSERT, UPDATE ON [Person].[Person] TO [test_user];

-- Deny
DENY UPDATE ON [Person].[Person] TO [test_user];

-- Revoke
REVOKE SELECT ON [Person].[Person] TO [test_user];


-- TCL - Transaction control language
-- BEGIN TRAN
-- COMMIT TRAN
-- ROLLBACK

IF OBJECT_ID('dbo.TEST', 'U') IS NOT NULL
  DROP TABLE dbo.TEST
GO

CREATE TABLE TEST(
  Id int primary key identity(1,1) not null,
  [name] varchar(250) not null
 )

SELECT * FROM TEST

BEGIN TRY
	BEGIN TRANSACTION 
	INSERT INTO TEST(name)VALUES('JUAN PEREZ')
	INSERT INTO TEST(name)VALUES(NULL)
	COMMIT TRANSACTION
END TRY
BEGIN CATCH 
	IF @@TRANCOUNT > 0 ROLLBACK
	SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
END CATCH

-- EXEC usp_GetErrorInfo

/*--
-- Verify that the stored procedure does not already exist.  
IF OBJECT_ID ( 'usp_GetErrorInfo', 'P' ) IS NOT NULL   
    DROP PROCEDURE usp_GetErrorInfo;  
GO  
  
-- Create procedure to retrieve error information.  
CREATE PROCEDURE usp_GetErrorInfo  
AS  
SELECT  
    ERROR_NUMBER() AS ErrorNumber  
    ,ERROR_SEVERITY() AS ErrorSeverity  
    ,ERROR_STATE() AS ErrorState  
    ,ERROR_PROCEDURE() AS ErrorProcedure  
    ,ERROR_LINE() AS ErrorLine  
    ,ERROR_MESSAGE() AS ErrorMessage;  
GO  
  
BEGIN TRY  
    -- Generate divide-by-zero error.  
    SELECT 1/0;  
END TRY  
BEGIN CATCH  
    -- Execute error retrieval routine.  
    EXECUTE usp_GetErrorInfo;  
END CATCH;   
--*/














