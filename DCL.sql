-- Create roles
CREATE ROLE sales_manager;
CREATE ROLE inventory_manager;

-- Grant permissions to roles
GRANT SELECT, INSERT, UPDATE ON Sales TO /*WRITE THE CODE HERE*/;
GRANT SELECT, INSERT, UPDATE ON Books TO /*WRITE THE CODE HERE*/;

-- Create users and assign roles
CREATE USER SalesUser FOR LOGIN SalesUserLogin;
CREATE USER InventoryUser FOR LOGIN InventoryUserLogin;

ALTER ROLE /*WRITE THE CODE HERE*/ ADD MEMBER /*WRITE YOUR CODE HERE*/;
ALTER ROLE /*WRITE THE CODE HERE*/ ADD MEMBER /*WRITE YOUR CODE HERE*/;
