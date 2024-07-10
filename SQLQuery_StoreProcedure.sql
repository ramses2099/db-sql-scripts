-- Create a new stored procedure called 'StoredProcedureName' in schema 'dbo'
-- Drop the stored procedure if it already exists
IF EXISTS (
SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
WHERE SPECIFIC_SCHEMA = N'dbo'
    AND SPECIFIC_NAME = N'uspSalesSummary'
    AND ROUTINE_TYPE = N'PROCEDURE'
)
DROP PROCEDURE dbo.uspSalesSummary
GO
-- Create the stored procedure in the specified schema
-- Display Sum of All Sales Year to Date, Average Sale, Minimum Sale, and Maximum Sale:

CREATE PROCEDURE dbo.uspSalesSummary
-- add more stored procedure parameters here
AS
BEGIN
    -- body of the stored procedure
    SELECT 
    SUM(SalesYTD) AS [Sum of All Sales], 
    AVG(SalesYTD) AS [Average Sale], 
    MIN(SalesYTD) AS [Minimum Sale], 
    MAX(SalesYTD) AS [Maximum Sale]
FROM 
    Sales.SalesTerritory;

END
GO
-- example to execute the stored procedure we just created
EXECUTE dbo.uspSalesSummary
GO



-- Rewrite the procedure to perform the same operations using the
-- MERGE statement.
-- Create a temporary table to hold the updated or inserted values
-- from the OUTPUT clause.
CREATE TABLE #MyTempTable (
    ExistingCode NCHAR(3),
    ExistingName NVARCHAR(50),
    ExistingDate DATETIME,
    ActionTaken NVARCHAR(10),
    NewCode NCHAR(3),
    NewName NVARCHAR(50),
    NewDate DATETIME
);
GO

CREATE PROCEDURE dbo.uspSaveUnitMeasure @UnitMeasureCode NCHAR(3),
    @Name NVARCHAR(25)
AS
BEGIN
    SET NOCOUNT ON;

    MERGE Production.UnitMeasure AS tgt
    USING (SELECT @UnitMeasureCode, @Name) AS src(UnitMeasureCode, Name)
        ON (tgt.UnitMeasureCode = src.UnitMeasureCode)
    WHEN MATCHED
        THEN
            UPDATE
            SET Name = src.Name
    WHEN NOT MATCHED
        THEN
            INSERT (UnitMeasureCode, Name)
            VALUES (src.UnitMeasureCode, src.Name)
    OUTPUT deleted.*,
        $action,
        inserted.*
    INTO #MyTempTable;
END;
GO

-- Test the procedure and return the results.
EXEC uspSaveUnitMeasure @UnitMeasureCode = 'ABC', @Name = 'New Test Value';
EXEC uspSaveUnitMeasure @UnitMeasureCode = 'XYZ', @Name = 'Test Value';
EXEC uspSaveUnitMeasure @UnitMeasureCode = 'ABC', @Name = 'Another Test Value';

SELECT * FROM #MyTempTable;

DROP TABLE #MyTempTable;