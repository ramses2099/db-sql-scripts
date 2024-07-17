-- Stored Procedure to Add a Book
CREATE PROCEDURE sp_AddBook
    @Title NVARCHAR(100),
    @Author NVARCHAR(100),
    @Quantity INT,
    @Price DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO Books (Title, Author, Quantity, Price)
    VALUES (@Title, @Author, @Quantity, @Price);
END;

-- Stored Procedure to Sell a Book
CREATE PROCEDURE sp_SellBook
    @BookID INT,
    @QuantitySold INT
AS
BEGIN
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Update book quantity
        -- WRITE YOUR CODE HERE

        -- Insert into Sales
        -- WRITE YOUR CODE HERE

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
