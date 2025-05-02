-- Question 1: Achieving 1NF (First Normal Form)

CREATE TABLE ProductDetail_1NF AS
SELECT OrderID, CustomerName, SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1) AS Product
FROM ProductDetail
CROSS JOIN (
SELECT 1 AS n UNION ALL SELECT 2 UNION ALL SELECT 3 -- Assuming a maximum of 3 products per order for this example
) AS numbers
WHERE SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n), ',', -1) <> '';


-- Question 2: Achieving 2NF (Second Normal Form)

/* To achieve 2NF, we need to decompose the OrderDetails table into two tables:
 1. Orders: Contains OrderID and CustomerName (CustomerName fully depends on OrderID).
 2. OrderItems: Contains OrderID, Product, and Quantity (Quantity fully depends on the composite key OrderID, Product).*/


-- Create the Orders table:
CREATE TABLE Orders AS
SELECT DISTINCT OrderID, CustomerName
FROM OrderDetails;

-- Create the OrderItems table:
CREATE TABLE OrderItems AS
SELECT OrderID, Product, Quantity
FROM OrderDetails;