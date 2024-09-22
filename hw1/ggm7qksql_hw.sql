-- World Database Questions:
-- Easy:
-- 1. List all countries in South America.
SELECT Name FROM country WHERE Continent = 'South America';
-- 2. Find the population of 'Germany'.
SELECT Population FROM country WHERE Name = 'Germany'; 
-- 3. Retrieve all cities in the country 'Japan'.
SELECT Name FROM city WHERE CountryCode = 'JPN';
-- Medium:
-- 4. Find the 3 most populated countries in the 'Africa' region.
SELECT Name, Population FROM country WHERE Continent = 'Africa' ORDER BY Population DESC LIMIT 3;
-- 5. Retrieve the country and its life expectancy where the population is between 1 and 5
-- million.
SELECT Name, LifeExpectancy FROM country WHERE Population Between 1000000 AND 5000000;
-- 6. List countries with an official language of 'French'
SELECT country.Name FROM country JOIN countrylanguage ON country.Code = countrylanguage.CountryCode WHERE countrylanguage.Language = 'French' AND countrylanguage.IsOfficial = 'T';

-- Chinook Database Questions:
-- Easy:
-- 7. Retrieve all album titles by the artist 'AC/DC'.
SELECT a.Title FROM Album a JOIN Artist ar ON a.ArtistId = ar.ArtistId WHERE ar.Name = 'AC/DC';

-- 8. Find the name and email of customers located in 'Brazil'.
SELECT FirstName, LastName, Email FROM Customer WHERE Country = "Brazil";
-- 9. List all playlists in the database.
SELECT * FROM Playlist;
-- Medium:
-- 10. Find the total number of tracks in the 'Rock' genre.
SELECT COUNT(*) FROM Track t JOIN Genre g ON t.GenreId = g.GenreId WHERE g.Name = 'Rock';
-- 11. List all employees who report to 'Nancy Edwards'.
SELECT FirstName, LastName FROM Employee WHERE ReportsTo = (SELECT EmployeeId FROM Employee WHERE FirstName = 'Nancy' AND LastName = 'Edwards');
-- 12. Calculate the total sales per customer by summing the total amount in invoices.
SELECT Customer.CustomerId, Customer.FirstName, Customer.LastName, SUM(Invoice.Total) AS TotalSales FROM Invoice JOIN Customer ON Invoice.CustomerId = Customer.CustomerId GROUP BY Customer.CustomerId, Customer.FirstName, Customer.LastName ORDER BY TotalSales DESC;

-- Part 2
-- CREATE DATABASE ggm7qk;

-- USE ggm7qk;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10, 2)
);

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    total_price DECIMAL(10, 2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Products (name, category, price) VALUES
('Espresso', 'Beverage', 5.50),
('Latte', 'Beverage', 6.50),
('Cappuccino', 'Beverage', 4.00),
('Muffin', 'Food', 4.00),
('Bagel', 'Food', 3.50);

INSERT INTO Customers (name, email, phone) VALUES
('John Doe', 'john.doe@example.com', '123-456-7890'),
('Jane Smith', 'jane.smith@example.com', '234-567-8901'),
('Alice Johnson', 'alice.johnson@example.com', '345-678-9012'),
('Bob Brown', 'bob.brown@example.com', '456-789-0123'),
('Charlie Davis', 'charlie.davis@example.com', '567-890-1234');

INSERT INTO Orders (customer_id, product_id, order_date, quantity, total_price) VALUES
(1, 1, '2024-09-01', 2, 9.50),
(2, 2, '2024-09-02', 1, 3.50),
(3, 3, '2024-09-03', 3, 12.00),
(4, 4, '2024-09-04', 1, 6.50),
(5, 5, '2024-09-05', 2, 8.00);

-- queries
-- find all products and their category and price
SELECT name, category, price FROM Products;
-- total sale for each product
SELECT Products.name, SUM(Orders.total_price) AS total_sales FROM Orders JOIN Products ON Orders.product_id = Products.product_id GROUP BY Products.name;
-- what john doe ordred
SELECT Orders.order_date, Products.name, Orders.quantity, Orders.total_price FROM Orders JOIN Products ON Orders.product_id = Products.product_id JOIN Customers ON Orders.customer_id = Customers.customer_id WHERE Customers.name = 'John Doe';