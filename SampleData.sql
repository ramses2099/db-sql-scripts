-- Populate Roles Table
INSERT INTO Roles (RoleName) VALUES ('sales_manager'), ('inventory_manager');

-- Populate Users Table
INSERT INTO Users (Username, Role) VALUES ('Alice', 'sales_manager'), ('Bob', 'inventory_manager');

-- Populate Books Table
INSERT INTO Books (Title, Author, Quantity, Price) VALUES 
('The Great Gatsby', 'F. Scott Fitzgerald', 10, 10.99),
('1984', 'George Orwell', 15, 8.99),
('To Kill a Mockingbird', 'Harper Lee', 12, 7.99),
('The Catcher in the Rye', 'J.D. Salinger', 8, 9.99),
('Pride and Prejudice', 'Jane Austen', 10, 6.99);

-- Populate Sales Table
INSERT INTO Sales (BookID, QuantitySold) VALUES 
(1, 2), -- Sale of 2 copies of 'The Great Gatsby'
(3, 1); -- Sale of 1 copy of 'To Kill a Mockingbird'
