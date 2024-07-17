-- Trigger trg_UpdateStock on sales table after insert. This trigger will Update Stock. You need to use join operation to join Books table with inserted values (magic table).
WRITE YOUR CODE HERE

-- Trigger to Prevent Negative Stock
CREATE TRIGGER trg_PreventNegativeStock
ON Books
INSTEAD OF UPDATE
AS
BEGIN
    IF EXISTS (SELECT * FROM inserted WHERE Quantity < 0)
    BEGIN
        RAISERROR('Stock quantity cannot be negative.', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Need to update the Books table. Use join operation with the inserted values (magic table)
        -- WRITE YOUR CODE HERE
    END
END;

-- Trigger to Log Changes
CREATE TRIGGER trg_AuditLog
ON Books
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @UserID INT = (SELECT UserID FROM Users WHERE Username = ORIGINAL_LOGIN());

    INSERT INTO AuditLog (UserID, Operation, TableName)
    VALUES (@UserID, CASE WHEN EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted) THEN 'UPDATE'
                          WHEN EXISTS (SELECT * FROM inserted) THEN 'INSERT'
                          ELSE 'DELETE'
                     END,
                     'Books');
END;
