-- =============================================
-- Create basic stored procedure template
-- =============================================

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'udfCreateLoginUser' 
)
   DROP PROCEDURE dbo.udfCreateLoginUser
GO

CREATE PROCEDURE dbo.udfCreateLoginUser
	@LoginName NVARCHAR(250), 
	@Password NVARCHAR(250),
	@Database NVARCHAR(250),
	@TableName NVARCHAR(250),
	@Permission NVARCHAR(250)
AS

	DECLARE @SQL_QUERY NVARCHAR(MAX)
	
	
	IF SUSER_ID(@LoginName) IS NULL
		SET @SQL_QUERY = 'DROP LOGIN '+ @LoginName +';';  
	IF USER_ID(@LoginName) IS NULL
		SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'DROP USER IF EXISTS ' + @LoginName + ';';	

	SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'CREATE LOGIN ' + @LoginName + ' WITH PASSWORD = ''' + @Password + ''' ,DEFAULT_DATABASE =' + @Database + ',CHECK_POLICY = OFF, CHECK_EXPIRATION = OFF;' 
	SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'USE ' + @Database + ';'
	SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'CREATE USER ' + @LoginName + ' FOR LOGIN ' + @LoginName + ';'
	SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'GRANT ' + @Permission +' ON ' + @TableName + ' TO ' + @LoginName +';'
	
	
	EXECUTE sp_executesql @SQL_QUERY;
	PRINT('Login for user ' + @LoginName + ' Create completed successfully.');
	
GO

-- =============================================
-- Example to execute the stored procedure
-- =============================================
EXECUTE dbo.udfCreateLoginUser @LoginName ='jssee'
 							  ,@Password = '123456'
							  ,@Database = 'testdb'
							  ,@TableName = 'dbo.Course'
							  ,@Permission = 'SELECT, UPDATE, INSERT';


-- DROP USER --
DECLARE @login_name VARCHAR(150)
SET @login_name = 'jssee';

DECLARE @SQL_QUERY NVARCHAR(MAX)

SET @SQL_QUERY = 'DROP LOGIN '+ @login_name +';';  
SET @SQL_QUERY = @SQL_QUERY + CHAR(13) + 'DROP USER IF EXISTS ' + @login_name + ';';

EXECUTE sp_executesql @SQL_QUERY;

-- REVOKE
REVOKE INSERT ON tablename TO username;

-- Deny
DENY UPDATE ON tablename TO username;