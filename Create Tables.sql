CREATE TABLE Books (
    BookID INT PRIMARY KEY IDENTITY,
    Title NVARCHAR(100),
    Author NVARCHAR(100),
    Quantity INT CHECK (Quantity >= 0),
    Price DECIMAL(10, 2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY,
    BookID INT,
    QuantitySold INT,
    SaleDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

CREATE TABLE Users (
    UserID INT PRIMARY KEY IDENTITY,
    Username NVARCHAR(50),
    Role NVARCHAR(50)
);

CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY,
    RoleName NVARCHAR(50)
);

CREATE TABLE AuditLog (
    AuditID INT PRIMARY KEY IDENTITY,
    UserID INT,
    Operation NVARCHAR(50),
    TableName NVARCHAR(50),
    ChangeDateTime DATETIME DEFAULT GETDATE()
);
