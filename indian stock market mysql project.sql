-- safe mode 
set sql_safe_updates=0 ;

-- CREATE STOCK_MARKET DATABASES
CREATE DATABASE STOCK_MARKET ;

-- USE STOCK MARKET
USE STOCK_MARKET ;

 
-- TABLE 1 --- CREATE TABLE USERS
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    password VARCHAR(50),
    created_at DATE,
    CHECK (LENGTH(password) >= 8)
);
INSERT INTO Users (user_id, name, email, password, created_at)
VALUES 
(100001, 'Amit Sharma', 'amit.sharma@example.com', 'password123', '2023-01-10'),
(100002, 'Priya Singh', 'priya.singh@example.com', 'password234', '2023-02-11'),
(100003, 'Rahul Verma', 'rahul.verma@example.com', 'password345', '2023-03-12'),
(100004, 'Sunita Gupta', 'sunita.gupta@example.com', 'password456', '2023-04-13'),
(100005, 'Kiran Mehta', 'kiran.mehta@example.com', 'password567', '2023-05-14'),
(100006, 'Anil Nair', 'anil.nair@example.com', 'password678', '2023-06-15'),
(100007, 'Meera Das', 'meera.das@example.com', 'password789', '2023-07-16'),
(100008, 'Sanjay Kapoor', 'sanjay.kapoor@example.com', 'password890', '2023-08-17'),
(100009, 'Rohit Bhatia', 'rohit.bhatia@example.com', 'password901', '2023-09-18'),
(100010, 'Neha Jain', 'neha.jain@example.com', 'password012', '2023-10-19');
-- SHOW TABLE
select * from Users;
-- Insert a new user into the table
INSERT INTO Users (user_id, name, email, password, created_at)
VALUES (100011, 'Vikram Patil', 'vikram.patil@example.com', 'password1234', '2023-11-01');

-- Update a user’s email based on user_id
UPDATE Users
SET email = 'updated.email@example.com'
WHERE user_id = 100001;


-- Change the password for a specific user
UPDATE Users
SET password = 'newpassword123'
WHERE name = 'Neha Jain';

-- Delete a user by user_id
DELETE FROM Users
WHERE user_id = 100010;

-- Delete users created before a certain date
DELETE FROM Users
WHERE created_at < '2023-04-01';

-- Example of using a subquery to find users with posts
SELECT * FROM Users 
WHERE user_id IN (SELECT user_id FROM Users);

-- Example of updating a user's name and cascading the change to the Posts table
UPDATE Users 
SET name = 'Amit Sharma Updated' 
WHERE user_id = 100001;

-- Example of deleting a user and cascading delete to the Posts table
DELETE FROM Users 
WHERE user_id = 100002; 

-- TABLE 2 --- CREATE TABLE BROKERS
CREATE TABLE Brokers (
    broker_id INT PRIMARY KEY,
    broker_name VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);
INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number)
VALUES 
(200001, 'Kotak Securities', 'kotak@securities.com', '9876543210'),
(200002, 'ICICI Direct', 'icici@direct.com', '9876543211'),
(200003, 'HDFC Securities', 'hdfc@securities.com', '9876543212'),
(200004, 'Zerodha', 'support@zerodha.com', '9876543213'),
(200005, 'Angel Broking', 'contact@angelbroking.com', '9876543214'),
(200006, 'Upstox', 'info@upstox.com', '9876543215'),
(200007, 'Groww', 'support@groww.com', '9876543216'),
(200008, 'Sharekhan', 'care@sharekhan.com', '9876543217'),
(200009, '5Paisa', 'info@5paisa.com', '9876543218'),
(200010, 'Edelweiss', 'contact@edelweiss.com', '9876543219');
-- SHOW TABLE
select * from Brokers ;

-- Insert a new broker into the Brokers table
INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number)
VALUES (200011, 'Paytm Money', 'contact@paytmmoney.com', '9876543220');

-- Update the contact email for the broker with broker_id 200004
UPDATE Brokers
SET contact_email = 'support@zerodha.in'
WHERE broker_id = 200004;

-- Update the phone number for 'Angel Broking'
UPDATE Brokers
SET phone_number = '9876543230'
WHERE broker_name = 'Angel Broking';

-- Delete the broker with broker_id 200010
DELETE FROM Brokers
WHERE broker_id = 200010;

-- Delete the broker 'Upstox' from the Brokers table
DELETE FROM Brokers
WHERE broker_name = 'Upstox';

-- Remove all records from the Brokers table
TRUNCATE TABLE Brokers;

DELETE FROM Brokers WHERE broker_id = 200001; 

UPDATE Brokers SET broker_id = 200020 WHERE broker_id = 200002;  

-- Create the Brokers table with columns for broker details
CREATE TABLE Brokers (
    broker_id INT PRIMARY KEY,
    broker_name VARCHAR(100),
    contact_email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15)
);

-- Insert records into the Brokers table
INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number)
VALUES 
(200001, 'Kotak Securities', 'kotak@securities.com', '9876543210'),
(200002, 'ICICI Direct', 'icici@direct.com', '9876543211'),
(200003, 'HDFC Securities', 'hdfc@securities.com', '9876543212'),
(200004, 'Zerodha', 'support@zerodha.com', '9876543213'),
(200005, 'Angel Broking', 'contact@angelbroking.com', '9876543214'),
(200006, 'Upstox', 'info@upstox.com', '9876543215'),
(200007, 'Groww', 'support@groww.com', '9876543216'),
(200008, 'Sharekhan', 'care@sharekhan.com', '9876543217'),
(200009, '5Paisa', 'info@5paisa.com', '9876543218'),
(200010, 'Edelweiss', 'contact@edelweiss.com', '9876543219');


-- Example DELETE operation that cascades to the Clients table
DELETE FROM Brokers WHERE broker_id = 200001;  -- Deletes 'Kotak Securities' and its clients

-- Example UPDATE operation that cascades to the Clients table
UPDATE Brokers SET broker_id = 200020 WHERE broker_id = 200002;  -- Updates 'ICICI Direct' ID and cascades to clients

-- TABLE 3 --- CREATE TABLE Accounts
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY,
    user_id INT,
    broker_id INT,
    account_balance DECIMAL(10, 2),
    created_at DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (broker_id) REFERENCES Brokers(broker_id)
);
INSERT INTO Accounts (account_id, user_id, broker_id, account_balance, created_at)
VALUES
(300001, 100001, 200001, 150000.50, '2023-01-10'),
(300002, 100002, 200002, 250000.00, '2023-02-11'),
(300003, 100003, 200003, 350000.75, '2023-03-12'),
(300004, 100004, 200004, 450000.20, '2023-04-13'),
(300005, 100005, 200005, 550000.30, '2023-05-14'),
(300006, 100006, 200006, 120000.60, '2023-06-15'),
(300007, 100007, 200007, 130000.70, '2023-07-16'),
(300008, 100008, 200008, 140000.80, '2023-08-17'),
(300009, 100009, 200009, 160000.90, '2023-09-18'),
(300010, 100010, 200010, 170000.10, '2023-10-19');
-- SHOW TABLE
select * from Accounts;
-- Updating the balance of a specific account (account_id = 300001)
UPDATE Accounts
SET account_balance = 155000.00 
WHERE account_id = 300001;       

-- Selecting the updated account to verify the change
SELECT * FROM Accounts WHERE account_id = 300001;  

-- Deleting an account (account_id = 300010)
DELETE FROM Accounts
WHERE account_id = 300010;  
 
-- Selecting all records to verify the deletion
SELECT * FROM Accounts;

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    user_name VARCHAR(100)
    -- other columns
);

CREATE TABLE Brokerss (
    broker_id INT PRIMARY KEY,
    broker_name VARCHAR(100)
    -- other columns
);

-- Adding foreign key constraints with CASCADE option on the Accounts table
ALTER TABLE Accounts
ADD CONSTRAINT fk_user
FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE;

ALTER TABLE Accounts
ADD CONSTRAINT fk_broker
FOREIGN KEY (broker_id) REFERENCES Brokers(broker_id) ON DELETE CASCADE;

-- Delete a user and automatically remove all related accounts
DELETE FROM Users 
WHERE user_id = 100005;  



-- Update account balances for users whose balance is below a certain threshold
UPDATE Accounts
SET account_balance = account_balance + 5000  
WHERE user_id IN (
    SELECT user_id 
    FROM Accounts 
    WHERE account_balance < 200000.00  
);

-- TABLE 4 ---  CREATE TABLE STOCKS
CREATE TABLE Stocks (
    stock_id INT PRIMARY KEY,
    stock_symbol VARCHAR(10) UNIQUE,
    stock_name VARCHAR(100),
    current_price DECIMAL(10, 2),
    exchange VARCHAR(50)
);
INSERT INTO Stocks (stock_id, stock_symbol, stock_name, current_price, exchange)
VALUES
(400001, 'TCS', 'Tata Consultancy Services', 3550.50, 'NSE'),
(400002, 'RELI', 'Reliance Industries', 2500.10, 'BSE'),
(400003, 'INFY', 'Infosys', 1465.75, 'NSE'),
(400004, 'HDFCB', 'HDFC Bank', 1450.60, 'BSE'),
(400005, 'ICICIB', 'ICICI Bank', 915.30, 'NSE'),
(400006, 'WIPRO', 'Wipro', 395.80, 'BSE'),
(400007, 'SBIN', 'State Bank of India', 565.90, 'NSE'),
(400008, 'LT', 'Larsen & Toubro', 2745.20, 'BSE'),
(400009, 'BAJAJF', 'Bajaj Finance', 7300.65, 'NSE'),
(400010, 'ITC', 'ITC Ltd', 355.40, 'BSE');
-- SHOW TABLE
select * from STOCK ;

-- DML Statement: Update the current price of a specific stock (e.g., TCS)
UPDATE Stocks
SET current_price = 3600.00  
WHERE stock_symbol = 'TCS'; 

-- DML Statement: Delete a specific stock record (e.g., Wipro)
DELETE FROM Stocks
WHERE stock_symbol = 'WIPRO';

-- DQL Statement: Select stocks with current prices greater than a specified amount
SELECT * FROM Stocks
WHERE current_price > 1000.00; 

-- DQL Statement: Count the number of stocks in the Stocks table
SELECT COUNT(*) AS Total_Stocks FROM Stocks; 

ALTER TABLE Stocks
ADD stock_sector VARCHAR(50); 

UPDATE Stocks
SET stock_sector = 'IT' 
WHERE stock_symbol IN ('TCS', 'INFY', 'WIPRO');

UPDATE Stocks
SET stock_sector = 'Finance' 
WHERE stock_symbol IN ('RELI', 'HDFCB', 'ICICIB', 'BAJAJF', 'SBIN'); 

UPDATE Stocks
SET stock_sector = 'Others' 
WHERE stock_symbol IN ('LT', 'ITC'); 

-- Create a StockTransactions table to hold transactions related to stocks
CREATE TABLE StockTransactions (
    transaction_id INT PRIMARY KEY,
    stock_id INT,
    transaction_date DATE,
    quantity INT,
    transaction_type VARCHAR(10),  -- 'buy' or 'sell'
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Insert sample transactions for stocks
INSERT INTO StockTransactions (transaction_id, stock_id, transaction_date, quantity, transaction_type)
VALUES
(1001, 400001, '2024-11-01', 10, 'buy'),
(1002, 400001, '2024-11-02', 5, 'sell'),
(1003, 400002, '2024-11-03', 20, 'buy'),
(1004, 400003, '2024-11-04', 15, 'buy');

-- Delete a stock and all related transactions will be automatically removed due to ON DELETE CASCADE
DELETE FROM Stocks 
WHERE stock_id = 400002;  

-- Update the stock price; this will also cascade to update transactions if needed (e.g., if we have constraints based on price)
UPDATE Stocks 
SET current_price = 3700.00 
WHERE stock_id = (SELECT stock_id FROM Stocks WHERE stock_symbol = 'TCS');  

-- Example of UPDATE with a subquery
-- Here, we increase the current price of stocks that have been sold more than a certain quantity
UPDATE Stocks
SET current_price = current_price * 1.10  
WHERE stock_id IN (
    SELECT stock_id FROM Transactions
    WHERE quantity > 150  
);


-- TABLE 5 --- CREATE TABLE Transactions
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY,
    account_id INT,
    stock_id INT,
    transaction_type VARCHAR(4),  -- 'BUY' or 'SELL'
    quantity INT,
    price_per_stock DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    CHECK (quantity > 0)
);
INSERT INTO Transactions (transaction_id, account_id, stock_id, transaction_type, quantity, price_per_stock, transaction_date)
VALUES
(500001, 300001, 400001, 'BUY', 10, 3550.50, '2023-01-15'),
(500002, 300002, 400002, 'BUY', 20, 2500.10, '2023-02-16'),
(500003, 300003, 400003, 'SELL', 15, 1465.75, '2023-03-17'),
(500004, 300004, 400004, 'BUY', 5, 1450.60, '2023-04-18'),
(500005, 300005, 400005, 'SELL', 12, 915.30, '2023-05-19'),
(500006, 300006, 400006, 'BUY', 8, 395.80, '2023-06-20'),
(500007, 300007, 400007, 'SELL', 10, 565.90, '2023-07-21'),
(500008, 300008, 400008, 'BUY', 7, 2745.20, '2023-08-22'),
(500009, 300009, 400009, 'BUY', 9, 7300.65, '2023-09-23'),
(500010, 300010, 400010, 'SELL', 6, 355.40, '2023-10-24');
-- SHOW TABLE
select * from Transactions ;
-- DQL: Select only BUY transactions
SELECT * FROM Transactions WHERE transaction_type = 'BUY';

-- DQL: Select only SELL transactions
SELECT * FROM Transactions WHERE transaction_type = 'SELL';

-- DQL: Calculate total spent on BUY transactions
SELECT SUM(quantity * price_per_stock) AS total_spent
FROM Transactions
WHERE transaction_type = 'BUY';

-- DQL: Calculate total earned from SELL transactions
SELECT SUM(quantity * price_per_stock) AS total_earned
FROM Transactions
WHERE transaction_type = 'SELL';

-- DQL: Get the count of transactions per account
SELECT account_id, COUNT(*) AS transaction_count
FROM Transactions
GROUP BY account_id;

-- DQL: Get the latest transaction date for each account
SELECT account_id, MAX(transaction_date) AS latest_transaction
FROM Transactions
GROUP BY account_id;

-- Updating the stock price in a hypothetical Transactions table
UPDATE Transactions
SET transaction_type = 'sell'
WHERE stock_id = 400002;  

-- Then we update the corresponding transactions to reflect the new price
UPDATE Transactions
SET price_per_stock = (SELECT price_per_stock FROM Stocks WHERE stock_id = 400002)
WHERE stock_id = 400002;

-- Optionally, verify the updated transactions
SELECT * FROM Transactions
WHERE stock_id = 400002;
-- Update price_per_stock for all transactions of a specific stock using a subquery
UPDATE Transactions
SET price_per_stock = price_per_stock * 1.10  -- Increase price by 10%
WHERE stock_id IN (SELECT stock_id FROM Stocks WHERE stock_name = 'Tech Corp'); 

-- TABLE 6 --- CREATE TABLE Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    account_id INT,
    stock_id INT,
    order_type VARCHAR(4),  -- 'BUY' or 'SELL'
    quantity INT,
    price DECIMAL(10, 2),
    order_date DATE,
    status VARCHAR(10),  -- 'Pending', 'Executed', etc.
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    CHECK (quantity > 0)
);
INSERT INTO Orders (order_id, account_id, stock_id, order_type, quantity, price, order_date, status)
VALUES
(600001, 300001, 400001, 'BUY', 10, 3550.50, '2023-01-12', 'Executed'),
(600002, 300002, 400002, 'BUY', 20, 2500.10, '2023-02-13', 'Executed'),
(600003, 300003, 400003, 'SELL', 15, 1465.75, '2023-03-14', 'Executed'),
(600004, 300004, 400004, 'BUY', 5, 1450.60, '2023-04-15', 'Executed'),
(600005, 300005, 400005, 'SELL', 12, 915.30, '2023-05-16', 'Executed'),
(600006, 300006, 400006, 'BUY', 8, 395.80, '2023-06-17', 'Executed'),
(600007, 300007, 400007, 'SELL', 10, 565.90, '2023-07-18', 'Executed'),
(600008, 300008, 400008, 'BUY', 7, 2745.20, '2023-08-19', 'Executed'),
(600009, 300009, 400009, 'BUY', 9, 7300.65, '2023-09-20', 'Executed'),
(600010, 300010, 400010, 'SELL', 6, 355.40, '2023-10-21', 'Executed');
-- SHOW TABLE
select * from orders ;

-- Retrieve orders with status 'Executed'
SELECT * FROM Orders WHERE status = 'Executed'; 

-- Count the number of orders for each order type
SELECT order_type, COUNT(*) AS total_orders 
FROM Orders 
GROUP BY order_type; 

-- Calculate total amount spent on orders
SELECT SUM(quantity * price) AS total_spent 
FROM Orders 
WHERE order_type = 'BUY'; 

-- Retrieve orders sorted by order date
SELECT * FROM Orders 
ORDER BY order_date DESC; 

DELETE FROM Orders 
WHERE account_id IN (
    SELECT account_id 
    FROM Accounts 
    WHERE status = 'Inactive'  -- Assuming there is a 'status' column in Accounts to check active status
);
-- This DELETE statement removes all orders belonging to accounts that are inactive.
DELETE FROM Orders 
WHERE account_id IN (
    SELECT account_id 
    FROM Accounts 
    WHERE status = 'Inactive'  -- Assuming there is a 'status' column in Accounts to check active status
);

-- TABLE 7 --- CREATE TABLE Dividends
CREATE TABLE Dividends (
    dividend_id INT PRIMARY KEY,
    stock_id INT,
    dividend_amount DECIMAL(10, 2),
    dividend_date DATE,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO Dividends (dividend_id, stock_id, dividend_amount, dividend_date)
VALUES
(700001, 400001, 50.00, '2023-01-30'),
(700002, 400002, 40.00, '2023-02-28'),
(700003, 400003, 30.00, '2023-03-31'),
(700004, 400004, 25.00, '2023-04-30'),
(700005, 400005, 35.00, '2023-05-31'),
(700006, 400006, 20.00, '2023-06-30'),
(700007, 400007, 15.00, '2023-07-31'),
(700008, 400008, 10.00, '2023-08-31'),
(700009, 400009, 5.00, '2023-09-30'),
(700010, 400010, 45.00, '2023-10-31');
-- SHOW TABLE
select * from Dividends ;
-- Query to find total dividends paid
SELECT SUM(dividend_amount) AS total_dividends FROM Dividends;

-- Query to find dividends paid on a specific date
SELECT * FROM Dividends WHERE dividend_date = '2023-03-31';

-- Query to find dividends greater than a specific amount
SELECT * FROM Dividends WHERE dividend_amount > 20.00;

-- Query to update a dividend amount
UPDATE Dividends
SET dividend_amount = 55.00
WHERE dividend_id = 700001; 

-- Query to delete a dividend entry
DELETE FROM Dividends
WHERE dividend_id = 700010; 

-- Query to count the number of dividends issued
SELECT COUNT(*) AS total_dividends_issued FROM Dividends;

-- Query to find the latest dividend issued
SELECT * FROM Dividends
ORDER BY dividend_date DESC
LIMIT 1;
UPDATE Dividends
SET dividend_amount = dividend_amount * 1.10
WHERE stock_id IN (
    SELECT stock_id
    FROM Stocks
    WHERE stock_id > 400005  -- Assuming there's a Stocks table to reference
);
UPDATE Dividends
SET dividend_amount = dividend_amount * 1.10
WHERE stock_id IN (
    SELECT stock_id
    FROM Stocks
    WHERE stock_id > 400005  -- Assuming there's a Stocks table to reference
);

DELETE FROM Dividends
WHERE dividend_id IN (
    SELECT dividend_id
    FROM Dividends
    WHERE dividend_amount < 20.00
);

-- TABLE 8 ---  CREATE TABLE Portfolios
CREATE TABLE Portfolios (
    portfolio_id INT PRIMARY KEY,
    account_id INT,
    stock_id INT,
    quantity INT,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO Portfolios (portfolio_id, account_id, stock_id, quantity)
VALUES
(800001, 300001, 400001, 10),
(800002, 300002, 400002, 20),
(800003, 300003, 400003, 15),
(800004, 300004, 400004, 5),
(800005, 300005, 400005, 12),
(800006, 300006, 400006, 8),
(800007, 300007, 400007, 10),
(800008, 300008, 400008, 7),
(800009, 300009, 400009, 9),
(800010, 300010, 400010, 6);
-- SHOW TABLE
select * from Portfolios;
-- DQL: Retrieve portfolios for a specific account (e.g., account_id = 300005)
SELECT * FROM Portfolios 
WHERE account_id = 300005;  

-- DQL: Count the total number of portfolios
SELECT COUNT(*) AS total_portfolios 
FROM Portfolios; 

-- DQL: Retrieve total quantity of stocks in the portfolio for each stock_id
SELECT stock_id, SUM(quantity) AS total_quantity 
FROM Portfolios 
GROUP BY stock_id;  

-- DML: Update the quantity of a specific stock in a portfolio
UPDATE Portfolios 
SET quantity = 10 
WHERE portfolio_id = 800001; 

-- DML: Delete a portfolio record
DELETE FROM Portfolios 
WHERE portfolio_id = 800010;
-- Delete an account and cascade the delete to Portfolios
DELETE FROM Accounts
WHERE account_id = 300001
AND account_id IN (SELECT DISTINCT account_id FROM Portfolios);

-- Update the stock_id for a specific stock
UPDATE Stocks
SET stock_id = 400011
WHERE stock_id = 400001
AND stock_id IN (SELECT DISTINCT stock_id FROM Portfolios);

-- TABLE 9 --- CREATE TABLE Watchlist
CREATE TABLE Watchlist (
    watchlist_id INT PRIMARY KEY,
    user_id INT,
    stock_id INT,
    added_date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO Watchlist (watchlist_id, user_id, stock_id, added_date)
VALUES
(900001, 100001, 400001, '2023-01-15'),
(900002, 100002, 400002, '2023-02-16'),
(900003, 100003, 400003, '2023-03-17'),
(900004, 100004, 400004, '2023-04-18'),
(900005, 100005, 400005, '2023-05-19'),
(900006, 100006, 400006, '2023-06-20'),
(900007, 100007, 400007, '2023-07-21'),
(900008, 100008, 400008, '2023-08-22'),
(900009, 100009, 400009, '2023-09-23'),
(900010, 100010, 400010, '2023-10-24');
-- SHOW TABLE
select * from Watchlist ;
-- Add a new column to track if the stock is currently active
ALTER TABLE Watchlist
ADD COLUMN is_active BOOLEAN DEFAULT TRUE;  

-- Add a new column to track if the stock is currently active
ALTER TABLE Watchlist
ADD COLUMN is_active BOOLEAN DEFAULT TRUE; 

-- Update the added date for a specific watchlist entry
UPDATE Watchlist
SET added_date = '2023-11-01'  
WHERE watchlist_id = 900001;   

-- Delete a specific watchlist entry
DELETE FROM Watchlist
WHERE watchlist_id = 900010;   
	

-- Select specific columns (e.g., user_id and stock_id) from the Watchlist table
SELECT user_id, stock_id FROM Watchlist;

-- Select records with a specific condition
SELECT * FROM Watchlist
WHERE added_date >= '2023-06-01';  

-- Count the number of entries in the Watchlist
SELECT COUNT(*) AS total_watchlist_entries FROM Watchlist;

-- Find the latest added date in the Watchlist
SELECT MAX(added_date) AS latest_added FROM Watchlist;
-- Delete a user and all their watchlist entries
DELETE FROM Users 
WHERE user_id = 100001; 

-- Update the stock_id for a specific watchlist entry
UPDATE Watchlist 
SET stock_id = (SELECT new_stock_id FROM Stocks WHERE stock_name = 'New Stock Name')  
WHERE watchlist_id = 900009; 

-- Update the stock_id for a specific watchlist entry
UPDATE Watchlist 
SET stock_id = (SELECT stock_id FROM Stocks WHERE stock_name = 'New Stock Name')  
WHERE watchlist_id = 900009; 



-- TABLE 10 --- CREATE TABLE  Exchanges
CREATE TABLE Exchanges (
    exchange_id INT PRIMARY KEY,
    exchange_name VARCHAR(100),
    country VARCHAR(50)
);
INSERT INTO Exchanges (exchange_id, exchange_name, country)
VALUES
(600001, 'National Stock Exchange', 'India'),
(600002, 'Bombay Stock Exchange', 'India'),
(600003, 'Calcutta Stock Exchange', 'India'),
(600004, 'Delhi Stock Exchange', 'India'),
(600005, 'NSE IFSC', 'India'),
(600006, 'BSE SME', 'India'),
(600007, 'MCX', 'India'),
(600008, 'ICEX', 'India'),
(600009, 'DSE', 'India'),
(600010, 'MSE', 'India');
-- SHOW TABLE
select * from Exchanges ;
-- DQL: Select exchanges from a specific country
SELECT exchange_name FROM Exchanges WHERE country = 'India';  

-- DQL: Count the total number of exchanges
SELECT COUNT(*) AS total_exchanges FROM Exchanges; 

-- DML: Update the name of an exchange
UPDATE Exchanges
SET exchange_name = 'BSE (Bombay Stock Exchange)'  
WHERE exchange_id = 600002;                        

-- DML: Delete an exchange from the table
DELETE FROM Exchanges
WHERE exchange_id = 600010;                         
-- DQL: Select exchanges ordered by their name
SELECT * FROM Exchanges
ORDER BY exchange_name;
-- Update the name of an exchange if it has listed stocks
UPDATE Exchanges 
SET exchange_name = 'Updated National Stock Exchange' 
WHERE exchange_id = (SELECT exchange_id FROM Stocks WHERE stock_name = 'TCS');

-- Delete an exchange that has listed stocks
DELETE FROM Exchanges 
WHERE exchange_id = (SELECT exchange_id FROM Stocks WHERE stock_name = 'Reliance');



-- TABLE 11 --- CREATE TABKE StockExchange
CREATE TABLE StockExchange (
    stock_id INT,
    exchange_id INT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    FOREIGN KEY (exchange_id) REFERENCES Exchanges(exchange_id),
    PRIMARY KEY (stock_id, exchange_id)
);
INSERT INTO StockExchange (stock_id, exchange_id)
VALUES
(400001, 600001),
(400002, 600002),
(400003, 600003),
(400004, 600004),
(400005, 600005),
(400006, 600006),
(400007, 600007),
(400008, 600008),
(400009, 600009),
(400010, 600010);
-- SHOW TABLE
select * from StockExchange ;
-- Delete all StockExchange entries for a specific stock_id using a subquery
DELETE FROM StockExchange 
WHERE stock_id IN (SELECT stock_id FROM Stocks WHERE stock_id = 400001); 

-- Update exchange_id for a specific stock_id using a subquery
UPDATE StockExchange
SET exchange_id = (SELECT exchange_id FROM Exchanges WHERE exchange_id = 600001)  
WHERE stock_id IN (SELECT stock_id FROM StockExchange WHERE stock_id = 400001);  

-- TABLE 12 --- CREATE TABLE MarketHistory
CREATE TABLE MarketHistory (
    history_id INT PRIMARY KEY,
    stock_id INT,
    price DECIMAL(10, 2),
    date DATE,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO MarketHistory (history_id, stock_id, price, date)
VALUES
(700001, 400001, 3600.00, '2023-01-15'),
(700002, 400002, 2550.00, '2023-02-16'),
(700003, 400003, 1480.00, '2023-03-17'),
(700004, 400004, 1460.00, '2023-04-18'),
(700005, 400005, 920.00, '2023-05-19'),
(700006, 400006, 400.00, '2023-06-20'),
(700007, 400007, 570.00, '2023-07-21'),
(700008, 400008, 2800.00, '2023-08-22'),
(700009, 400009, 7350.00, '2023-09-23'),
(700010, 400010, 360.00, '2023-10-24');
-- SHOW TABLE
select * from MarketHistory ;

-- Select specific columns (price and date) from the MarketHistory table
SELECT price, date FROM MarketHistory;

-- Select records with a price greater than 1000
SELECT * FROM MarketHistory WHERE price > 1000;

-- Count the total number of entries in the MarketHistory table
SELECT COUNT(*) AS total_records FROM MarketHistory;

-- Get the average price of stocks in the MarketHistory table
SELECT AVG(price) AS average_price FROM MarketHistory;

-- Select records ordered by date in descending order
SELECT * FROM MarketHistory ORDER BY date DESC;

-- Delete a stock and automatically delete related market history records
DELETE FROM Stocks
WHERE stock_id = 400001
  AND stock_id IN (
      SELECT stock_id
      FROM MarketHistory
      WHERE stock_id = 400001
  );
  
  -- Delete a stock and automatically delete related market history records
DELETE FROM Stocks
WHERE stock_id = 400001
  AND stock_id IN (
      SELECT stock_id
      FROM MarketHistory
      WHERE stock_id = 400001
  );



-- TABLE 13 --- CREATE TABLE StockSectors
CREATE TABLE StockSectors (
    sector_id INT PRIMARY KEY,
    sector_name VARCHAR(100)
);
INSERT INTO StockSectors (sector_id, sector_name)
VALUES
(800001, 'Information Technology'),
(800002, 'Finance'),
(800003, 'Healthcare'),
(800004, 'Consumer Goods'),
(800005, 'Energy'),
(800006, 'Automobile'),
(800007, 'Telecommunications'),
(800008, 'Utilities'),
(800009, 'Real Estate'),
(800010, 'Materials');
-- SHOW TABLE
-- Update a record in the StockSectors table
UPDATE StockSectors
SET sector_name = 'Healthcare and Pharmaceuticals'  
WHERE sector_id = 800003;  

-- Delete a record from the StockSectors table
DELETE FROM StockSectors
WHERE sector_id = 800010;

-- Select all records from the StockSectors table
SELECT * FROM StockSectors; 

-- Select specific columns from the StockSectors table
SELECT sector_id, sector_name FROM StockSectors;  

-- Count the number of sectors in the StockSectors table
SELECT COUNT(*) AS TotalSectors FROM StockSectors;

-- Find a specific sector by name
SELECT * FROM StockSectors
WHERE sector_name = 'Finance'; 

select * from StockSectors;

-- Update the name of the sector with sector_id 800003 (Healthcare)
UPDATE StockSectors 
SET sector_name = 'Health Care Services' 
WHERE sector_id = 800003 
  AND sector_id IN (SELECT sector_id FROM Stocks);


-- TABLE 14 --- CREATE TABLE StockSectorMapping
CREATE TABLE StockSectorMapping (
    stock_id INT,
    sector_id INT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id),
    FOREIGN KEY (sector_id) REFERENCES StockSectors(sector_id),
    PRIMARY KEY (stock_id, sector_id)
);
INSERT INTO StockSectorMapping (stock_id, sector_id)
VALUES
(400001, 800001),
(400002, 800002),
(400003, 800001),
(400004, 800002),
(400005, 800002),
(400006, 800001),
(400007, 800003),
(400008, 800004),
(400009, 800005),
(400010, 800006);
-- SHOW TABLE
select * from StockSectorMapping;
-- DQL: Select stocks in a specific sector (e.g., sector_id 800002)
SELECT stock_id FROM StockSectorMapping WHERE sector_id = 800002;  

-- DQL: Count the number of stocks in each sector
SELECT sector_id, COUNT(stock_id) AS stock_count 
FROM StockSectorMapping 
GROUP BY sector_id; 

-- DQL: Retrieve stocks and their corresponding sectors
SELECT s.stock_id, ss.sector_name 
FROM StockSectorMapping s
JOIN StockSectors ss ON s.sector_id = ss.sector_id;  

-- Update the sector_id for a specific stock_id in StockSectorMapping
UPDATE StockSectorMapping
SET sector_id = 800007  
WHERE stock_id = 400002 
AND sector_id IN (
    SELECT sector_id
    FROM StockSectors
    WHERE sector_id = 800002  -- Current sector_id before update
);

-- Delete a stock and its corresponding mappings in StockSectorMapping
DELETE FROM Stocks
WHERE stock_id = 400001  -- The stock_id to delete
AND stock_id IN (
    -- Subquery to ensure the stock_id exists in the Stocks table
    SELECT stock_id
    FROM Stocks
    WHERE stock_id = 400001  -- Check if this stock exists
);

DELETE FROM StockSectors
WHERE sector_id = 800001  -- The sector_id to delete
AND sector_id IN (
    -- Subquery to ensure the sector_id exists in the StockSectors table
    SELECT sector_id
    FROM StockSectors
    WHERE sector_id = 800001  -- Check if this sector exists
);



-- TABLE 15 --- CREATE TABLE Company
CREATE TABLE Company (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    stock_id INT,
    headquarters VARCHAR(100),
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO Company (company_id, company_name, stock_id, headquarters)
VALUES
(900001, 'Tata Consultancy Services', 400001, 'Mumbai, India'),
(900002, 'Reliance Industries', 400002, 'Mumbai, India'),
(900003, 'Infosys', 400003, 'Bangalore, India'),
(900004, 'HDFC Bank', 400004, 'Mumbai, India'),
(900005, 'ICICI Bank', 400005, 'Mumbai, India'),
(900006, 'Wipro', 400006, 'Bangalore, India'),
(900007, 'State Bank of India', 400007, 'Mumbai, India'),
(900008, 'Larsen & Toubro', 400008, 'Mumbai, India'),
(900009, 'Bajaj Finance', 400009, 'Pune, India'),
(900010, 'ITC Ltd', 400010, 'Kolkata, India');
-- SHOW TABLE
select * from company;

-- Example DQL statement to find companies located in Mumbai
SELECT company_name, headquarters FROM Company 
WHERE headquarters LIKE 'Mumbai%'; 

-- Example DQL statement to count the number of companies in the database
SELECT COUNT(*) AS total_companies FROM Company;  

-- Example DQL statement to find a specific company by ID
SELECT * FROM Company 
WHERE company_id = 900003;

-- TABLE 16 --- CREATE TABLE IPO
CREATE TABLE IPO (
    ipo_id INT PRIMARY KEY,
    stock_id INT,
    issue_price DECIMAL(10, 2),
    issue_date DATE,
    shares_issued INT,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO IPO (ipo_id, stock_id, issue_price, issue_date, shares_issued)
VALUES
(1000001, 400001, 1200.00, '2023-01-10', 1000000),
(1000002, 400002, 900.00, '2023-02-11', 2000000),
(1000003, 400003, 500.00, '2023-03-12', 1500000),
(1000004, 400004, 600.00, '2023-04-13', 2500000),
(1000005, 400005, 300.00, '2023-05-14', 3000000),
(1000006, 400006, 400.00, '2023-06-15', 500000),
(1000007, 400007, 200.00, '2023-07-16', 700000),
(1000008, 400008, 800.00, '2023-08-17', 600000),
(1000009, 400009, 1500.00, '2023-09-18', 800000),
(1000010, 400010, 350.00, '2023-10-19', 900000);
-- SHOW TABLE
select * from ipo ;
-- Retrieve specific columns (issue_date, issue_price) from the IPO table
SELECT issue_date, issue_price FROM IPO;

-- Retrieve IPOs where the issue price is greater than 500
SELECT * FROM IPO WHERE issue_price > 500;

-- Count the total number of IPOs
SELECT COUNT(*) AS total_ipos FROM IPO;

-- Retrieve IPOs for a specific stock_id (e.g., 400002)
SELECT * FROM IPO WHERE stock_id = 400002;

-- Retrieve all IPOs sorted by issue date in ascending order
SELECT * FROM IPO ORDER BY issue_date ASC;

-- Calculate total funds raised through all IPOs (issue_price * shares_issued)
SELECT SUM(issue_price * shares_issued) AS total_funds_raised FROM IPO;

-- Delete companies located in Mumbai and cascade to related Stocks if applicable
DELETE FROM Company 
WHERE company_id IN (SELECT company_id FROM Company WHERE headquarters = 'Mumbai, India');

-- Update the headquarters of Infosys based on its company_id
UPDATE Company 
SET headquarters = 'Bengaluru, India'
WHERE company_id = (SELECT company_id FROM Company WHERE company_name = 'Infosys');

-- TABLE 17 --- CREATE TABLE AnalystRatings
select * from AnalystRatings ;
CREATE TABLE AnalystRatings (
    rating_id INT PRIMARY KEY,
    stock_id INT,
    analyst_name VARCHAR(100),
    rating VARCHAR(10),  -- e.g., 'Buy', 'Sell', 'Hold'
    rating_date DATE,
    FOREIGN KEY (stock_id) REFERENCES Stocks(stock_id)
);
INSERT INTO AnalystRatings (rating_id, stock_id, analyst_name, rating, rating_date)
VALUES
(1100001, 400001, 'Ravi Kumar', 'Buy', '2023-01-15'),
(1100002, 400002, 'Neha Singh', 'Hold', '2023-02-16'),
(1100003, 400003, 'Amit Verma', 'Sell', '2023-03-17'),
(1100004, 400004, 'Priya Mehta', 'Buy', '2023-04-18'),
(1100005, 400005, 'Suresh Gupta', 'Hold', '2023-05-19'),
(1100006, 400006, 'Kiran Reddy', 'Buy', '2023-06-20'),
(1100007, 400007, 'Rajesh Nair', 'Sell', '2023-07-21'),
(1100008, 400008, 'Anita Das', 'Hold', '2023-08-22'),
(1100009, 400009, 'Vikram Bhatia', 'Buy', '2023-09-23'),
(1100010, 400010, 'Sneha Patil', 'Sell', '2023-10-24');
-- SHOW TABLE
select * from AnalystRatings ;
-- Update an existing rating (for example, changing 'Hold' to 'Sell' for stock_id 400002)
UPDATE AnalystRatings
SET rating = 'Sell'
WHERE stock_id = 400002 AND analyst_name = 'Neha Singh';

-- Delete a rating for a specific stock (for example, deleting rating_id 1100003)
DELETE FROM AnalystRatings
WHERE rating_id = 1100003;

-- Select specific columns from the AnalystRatings table, showing ratings and analyst names
SELECT analyst_name, rating, rating_date
FROM AnalystRatings;

-- Select ratings for stocks with a specific rating (e.g., 'Buy')
SELECT * FROM AnalystRatings
WHERE rating = 'Buy';

-- Select the count of ratings by each rating type
SELECT rating, COUNT(*) AS count
FROM AnalystRatings
GROUP BY rating;

-- Delete a stock and cascade the deletion to the AnalystRatings table
DELETE FROM Stocks 
WHERE stock_id = 400005;  

-- Updating the stock_id for a stock and ensuring all related ratings are updated
UPDATE Stocks 
SET stock_id = 400100  
WHERE stock_id = 400001;  

-- Updating the AnalystRatings to reflect the new stock_id based on a subquery
UPDATE AnalystRatings 
SET stock_id = (SELECT 400100 FROM Stocks WHERE stock_id = 400001) 
WHERE stock_id = 400001;  



-- TABLE 18 --- CREATE TABLE  UserMessages
CREATE TABLE UserMessages (
    message_id INT PRIMARY KEY,
    sender_id INT,
    receiver_id INT,
    message_text TEXT,
    sent_date DATE,
    FOREIGN KEY (sender_id) REFERENCES Users(user_id),
    FOREIGN KEY (receiver_id) REFERENCES Users(user_id)
);
INSERT INTO UserMessages (message_id, sender_id, receiver_id, message_text, sent_date)
VALUES
(1200001, 100001, 100002, 'Hello Priya, how are you?', '2023-01-20'),
(1200002, 100002, 100003, 'Rahul, did you see the stock market today?', '2023-02-21'),
(1200003, 100003, 100004, 'Sunita, let’s discuss our investment strategy.', '2023-03-22'),
(1200004, 100004, 100005, 'Kiran, have you checked the latest stock prices?', '2023-04-23'),
(1200005, 100005, 100006, 'Anil, I need your advice on buying stocks.', '2023-05-24'),
(1200006, 100006, 100007, 'Meera, let’s catch up this weekend.', '2023-06-25'),
(1200007, 100007, 100008, 'Sanjay, the market is looking good!', '2023-07-26'),
(1200008, 100008, 100009, 'Rohit, what’s your take on TCS?', '2023-08-27'),
(1200009, 100009, 100010, 'Neha, I found a great stock tip!', '2023-09-28'),
(1200010, 100010, 100001, 'Amit, thanks for your insights!', '2023-10-29');
-- SHOW TABLE
select * from UserMessages ;

-- Select messages sent by a specific user (e.g., user with ID 100002)
SELECT * FROM UserMessages WHERE sender_id = 100002;

-- Select messages received by a specific user (e.g., user with ID 100005)
SELECT * FROM UserMessages WHERE receiver_id = 100005;

-- Select messages sent on a specific date
SELECT * FROM UserMessages WHERE sent_date = '2023-05-24';

-- Count the number of messages sent by each user
SELECT sender_id, COUNT(*) AS message_count FROM UserMessages GROUP BY sender_id;

-- Retrieve messages in a specific date range
SELECT * FROM UserMessages WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31';

-- Select the latest message sent by a specific user
SELECT * FROM UserMessages WHERE sender_id = 100001 ORDER BY sent_date DESC LIMIT 1;

-- Delete a user and all their messages using a subquery
DELETE FROM Users
WHERE user_id = (
    SELECT user_id FROM Users WHERE receiver_id = 100004
);

-- Comment: This query deletes the user 'Kiran' and any messages they have sent or received
-- because of the foreign key constraints defined in the UserMessages table.


-- TABLE 19 --- CREATE TABLE Fees
CREATE TABLE Fees (
    fee_id INT PRIMARY KEY,
    broker_id INT,
    trade_fee DECIMAL(10, 2),
    created_at DATE,
    FOREIGN KEY (broker_id) REFERENCES Brokers(broker_id)
);
INSERT INTO Fees (fee_id, broker_id, trade_fee, created_at)
VALUES
(1300001, 200001, 15.00, '2023-01-10'),
(1300002, 200002, 12.00, '2023-02-11'),
(1300003, 200003, 10.00, '2023-03-12'),
(1300004, 200004, 20.00, '2023-04-13'),
(1300005, 200005, 18.00, '2023-05-14'),
(1300006, 200006, 14.00, '2023-06-15'),
(1300007, 200007, 16.00, '2023-07-16'),
(1300008, 200008, 19.00, '2023-08-17'),
(1300009, 200009, 22.00, '2023-09-18'),
(1300010, 200010, 11.00, '2023-10-19');
-- SHOW TABLE
select * from fees ;

-- Retrieve only the trade fees along with the corresponding broker IDs
SELECT broker_id, trade_fee FROM Fees;

-- Retrieve the average trade fee
SELECT AVG(trade_fee) AS average_trade_fee FROM Fees;

-- Retrieve all fees created after a certain date (e.g., '2023-05-01')
SELECT * FROM Fees WHERE created_at > '2023-05-01';	

-- Retrieve fees sorted by trade_fee in descending order
SELECT * FROM Fees ORDER BY trade_fee DESC;

-- TABLE 20 --- CREATE TABLE MarketNews
CREATE TABLE MarketNews (
    news_id INT PRIMARY KEY,
    headline VARCHAR(255),
    body TEXT,
    published_date DATE
);
INSERT INTO MarketNews (news_id, headline, body, published_date) VALUES
(123456, 'Ravi Sharma Sees Growth in Market', 'Ravi Sharma, the renowned market analyst, believes that the upcoming fiscal year will see a significant growth in the stock market.', '2024-10-01'),
(234567, 'Anjali Gupta Predicts Economic Stability', 'Anjali Gupta has released her latest report predicting that economic stability is on the horizon for India.', '2024-10-02'),
(345678, 'Amit Verma Launches New Investment Strategy', 'Amit Verma has unveiled a new investment strategy aimed at younger investors looking to enter the stock market.', '2024-10-03'),
(456789, 'Priya Mehta Discusses Inflation Trends', 'Priya Mehta provides insights into the current inflation trends and their impact on the market.', '2024-10-04'),
(567890, 'Vikram Joshi Offers Tips for Savvy Investors', 'Vikram Joshi shares his top tips for investors looking to maximize their returns in a fluctuating market.', '2024-10-05'),
(678901, 'Sita Patel Analyzes Global Market Influences', 'Sita Patel analyzes how global market trends are influencing the Indian economy.', '2024-10-06'),
(789012, 'Rahul Desai Reviews Stock Performance', 'Rahul Desai reviews the stock performance of major companies in India for Q3 2024.', '2024-10-07'),
(890123, 'Geeta Rani Reports on Real Estate Trends', 'Geeta Rani reports on the latest trends in the real estate market and forecasts future growth.', '2024-10-08'),
(901234, 'Deepak Singh Examines Tech Investments', 'Deepak Singh examines the current landscape of tech investments and potential growth areas.', '2024-10-09'),
(1234567, 'Neha Bhatia Talks About Sustainable Investments', 'Neha Bhatia discusses the rise of sustainable investments in India and their future potential.', '2024-10-10');
-- SHOW TABLE
select * from MarketNews;

-- Select headlines and published dates from the MarketNews table
SELECT headline, published_date FROM MarketNews;

-- Select news articles published after October 5, 2024
SELECT * FROM MarketNews WHERE published_date > '2024-10-05';

-- Count the number of articles in the MarketNews table
SELECT COUNT(*) AS total_articles FROM MarketNews;

-- Retrieve articles with 'Investment' in the headline
SELECT * FROM MarketNews WHERE headline LIKE '%Investment%';




-- all tables join 

-- Inner Join: Retrieve users with their accounts
SELECT 
    U.user_id, U.name, A.account_id, A.account_balance
FROM 
    Users U
INNER JOIN 
    Accounts A ON U.user_id = A.user_id;

-- Left Join: Retrieve all users and their accounts (if any)
SELECT 
    U.user_id, U.name, A.account_id, A.account_balance
FROM 
    Users U
LEFT JOIN 
    Accounts A ON U.user_id = A.user_id;

-- Right Join: Retrieve all accounts and their users (if any)
SELECT 
    U.user_id, U.name, A.account_id, A.account_balance
FROM 
    Users U
RIGHT JOIN 
    Accounts A ON U.user_id = A.user_id;



-- Join: Retrieve accounts along with broker details
SELECT 
    A.account_id, A.account_balance, B.broker_name, B.contact_email
FROM 
    Accounts A
JOIN 
    Brokers B ON A.broker_id = B.broker_id;

-- Join: Retrieve transaction details with account and stock information
SELECT 
    T.transaction_id, T.transaction_type, T.quantity, T.price_per_stock, 
    A.account_id, S.stock_name
FROM 
    Transactions T
left JOIN 
    Accounts A ON T.account_id = A.account_id
JOIN 
    Stocks S ON T.stock_id = S.stock_id;
	
    
-- Join: Retrieve orders with stock details
SELECT 
    O.order_id, O.order_type, O.quantity, O.price, S.stock_name
FROM 
    Orders O
right JOIN 
    Stocks S ON O.stock_id = S.stock_id;

-- Join: Retrieve dividends with stock details
SELECT 
    D.dividend_id, D.dividend_amount, D.dividend_date, S.stock_name
FROM 
    Dividends D
JOIN 
    Stocks S ON D.stock_id = S.stock_id;

-- INNER JOIN example between Portfolios and Stocks (assuming Stocks table exists)
SELECT P.portfolio_id, P.account_id, P.stock_id, P.quantity, S.stock_name
FROM Portfolios P
INNER JOIN Stocks S ON P.stock_id = S.stock_id;

-- LEFT OUTER JOIN example between Portfolios and Stocks
SELECT P.portfolio_id, P.account_id, P.stock_id, P.quantity, S.stock_name
FROM Portfolios P
LEFT OUTER JOIN Stocks S ON P.stock_id = S.stock_id;

-- RIGHT OUTER JOIN example between Portfolios and Stocks
SELECT P.portfolio_id, P.account_id, P.stock_id, P.quantity, S.stock_name
FROM Portfolios P
RIGHT OUTER JOIN Stocks S ON P.stock_id = S.stock_id;


SELECT W.watchlist_id, W.user_id, W.stock_id, W.added_date, S.stock_name
FROM Watchlist W
INNER JOIN Stocks S ON W.stock_id = S.stock_id;

SELECT MH.history_id, MH.stock_id, MH.price, MH.date, S.stock_name
FROM MarketHistory MH
LEFT OUTER JOIN Stocks S ON MH.stock_id = S.stock_id;

SELECT SE.stock_id, SE.exchange_id, E.exchange_name
FROM StockExchange SE
RIGHT OUTER JOIN Exchanges E ON SE.exchange_id = E.exchange_id;

SELECT P.portfolio_id, P.account_id, P.stock_id, P.quantity, MH.price, MH.date, S.stock_name
FROM Portfolios P
INNER JOIN MarketHistory MH ON P.stock_id = MH.stock_id
INNER JOIN Stocks S ON P.stock_id = S.stock_id;

SELECT 
    c.company_name,
    s.sector_id,
    i.issue_price,
    a.rating
FROM 
    Company c
INNER JOIN 
    StockSectorMapping s ON c.stock_id = s.stock_id
INNER JOIN 
    IPO i ON c.stock_id = i.stock_id
INNER JOIN 
    AnalystRatings a ON c.stock_id = a.stock_id;

SELECT 
    c.company_name,
    s.sector_id,
    i.issue_price,
    a.rating
FROM 
    Company c
LEFT JOIN 
    StockSectorMapping s ON c.stock_id = s.stock_id
LEFT JOIN 
    IPO i ON c.stock_id = i.stock_id
LEFT JOIN 
    AnalystRatings a ON c.stock_id = a.stock_id;

SELECT 
    c.company_name,
    s.sector_id,
    i.issue_price,
    a.rating
FROM 
    StockSectorMapping s
RIGHT JOIN 
    Company c ON c.stock_id = s.stock_id
RIGHT JOIN 
    IPO i ON c.stock_id = i.stock_id
RIGHT JOIN 
    AnalystRatings a ON c.stock_id = a.stock_id;



SELECT 
    UM.message_id, 
    UM.message_text, 
    F.trade_fee, 
    MN.headline
FROM 
    UserMessages UM
LEFT OUTER JOIN 
    Fees F ON UM.sender_id = F.broker_id
LEFT OUTER JOIN 
    MarketNews MN ON UM.receiver_id = MN.news_id;

SELECT 
    UM.message_id, 
    UM.message_text, 
    F.trade_fee, 
    MN.headline
FROM 
    UserMessages UM
RIGHT OUTER JOIN 
    Fees F ON UM.sender_id = F.broker_id
RIGHT OUTER JOIN 
    MarketNews MN ON UM.receiver_id = MN.news_id;

-- USING CASE STUDY ON USER TABLE 
-- CASE 
ALTER TABLE Users
ADD COLUMN status VARCHAR(10);

-- ADD VALUES IN STATUS TABLE  
UPDATE Users
SET status = CASE
    WHEN created_at < '2023-06-01' THEN 'Inactive'
    ELSE 'Active'
END;
-- show table after using case 
SELECT * FROM USERS ;

-- USING CASE STUDY ON  brokers TABLE 
-- step 1 add columm
ALTER TABLE Brokers 
ADD COLUMN commission_rate DECIMAL(5, 2);
-- setp 2 using case 
UPDATE Brokers
SET commission_rate = 
    CASE
        WHEN broker_name IN ('Zerodha', 'Upstox', 'Groww') THEN 0.10
        WHEN broker_name IN ('ICICI Direct', 'HDFC Securities', 'Angel Broking', 'Sharekhan', 'Edelweiss') THEN 0.30
        WHEN broker_name IN ('Kotak Securities', '5Paisa') THEN 0.20
        ELSE 0.25  -- Default rate if any new brokers are added without a category
    END;
    
-- table 3 
-- step 1
-- add column
ALTER TABLE Accounts
ADD COLUMN account_type VARCHAR(20);
-- step 2
UPDATE Accounts
SET account_type = CASE
    WHEN account_balance >= 300000 THEN 'Premium'
    ELSE 'Standard'
END;
-- step 3
select * from Accounts ;
   
   -- table 4 
   UPDATE Stocks
SET current_price = 
    CASE 
        WHEN exchange = 'NSE' THEN current_price * 1.05
        WHEN exchange = 'BSE' THEN current_price * 0.97
        ELSE current_price
    END;
    
-- Step 1: Add the new column 'sector' to the Stocks table
ALTER TABLE Stocks
ADD sector VARCHAR(50);

-- Step 2: Update the sector column using a CASE statement
UPDATE Stocks
SET sector = CASE
    WHEN stock_symbol IN ('TCS', 'INFY', 'WIPRO') THEN 'IT Services'
    WHEN stock_symbol IN ('RELI', 'BAJAJF') THEN 'Conglomerate'
    WHEN stock_symbol IN ('HDFCB', 'ICICIB', 'SBIN') THEN 'Banking'
    WHEN stock_symbol = 'LT' THEN 'Construction'
    WHEN stock_symbol = 'ITC' THEN 'Consumer Goods'
    ELSE 'Other'
END;

-- step 3 
select * from Stocks ;

-- table 5 

-- Step 1: Add a new column `transaction_fee` to store the transaction fee
ALTER TABLE Transactions
ADD COLUMN transaction_fee DECIMAL(10, 2);

-- Step 2: Update existing records to calculate `transaction_fee` based on `transaction_type`
UPDATE Transactions
SET transaction_fee = 
    CASE
        WHEN transaction_type = 'BUY' THEN quantity * price_per_stock * 0.01
        WHEN transaction_type = 'SELL' THEN quantity * price_per_stock * 0.005
        ELSE 0
    END;
    
-- table 6 
-- Step 1: Add the commission column
ALTER TABLE Orders
ADD commission DECIMAL(10, 2);

-- Step 2: Insert commission values based on order type
UPDATE Orders
SET commission = CASE
    WHEN order_type = 'BUY' THEN price * 0.01  -- Example: 1% commission on BUY orders
    WHEN order_type = 'SELL' THEN price * 0.015 -- Example: 1.5% commission on SELL orders
    ELSE 0
END;

-- STEP 3
SELECT * FROM ORDERS ;

-- TABLE 7 
-- Step 1: Add the new column
ALTER TABLE Dividends
ADD COLUMN dividend_type VARCHAR(10);

-- Step 2: Update values in the new column using a CASE statement
UPDATE Dividends
SET dividend_type = CASE
    WHEN dividend_amount >= 40 THEN 'High'
    WHEN dividend_amount BETWEEN 20 AND 39.99 THEN 'Medium'
    ELSE 'Low'
END;

-- STEP 3
SELECT * FROM Dividends ;

-- TABLE 8 
-- Step 1: Add the new column for investment value
ALTER TABLE Portfolios 
ADD COLUMN investment_value DECIMAL(10, 2);

-- Step 2: Update values for the new column using CASE statement
UPDATE Portfolios
SET investment_value = 
    CASE 
        WHEN quantity > 10 THEN quantity = 100  -- If quantity > 10, investment is quantity * 100
        WHEN quantity BETWEEN 5 AND 10 THEN quantity = 80  -- If quantity is between 5 and 10, investment is quantity * 80
        ELSE quantity = 60  -- If quantity is less than 5, investment is quantity * 60
    END;
    -- STEP 3
    
SELECT * FROM Portfolios ;

-- TABLE 9 
-- Step 1: Add the new column to the Watchlist table
ALTER TABLE Watchlist
ADD COLUMN alert_level VARCHAR(10);

-- Step 2: Update the alert_level based on added_date using CASE
UPDATE Watchlist
SET alert_level = 
    CASE 
        WHEN added_date < '2023-06-01' THEN 'High'
        WHEN added_date BETWEEN '2023-06-01' AND '2023-08-31' THEN 'Medium'
        ELSE 'Low'
    END;
-- STEP 3
SELECT * FROM Watchlist;

-- TABLE 10

-- Step 1: Add a new column for 'established_year'
ALTER TABLE Exchanges
ADD COLUMN established_year INT;

-- Step 2: Update the 'established_year' values based on a case study (for example)
UPDATE Exchanges
SET established_year = CASE
    WHEN exchange_id = 600001 THEN 1992  -- National Stock Exchange, established in 1992
    WHEN exchange_id = 600002 THEN 1875  -- Bombay Stock Exchange, established in 1875
    WHEN exchange_id = 600003 THEN 1908  -- Calcutta Stock Exchange, established in 1908
    WHEN exchange_id = 600004 THEN 1947  -- Delhi Stock Exchange, established in 1947
    WHEN exchange_id = 600005 THEN 2015  -- NSE IFSC, established in 2015
    WHEN exchange_id = 600006 THEN 2012  -- BSE SME, established in 2012
    WHEN exchange_id = 600007 THEN 2003  -- MCX, established in 2003
    WHEN exchange_id = 600008 THEN 2009  -- ICEX, established in 2009
    WHEN exchange_id = 600009 THEN 1947  -- DSE, established in 1947
    WHEN exchange_id = 600010 THEN 1935  -- MSE, established in 1935
    ELSE NULL  -- In case of missing data, set it to NULL
END;

-- STEP 3 
SELECT * FROM Exchanges ;

-- TABLE 11

ALTER TABLE StockExchange
ADD column listing_date INT NOT NULL ;


UPDATE StockExchange 
SET listing_date = CASE
    WHEN stock_id = 400001 AND exchange_id = 600001 THEN '2023-01-01'
    WHEN stock_id = 400002 AND exchange_id = 600002 THEN '2023-02-01'
    WHEN stock_id = 400003 AND exchange_id = 600003 THEN '2023-03-01'
    WHEN stock_id = 400004 AND exchange_id = 600004 THEN '2023-04-01'
    WHEN stock_id = 400005 AND exchange_id = 600005 THEN '2023-05-01'
    WHEN stock_id = 400006 AND exchange_id = 600006 THEN '2023-06-01'
    WHEN stock_id = 400007 AND exchange_id = 600007 THEN '2023-07-01'
    WHEN stock_id = 400008 AND exchange_id = 600008 THEN '2023-08-01'
    WHEN stock_id = 400009 AND exchange_id = 600009 THEN '2023-09-01'
    WHEN stock_id = 400010 AND exchange_id = 600010 THEN '2023-10-01'
    ELSE NULL
END;

-- STEP 3 
SELECT * FROM StockExchange;

-- TABLE 12
ALTER TABLE MarketHistory
ADD COLUMN price_category VARCHAR(20);

UPDATE MarketHistory
SET price_category = CASE
    WHEN price < 1000 THEN 'Low'
    WHEN price >= 1000 AND price < 3000 THEN 'Medium'
    WHEN price >= 3000 THEN 'High'
    END;

-- table 13
ALTER TABLE StockSectors
ADD COLUMN sector_description VARCHAR(255);

UPDATE StockSectors
SET sector_description = CASE 
    WHEN sector_name = 'Information Technology' THEN 'Sector dealing with computer technology, software, and hardware.'
    WHEN sector_name = 'Finance' THEN 'Sector involving financial services including banking, insurance, and investment.'
    WHEN sector_name = 'Healthcare' THEN 'Sector focused on providing medical services, pharmaceutical, and biotechnology.'
    WHEN sector_name = 'Consumer Goods' THEN 'Sector that includes products bought by individuals for personal use.'
    WHEN sector_name = 'Energy' THEN 'Sector concerned with the production and distribution of energy, including oil, gas, and renewables.'
    WHEN sector_name = 'Automobile' THEN 'Sector related to the production, sale, and maintenance of motor vehicles.'
    WHEN sector_name = 'Telecommunications' THEN 'Sector providing services related to telecommunication including internet, wireless, and cable.'
    WHEN sector_name = 'Utilities' THEN 'Sector involving public services like electricity, water, and natural gas.'
    WHEN sector_name = 'Real Estate' THEN 'Sector focused on buying, selling, and renting properties.'
    WHEN sector_name = 'Materials' THEN 'Sector that includes industries like chemicals, metals, and mining.'
    ELSE 'Description not available'
END;

-- STEP 3 
SELECT * FROM StockSectors ;

-- TABLE 14 
-- TABLE 15 
-- Adding a new column 'sector' to the Company table to represent the industry sector.
ALTER TABLE Company 
ADD COLUMN sector VARCHAR(50);

-- Inserting new values with the sector based on company names.
UPDATE Company
SET sector = CASE
    WHEN company_name = 'Tata Consultancy Services' THEN 'Information Technology'
    WHEN company_name = 'Reliance Industries' THEN 'Conglomerate'
    WHEN company_name = 'Infosys' THEN 'Information Technology'
    WHEN company_name = 'HDFC Bank' THEN 'Banking'
    WHEN company_name = 'ICICI Bank' THEN 'Banking'
    WHEN company_name = 'Wipro' THEN 'Information Technology'
    WHEN company_name = 'State Bank of India' THEN 'Banking'
    WHEN company_name = 'Larsen & Toubro' THEN 'Engineering & Construction'
    WHEN company_name = 'Bajaj Finance' THEN 'Financial Services'
    WHEN company_name = 'ITC Ltd' THEN 'Conglomerate'
    ELSE 'Unknown'
END;

-- STEP 3 
SELECT * FROM Company ;

-- TABLE 16 
ALTER TABLE IPO
ADD COLUMN market_type VARCHAR(20);

UPDATE IPO
SET market_type = CASE
    WHEN issue_price > 1000 THEN 'Large Cap'
    WHEN issue_price BETWEEN 500 AND 1000 THEN 'Mid Cap'
    ELSE 'Small Cap'
END;

-- STEP 3 
SELECT * FROM IPO ;

-- TABLE 17
ALTER TABLE AnalystRatings
ADD COLUMN comment VARCHAR(255);

UPDATE AnalystRatings
SET comment = CASE 
    WHEN rating = 'Buy' THEN 'Positive outlook'
    WHEN rating = 'Hold' THEN 'Neutral outlook'
    WHEN rating = 'Sell' THEN 'Negative outlook'
    ELSE 'No comment'
END;
-- STEP 3 
SELECT * FROM AnalystRatings ;
-- TABLE 18
ALTER TABLE UserMessages
ADD COLUMN message_status VARCHAR(10) DEFAULT 'unread';

UPDATE UserMessages
SET message_status = CASE 
    WHEN message_id <= 1200005 THEN 'unread'
    ELSE 'read'
END;

-- STEP 3 
SELECT * FROM UserMessages ;

-- TABLE 19
-- Step 1: Add new column
ALTER TABLE Fees
ADD COLUMN fee_type VARCHAR(10);

-- Step 2: Update fee_type based on trade_fee
UPDATE Fees
SET fee_type = CASE
    WHEN trade_fee > 18 THEN 'Premium'
    ELSE 'Standard'
END;

-- STEP 3 
SELECT * from fees ;

-- table 20 
ALTER TABLE MarketNews
ADD COLUMN comment TEXT;

UPDATE MarketNews
SET comment = CASE
    WHEN news_id = 123456 THEN 'Ravi Sharma’s predictions are promising, especially for long-term investors.'
    WHEN news_id = 234567 THEN 'Anjali Gupta’s report shows optimism, but may not account for potential geopolitical risks.'
    WHEN news_id = 345678 THEN 'Amit Verma’s strategy could appeal to younger investors who are risk-averse.'
    WHEN news_id = 456789 THEN 'Priya Mehta’s analysis is vital in understanding how inflation affects market stability.'
    WHEN news_id = 567890 THEN 'Vikram Joshi’s tips are practical for those seeking immediate returns in volatile markets.'
    WHEN news_id = 678901 THEN 'Sita Patel’s insights highlight the importance of global market trends on local markets.'
    WHEN news_id = 789012 THEN 'Rahul Desai’s review offers a detailed perspective on the stock market’s health.'
    WHEN news_id = 890123 THEN 'Geeta Rani’s coverage is useful for those eyeing the real estate sector.'
    WHEN news_id = 901234 THEN 'Deepak Singh’s analysis will resonate with tech investors seeking emerging opportunities.'
    WHEN news_id = 1234567 THEN 'Neha Bhatia’s focus on sustainable investments shows a promising shift in market trends.'
    ELSE 'No comment available.'
END;

select * from MarketNews ;

-- USE FUNCATION

-- Create a function that calculates the number of days since a given date
DELIMITER //

CREATE FUNCTION days_since_creation(creation_date DATE)
RETURNS INT
DETERMINISTIC
-- This function returns the number of days from the given date to the current date.
BEGIN
    DECLARE days_difference INT;
    
    -- Calculate the difference in days between the given creation_date and today's date
    SET days_difference = DATEDIFF(CURDATE(), creation_date);
    
    -- Return the calculated number of days
    RETURN days_difference;
END //

DELIMITER ;

SELECT user_id, name, created_at, days_since_creation(created_at) AS days_since_creation
FROM Users;

-- TABLE 2 
-- Add a 'created_date' column to store the date each record is created
ALTER TABLE Brokers 
ADD COLUMN created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP;

-- Drop the procedure if it already exists
DROP PROCEDURE IF EXISTS InsertBroker;

-- Create a procedure to insert brokers with a created date
DELIMITER //
CREATE PROCEDURE InsertBroker (
    IN broker_id INT,
    IN broker_name VARCHAR(100),
    IN contact_email VARCHAR(100),
    IN phone_number VARCHAR(15)
)
BEGIN
    -- Insert broker data along with the current timestamp for created_date
    INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number, created_date)
    VALUES (broker_id, broker_name, contact_email, phone_number, CURRENT_TIMESTAMP);
END //
DELIMITER ;

-- Usage example:
CALL InsertBroker(200013, 'New Broker', 'newbroker@example.com', '9876543220');

-- TABLE 3 

DELIMITER //

CREATE FUNCTION get_account_balance(acct_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- Declare a variable to store the account balance
    DECLARE acct_balance DECIMAL(10, 2);

    -- Select the account balance into the variable
    SELECT account_balance INTO acct_balance
    FROM Accounts
    WHERE account_id = acct_id;

    -- Return the account balance
    RETURN acct_balance;
END //

DELIMITER ;

-- STEP 3 
SELECT get_account_balance(300001);

-/* - TABLE 4 
-- Drop the function if it already exists to avoid conflicts
DROP FUNCTION IF EXISTS GetStocksByExchange;

-- Create the function GetStocksByExchange
DELIMITER //
CREATE FUNCTION GetStocksByExchange(exchange_name VARCHAR(50))
RETURNS TABLE
BEGIN
    -- This function returns a result set of stocks listed on the specified exchange
    RETURN (
        SELECT stock_id, stock_symbol, stock_name, current_price, exchange
        FROM Stocks
        WHERE exchange = exchange_name
    );
END //
DELIMITER ;

SELECT * FROM GetStocksByExchange('NSE'); */

-- TABLE 5 
DELIMITER //

CREATE FUNCTION price_per_stock(stock_symbol VARCHAR(10), exchange VARCHAR(10)) 
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    -- Declare a variable to store the stock price
    DECLARE stock_price DECIMAL(10,2);

    -- Get the stock price from the database for the given stock_symbol and exchange
    SELECT price
    INTO stock_price
    FROM stocks
    WHERE stock_symbol = stock_symbol
    AND exchange = exchange
    LIMIT 1;

    -- If no record is found, set stock_price to NULL
    IF stock_price IS NULL THEN
        RETURN NULL;
    END IF;

    -- Return the stock price
    RETURN stock_price;
END //

DELIMITER ;

SELECT price_per_stock('AAPL', 'NASDAQ');


-- TABLE 6 
DELIMITER //

-- Create a function to extract the year from the order_date
CREATE FUNCTION GetOrderYear(order_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    -- Declare a variable to hold the year
    DECLARE orderYear INT;

    -- Get the year from the order_date of the given order_id
    SELECT YEAR(order_date)
    INTO orderYear
    FROM Orders
    WHERE order_id = order_id;

    -- Return the extracted year
    RETURN orderYear;
END //

DELIMITER ;

SELECT GetOrderYear(600001); 

-- TABLE 7 
DELIMITER //

-- Create a function to calculate dividend after tax (for example, 10% tax deduction)
CREATE FUNCTION CalculateDividendAfterTax(dividend_amount DECIMAL(10, 2)) 
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    -- Declare a variable to store the tax rate (10%)
    DECLARE tax_rate DECIMAL(4, 2);
    
    -- Set the tax rate
    SET tax_rate = 0.10;
    
    -- Return the dividend after applying the tax deduction
    RETURN dividend_amount - (dividend_amount * tax_rate);
END //

DELIMITER ;

SELECT 
    dividend_id, 
    stock_id, 
    dividend_amount, 
    CalculateDividendAfterTax(dividend_amount) AS dividend_after_tax
FROM Dividends;

-- TABLE 8 
DELIMITER //

-- Create the function that calculates total quantity for a given stock_id
CREATE FUNCTION get_total_quantity(stock_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_quantity INT;

    -- Select the sum of quantities for the given stock_id from the Portfolios table
    SELECT SUM(quantity) INTO total_quantity
    FROM Portfolios
    WHERE stock_id = stock_id;
    
    -- Return the total quantity
    RETURN total_quantity;
END //

DELIMITER ;

SELECT get_total_quantity(400001);

-- TABLE 9
DELIMITER //

-- Create a function to calculate the number of days since a stock was added to the watchlist
CREATE FUNCTION CalculateDaysSinceAdded(watchlist_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days_since_added INT;

    -- Get the number of days from the added_date of the specific watchlist
    SELECT DATEDIFF(CURDATE(), added_date)
    INTO days_since_added
    FROM Watchlist
    WHERE watchlist_id = watchlist_id;

    -- Return the calculated number of days
    RETURN days_since_added;
END //

DELIMITER ;

SELECT CalculateDaysSinceAdded(900001);

-- TABLE 10 
-- Creating a function to get the exchange name by exchange_id
DELIMITER //

CREATE FUNCTION get_exchange_name(p_exchange_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    -- Declare a variable to store the exchange name
    DECLARE v_exchange_name VARCHAR(100);
    
    -- Select the exchange name where the exchange_id matches the provided value
    SELECT exchange_name INTO v_exchange_name
    FROM Exchanges
    WHERE exchange_id = p_exchange_id;
    
    -- Return the exchange name
    RETURN v_exchange_name;
END //

DELIMITER ;

SELECT get_exchange_name(1992); 

-- TABLE 11 

-- TABLE 12 
DELIMITER //

-- Create a function to adjust price by a percentage
CREATE FUNCTION AdjustPrice(stock_id INT, percentage DECIMAL(5, 2))
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE current_price DECIMAL(10, 2);

    -- Retrieve the current price for the given stock_id from MarketHistory table
    SELECT price INTO current_price
    FROM MarketHistory
    WHERE stock_id = stock_id
    ORDER BY date DESC
    LIMIT 1;

    -- Adjust the price based on the given percentage
    SET current_price = current_price + (current_price * percentage / 100);

    -- Return the adjusted price
    RETURN current_price;
END //

DELIMITER ;

-- To adjust the price of stock with stock_id = 400001 by 10% increase
SELECT AdjustPrice(400001, 10);


-- TABLE 15 
DELIMITER //

-- Creating a function to get the headquarters of a company based on company_id
CREATE FUNCTION GetHeadquarters(company_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    -- Declaring a variable to store the result (headquarters)
    DECLARE headquarters VARCHAR(100);
    
    -- Fetching the headquarters from the Company table where the company_id matches
    SELECT headquarters
    INTO headquarters
    FROM Company
    WHERE company_id = company_id;
    
    -- Returning the headquarters value
    RETURN headquarters;
END //

DELIMITER ;

SELECT GetHeadquarters(900001);

-- TABLE 16 
DELIMITER //

-- Creating the function to calculate rating
CREATE FUNCTION GetIPORating (issue_price DECIMAL(10, 2), shares_issued INT)
RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE rating VARCHAR(50);

    -- Example criteria for rating
    IF issue_price >= 1000 AND shares_issued >= 1000000 THEN
        SET rating = 'Excellent';
    ELSEIF issue_price >= 500 AND shares_issued >= 1000000 THEN
        SET rating = 'Good';
    ELSEIF issue_price >= 300 AND shares_issued >= 500000 THEN
        SET rating = 'Average';
    ELSE
        SET rating = 'Poor';
    END IF;

    RETURN rating;
END //

DELIMITER ;

CREATE TABLE IPO_Ratings (
    rating_id INT PRIMARY KEY AUTO_INCREMENT,
    ipo_id INT,
    rating VARCHAR(50),
    rating_date DATE,
    FOREIGN KEY (ipo_id) REFERENCES IPO(ipo_id)
);

-- Inserting ratings for each IPO based on the function
INSERT INTO IPO_Ratings (ipo_id, rating, rating_date)
SELECT 
    ipo_id,
    GetIPORating(issue_price, shares_issued),
    CURDATE()  -- Current date for rating date
FROM IPO;

-- TABLE 17 

DELIMITER //

-- Creating the function to fetch the latest rating and rating date for a stock
CREATE FUNCTION GetLatestRating(stockId INT)
RETURNS VARCHAR(255) 
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(255);

    -- Query to fetch the latest rating and rating date for the given stock
    SELECT CONCAT(rating, ' on ', rating_date) 
    INTO result
    FROM AnalystRatings
    WHERE stock_id = stockId
    ORDER BY rating_date DESC
    LIMIT 1;

    -- Return the result
    RETURN result;
END //

DELIMITER ;

SELECT GetLatestRating(400001);

DELIMITER //

-- TABLE 18

CREATE FUNCTION DaysSinceSent(message_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    -- Declare a variable to store the sent date
    DECLARE sent_date DATE;
    
    -- Get the sent date from the UserMessages table for the given message_id
    SELECT sent_date INTO sent_date 
    FROM UserMessages 
    WHERE message_id = message_id;
    
    -- Return the number of days between the current date and the sent date
    RETURN DATEDIFF(CURDATE(), sent_date);
END //

DELIMITER ;

SELECT DaysSinceSent(1200001);

-- TABLE 19 
-- Create a function to calculate the number of days since 'created_at'
DELIMITER //

CREATE FUNCTION days_since_created_at(fee_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE days_diff INT;

    -- Get the difference in days between the current date and the 'created_at' date
    SELECT DATEDIFF(CURDATE(), created_at) 
    INTO days_diff
    FROM Fees 
    WHERE fee_id = fee_id;

    -- Return the difference in days
    RETURN days_diff;
END //

DELIMITER ;

SELECT days_since_created_at(1300001);

-- TABLE 20 
-- Create a function to count the number of words in the 'body' column
DELIMITER //

CREATE FUNCTION CountWordsInBody(news_id INT) 
RETURNS INT
DETERMINISTIC
BEGIN
    -- Declare a variable to hold the body of the news article
    DECLARE news_body TEXT;

    -- Declare a variable to hold the word count
    DECLARE word_count INT;

    -- Retrieve the 'body' content of the news article based on the provided 'news_id'
    SELECT body INTO news_body
    FROM MarketNews
    WHERE news_id = news_id;

    IF news_body IS NOT NULL THEN
        SET word_count = (LENGTH(news_body) - LENGTH(REPLACE(news_body, ' ', '')) + 1);
    ELSE
        SET word_count = 0;
    END IF;

    -- Return the calculated word count
    RETURN word_count;
END //

DELIMITER ;

SELECT CountWordsInBody(123456);

-- VIEW 
-- Create a view to show user details with their creation date
CREATE VIEW UserDetails AS
SELECT 
    user_id,              
    name,                 
    email,                
    created_at             
FROM Users;

-- Query to retrieve data from the view
SELECT * FROM UserDetails;

-- TABLE 2 
-- Creating a view to display broker details
CREATE VIEW BrokerDetails AS
SELECT 
    broker_id,               
    broker_name,             
    contact_email,           
    phone_number          
FROM Brokers;

-- You can now query this view like a table:
 SELECT * FROM BrokerDetails;
 
 -- TABLE 3 
 -- Create a view to show account details with formatted account balance and a more readable account creation date
CREATE VIEW AccountDetails AS
SELECT
    a.account_id,  
    a.user_id,    
    a.broker_id,   
    FORMAT(a.account_balance, 2) AS formatted_balance,  
    DATE_FORMAT(a.created_at, '%M %d, %Y') AS created_date  
FROM
    Accounts a;

SELECT * FROM AccountDetails;

-- TABLE 4
-- Create a view to display selected stock details
CREATE VIEW StockView AS
SELECT 
    stock_id,              
    stock_symbol,    
    stock_name,            
    current_price,          
    exchange          
FROM Stocks;       

SELECT * from StockView ;

-- table 5 
-- Creating a view to display transaction details
CREATE VIEW TransactionDetails AS
SELECT 
    t.transaction_id,             
    t.account_id,                   
    t.stock_id,                     
    t.transaction_type,          
    t.quantity,                    
    t.price_per_stock,             
    t.transaction_date,       
    (t.quantity * t.price_per_stock) AS total_value 
FROM 
    Transactions t; 

select * from TransactionDetails ;

-- table 6 
-- Creating a view to display orders with details, including account and stock information
CREATE VIEW OrderDetails AS
    SELECT 
        o.order_id,
        o.account_id,             
        o.stock_id,             
        o.order_type,           
        o.quantity,             
        o.price,                 
        o.order_date,             
        o.status,                 
		s.stock_name
    FROM 
        Orders o
    JOIN 
        Accounts a ON o.account_id = a.account_id 
    JOIN 
        Stocks s ON o.stock_id = s.stock_id;  

select * from OrderDetails ;

-- table 7

-- Create a view to display dividends along with stock information
CREATE VIEW DividendDetails AS
    SELECT 
        d.dividend_id,           
        d.stock_id,         
        s.stock_name,            
        d.dividend_amount,       
        d.dividend_date           
    FROM 
        Dividends d
   inner JOIN 
        Stocks s ON d.stock_id = s.stock_id;  
 
-- View created to provide an overview of dividends and associated stock names.
select * from DividendDetails ;

-- table 8 
-- Creating a view to display portfolio details
CREATE VIEW PortfolioDetails AS
    SELECT
        p.portfolio_id,           
        p.stock_id,          
        s.stock_name,              
        p.quantity                
    FROM
        Portfolios p           
    inner JOIN
        Accounts a             
    ON
        p.account_id = a.account_id 
    inner JOIN
        Stocks s                  
    ON
        p.stock_id = s.stock_id; 

-- View 'PortfolioDetails' is created successfully

select * from PortfolioDetails ;

-- table 9 
-- Creating a VIEW to display the watchlist with user and stock details
CREATE VIEW WatchlistView AS
SELECT
    w.watchlist_id,           -- Unique ID for the watchlist entry
    w.user_id,                -- User ID associated with the watchlist
    w.stock_id,               -- Stock ID in the watchlist
    s.stock_name,             -- Stock name from the Stocks table
    w.added_date              -- Date the stock was added to the watchlist
FROM
    Watchlist w
    right JOIN Users u ON w.user_id = u.user_id     
    right JOIN Stocks s ON w.stock_id = s.stock_id;

select * from WatchlistView ;

-- table 10

-- Creating a view to display exchange information with a filter for exchanges based in India
CREATE VIEW IndianExchanges AS
SELECT 
    exchange_id,      -- Unique identifier for each exchange
    exchange_name,    -- Name of the exchange
    country           -- Country where the exchange is located
FROM 
    Exchanges         -- The base table containing exchange data
WHERE
    country = 'India'; -- Filtering for exchanges in India only

-- Query to view the created view
SELECT * FROM IndianExchanges;

-- table 11 
-- Create a view that combines data from Stocks, Exchanges, and StockExchange
CREATE VIEW StockExchangeDetails AS
SELECT 
    se.stock_id,                 -- Stock ID from StockExchange table
    s.stock_name,                -- Stock name from Stocks table
    se.exchange_id,              -- Exchange ID from StockExchange table
    e.exchange_name,             -- Exchange name from Exchanges table
    se.stock_id AS stock_reference,  -- Alias to avoid confusion with stock_id in SELECT
    se.exchange_id AS exchange_reference  -- Alias for exchange_id
FROM 
    StockExchange se              -- From the StockExchange table
inner JOIN 
    Stocks s ON se.stock_id = s.stock_id    -- Join with Stocks table on stock_id
right JOIN 
    Exchanges e ON se.exchange_id = e.exchange_id;  -- Join with Exchanges table on exchange_id

-- The view StockExchangeDetails will now allow you to see detailed information about the stock-exchange pairs.

select * from StockExchangeDetails ;

-- table 12 
CREATE VIEW view_market_history AS
SELECT 
    history_id,  -- Unique identifier for each record in the market history
    stock_id,    -- Identifier for the stock (foreign key referencing the Stocks table)
    price,       -- The price of the stock on the given date
    date         -- The date of the stock price entry
FROM MarketHistory;

SELECT * FROM view_market_history;

-- table 13 
-- Create a view to select all the stock sectors
CREATE VIEW ViewStockSectors AS
    -- Select the sector_id and sector_name columns from the StockSectors table
    SELECT 
        sector_id,      -- The unique identifier for each sector
        sector_name     -- The name of the sector
    FROM 
        StockSectors;   -- From the StockSectors table

SELECT * FROM ViewStockSectors;

-- table 14 
-- Creating a view to retrieve stock and sector mapping details
CREATE VIEW StockSectorView AS
SELECT 
    s.stock_id, 
    ss.sector_name 
FROM 
    StockSectorMapping sm
left JOIN 
    Stocks s ON sm.stock_id = s.stock_id
right JOIN 
    StockSectors ss ON sm.sector_id = ss.sector_id;

-- The view StockSectorView is now created. It shows each stock's ID and the name of the sector it belongs to.

select * from StockSectorView ;

-- table 15 
-- Creating a view that retrieves company names, their stock IDs, and headquarters locations
CREATE VIEW CompanyView AS
SELECT
    company_id,          -- The unique ID of the company
    company_name,        -- The name of the company
    stock_id,            -- The stock ID associated with the company
    headquarters         -- The location of the company's headquarters
FROM
    Company;

-- You can now query the view like this:
SELECT * FROM CompanyView;

-- table 16
-- Create a view called 'IPO_View' to display IPO details
CREATE VIEW IPO_View AS
SELECT 
    ipo_id,            -- Unique identifier for each IPO
    stock_id,          -- Identifier for the stock associated with the IPO, references 'Stocks' table
    issue_price,       -- Price per share at the IPO
    issue_date,        -- Date the IPO was issued
    shares_issued      -- Number of shares issued in the IPO
FROM 
    IPO;

-- Query to display the created view
SELECT * FROM IPO_View;

-- table 17 
-- Create a view to show analyst ratings with stock ID, analyst name, rating, and rating date
CREATE VIEW AnalystRatingSummary AS
SELECT 
    rating_id,
    stock_id,
    analyst_name,
    rating,
    rating_date
FROM 
    AnalystRatings;

-- Selecting data from the view to verify its content
SELECT * FROM AnalystRatingSummary;

-- table 18 

-- Creating the UserMessageDetails view to display messages along with sender and receiver names
CREATE VIEW UserMessageDetails AS
SELECT 
    um.message_id, 
    sender.user_id AS sender_id, 
    receiver.user_id AS receiver_id, 
    um.message_text, 
    um.sent_date
FROM 
    UserMessages um
inner JOIN 
    Users sender ON um.sender_id = sender.user_id
right JOIN 
    Users receiver ON um.receiver_id = receiver.user_id;



select * from UserMessageDetails ;

-- table 19

CREATE VIEW FeesView AS
SELECT 
    fee_id,
    broker_id,
    trade_fee,
    created_at
FROM 
    Fees;
    
    CREATE VIEW FeesViews
AS 
SELECT 
    fee_id AS 'Unique identifier for each fee entry',
    broker_id AS 'Identifier for each broker',
    trade_fee AS 'Fee charged per trade',
    created_at AS 'Date when the fee record was created'
FROM 
    Fees ;
    
    select * from FeesViews;
    select * from FeesView ;
    
    -- table 20 
    CREATE VIEW MarketNewsView AS
SELECT 
    news_id,
    headline,
    published_date
FROM 
    MarketNews ;
    
    select * from MarketNewsView ;
    
    -- CTE ----
-- Step 1: Define the CTE for filtering users created after a specific date
WITH FilteredUsers AS (
    SELECT user_id, name, email, password, created_at
    FROM Users
    WHERE created_at > '2023-05-01'
),

-- Step 2: Add a ranking of users based on user_id descending
RankedUsers AS (
    SELECT user_id, name, email, password, created_at,
           ROW_NUMBER() OVER (ORDER BY user_id DESC) AS user_rank
    FROM FilteredUsers
),


-- Step 3: Ensure passwords are longer than 8 characters (validation)
ValidatedPasswords AS (
    SELECT user_id, name, email, password, created_at, user_rank
    FROM RankedUsers
    WHERE LENGTH(password) >= 8
),
-- Step 4: Calculate the number of days since account creation
DaysSinceCreation AS (
    SELECT user_id, name, email, password, created_at, user_rank,
           DATEDIFF(CURRENT_DATE, created_at) AS days_since_creation
    FROM ValidatedPasswords
),


-- Step 5: Filter users created within the last 6 months
RecentUsers AS (
    SELECT user_id, name, email, password, created_at, user_rank, days_since_creation
    FROM DaysSinceCreation
    WHERE created_at >= DATE_SUB(CURRENT_DATE, INTERVAL 6 MONTH)
),


-- Step 6: Count how many users meet the criteria
UserCount AS (
    SELECT COUNT(*) AS user_count
    FROM RecentUsers
)
,
-- Step 7: Sort users by days since creation, from newest to oldest
SortedUsers AS (
    SELECT user_id, name, email, password, created_at, user_rank, days_since_creation
    FROM RecentUsers
    ORDER BY days_since_creation DESC
)

-- Final Step: Select the sorted users
SELECT *
FROM SortedUsers;

-- table 2 
	WITH CTE_Client_PhoneNumbers AS (
    SELECT client_id, client_name, contact_email, phone_number
    FROM Clients
    WHERE phone_number LIKE '9123%'  -- Filter clients with phone numbers starting with '9123'
)
-- Step 4: Select all clients from the CTE
SELECT * FROM CTE_Client_PhoneNumbers;

-- Step 5: Use a CTE to get clients whose names start with 'J' and then count them
WITH CTE_Clients_With_J AS (
    SELECT client_id, client_name, contact_email, phone_number
    FROM Clients
    WHERE client_name LIKE 'J%'  -- Filter clients whose name starts with 'J'
)
-- Step 6: Count the number of clients that start with 'J'
SELECT COUNT(*) AS NumberOfClientsStartingWithJ FROM CTE_Clients_With_J;

-- Step 7: Update phone number for a specific client (e.g., change 'Bob Brown' phone number)
WITH CTE_Update_Client_Phone AS (
    SELECT client_id, client_name, contact_email, phone_number
    FROM Clients
    WHERE client_name = 'Bob Brown'  -- Identify the client 'Bob Brown'
)
UPDATE Clients
SET phone_number = '9123456800'  -- Update phone number
WHERE client_id = (SELECT client_id FROM CTE_Update_Client_Phone);

-- Step 8: Check the updated phone number
SELECT * FROM Clients WHERE client_name = 'Bob Brown';


-- table 3 
-- Step 1: Define a CTE to calculate the total balance for each broker
WITH BrokerBalanceCTE AS (
    -- Step 2: Select the broker_id and account_balance
    SELECT 
        broker_id,
        account_balance
    FROM 
        Accounts
)
-- Step 3: Now, aggregate the account balance by broker_id
, BrokerTotalBalance AS (
    SELECT 
        broker_id,
        SUM(account_balance) AS total_balance
    FROM 
        BrokerBalanceCTE
    GROUP BY 
        broker_id
)
-- Step 4: Select the result from the CTEs to display the total balance for each broker
SELECT 
    B.broker_id, 
    B.total_balance,
    BR.broker_name
FROM 
    BrokerTotalBalance B
-- Step 5: Join with the Brokers table to get the broker's name
JOIN 
    Brokers BR ON B.broker_id = BR.broker_id
ORDER BY 
    B.total_balance DESC;
    
    -- table 4 
    -- Step 1: Define the CTE to calculate the total quantities bought and sold for each stock
WITH StockTransactionSummary AS (
    SELECT
        stock_id,
        SUM(CASE WHEN transaction_type = 'BUY' THEN quantity ELSE 0 END) AS total_bought,
        SUM(CASE WHEN transaction_type = 'SELL' THEN quantity ELSE 0 END) AS total_sold
    FROM Transactions
    GROUP BY stock_id
)

-- Step 2: Define another CTE to calculate the average price per stock for each transaction
, AverageStockPrice AS (
    SELECT
        stock_id,
        AVG(price_per_stock) AS avg_price
    FROM Transactions
    GROUP BY stock_id
)

-- Step 3: Combine the CTEs and get the final results
SELECT
    sts.stock_id,
    sts.total_bought,
    sts.total_sold,
    aps.avg_price
FROM StockTransactionSummary sts
JOIN AverageStockPrice aps ON sts.stock_id = aps.stock_id

-- Step 4: Filter results to show only those stocks where more stock was bought than sold
WHERE sts.total_bought > sts.total_sold

-- Step 5: Order by the stock_id
ORDER BY sts.stock_id;

-- table 6 '
WITH FilteredOrders AS (
    -- Step 4: Select only the BUY orders with quantity greater than 5 and a price greater than 1000
    SELECT order_id, account_id, stock_id, order_type, quantity, price, order_date, status
    FROM Orders
    WHERE order_type = 'BUY' AND quantity > 5 AND price > 1000
)
-- Step 5: Use the CTE to display the filtered results
SELECT * 
FROM FilteredOrders
ORDER BY order_date DESC;

-- Step 6: Calculate the total value of each order (quantity * price) using CTE
WITH OrderValues AS (
    SELECT order_id, account_id, stock_id, order_type, quantity, price, quantity * price AS total_value
    FROM Orders
)
-- Step 7: Display the order details along with the total value of each order
SELECT order_id, account_id, stock_id, order_type, quantity, price, total_value
FROM OrderValues
ORDER BY total_value DESC;

-- table 7

-- Step 1: Define the CTE that calculates the average dividend per stock.
WITH AverageDividends AS (
    SELECT stock_id,
           AVG(dividend_amount) AS avg_dividend
    FROM Dividends
    GROUP BY stock_id
)
-- Step 2: Now, we can use the CTE in a main query.
SELECT D.dividend_id,
       D.stock_id,
       D.dividend_amount,
       D.dividend_date,
       A.avg_dividend
FROM Dividends D
-- Step 3: Join the Dividends table with the CTE (AverageDividends) on stock_id.
JOIN AverageDividends A ON D.stock_id = A.stock_id
-- Step 4: Filter to only show dividends that are greater than the average dividend for each stock.
WHERE D.dividend_amount > A.avg_dividend
-- Step 5: Order the results by stock_id to group the output by stock.
ORDER BY D.stock_id;

-- table 8

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    item_id INT,
    quantity INT,
    sale_date DATE
);

-- Inserting some sample sales data
INSERT INTO Sales (sale_id, customer_id, item_id, quantity, sale_date)
VALUES
(1, 101, 2001, 5, '2024-01-10'),
(2, 102, 2002, 3, '2024-02-12'),
(3, 103, 2003, 2, '2024-03-15'),
(4, 104, 2004, 10, '2024-04-16'),
(5, 105, 2005, 4, '2024-05-18'),
(6, 106, 2006, 7, '2024-06-20'),
(7, 107, 2007, 1, '2024-07-22'),
(8, 108, 2008, 6, '2024-08-24'),
(9, 109, 2009, 8, '2024-09-26'),
(10, 110, 2010, 5, '2024-10-28');

WITH CustomerSales AS (
    -- Step 1: CTE that calculates the total quantity of items sold by each customer
    SELECT 
        customer_id, 
        SUM(quantity) AS total_quantity
    FROM Sales
    GROUP BY customer_id
),
FilteredCustomers AS (
    -- Step 2: Filter customers who bought more than 5 items
    SELECT 
        customer_id, 
        total_quantity
    FROM CustomerSales
    WHERE total_quantity > 5
),
SortedCustomers AS (
    -- Step 3: Sort the results by customer_id
    SELECT 
        customer_id, 
        total_quantity
    FROM FilteredCustomers
    ORDER BY customer_id
),
TotalSales AS (
    -- Step 4: Calculate the total quantity sold across all customers
    SELECT 
        SUM(quantity) AS total_sales
    FROM Sales
),
AvgSales AS (
    -- Step 5: Calculate the average quantity sold by each customer
    SELECT 
        AVG(total_quantity) AS avg_quantity
    FROM CustomerSales
),
AboveAverageCustomers AS (
    -- Step 6: Filter customers who bought more than the average quantity
    SELECT 
        s.customer_id, 
        s.total_quantity
    FROM SortedCustomers s, AvgSales a
    WHERE s.total_quantity > a.avg_quantity
)
-- Step 7: Final query to select results
SELECT 
    ac.customer_id, 
    ac.total_quantity
FROM AboveAverageCustomers ac;
/* --------------------------------------------- */
-- Step 3: Use a CTE to calculate the total quantity of each stock across all portfolios.
WITH TotalStockQuantity AS (
    SELECT stock_id, SUM(quantity) AS total_quantity
    FROM Portfolios
    GROUP BY stock_id
)
SELECT * FROM TotalStockQuantity;  	-- This will return the total quantity for each stock

-- Step 4: Calculate the average quantity of stocks held by accounts using a CTE.
WITH AverageStockQuantity AS (
    SELECT account_id, AVG(quantity) AS average_quantity
    FROM Portfolios
    GROUP BY account_id
)
SELECT * FROM AverageStockQuantity;  -- This will return the average quantity of stocks per account

    -- Step 5: Find the portfolio with the maximum quantity of stocks held in any portfolio using a CTE.
WITH MaxStockQuantity AS (
    SELECT portfolio_id, quantity
    FROM Portfolios
    WHERE quantity = (SELECT MAX(quantity) FROM Portfolios)  -- Subquery to get the maximum quantity
)
SELECT * FROM MaxStockQuantity;  -- Returns portfolio(s) with the highest quantity

   -- Step 6: Find all portfolios that hold more than 10 stocks using a CTE.
WITH PortfoliosAboveThreshold AS (
    SELECT portfolio_id, account_id, stock_id, quantity
    FROM Portfolios
    WHERE quantity > 10  -- Only portfolios with quantity greater than 10
)
SELECT * FROM PortfoliosAboveThreshold;  -- This will return portfolios meeting the condition
 
-- Step 7: Combine multiple CTEs to return a comprehensive summary of stock quantities and account averages.
WITH TotalStockQuantity AS (
    SELECT stock_id, SUM(quantity) AS total_quantity
    FROM Portfolios
    GROUP BY stock_id
),
AverageStockQuantity AS (
    SELECT account_id, AVG(quantity) AS average_quantity
    FROM Portfolios
    GROUP BY account_id
)
-- Selecting data from both CTEs to get a full report
SELECT t.stock_id, t.total_quantity, a.account_id, a.average_quantity
FROM TotalStockQuantity t
JOIN AverageStockQuantity a ON 1 = 1;  -- Join to combine both results (no specific condition)

 -- table 9 
	-- Step 1: Define the CTE to calculate the number of stocks added by each user
WITH UserStockCount AS (
    SELECT 
        user_id, 
        COUNT(stock_id) AS stock_count  -- Count the number of stocks per user
    FROM Watchlist
    WHERE added_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)  -- Only consider stocks added in the last 3 months
    GROUP BY user_id  -- Group by user_id to get a count of stocks per user
),

-- Step 2: Define another CTE to rank users based on the number of stocks they have added
UserStockRank AS (
    SELECT 
        user_id, 
        stock_count,
        RANK() OVER (ORDER BY stock_count DESC) AS ranks  -- Rank users by stock count in descending order
    FROM UserStockCount  -- Use the results from the previous CTE
),

-- Step 3: Define a CTE to retrieve the user details (e.g., user_id, name) from the Users table
UserDetails AS (
    SELECT 
        user_id, 
        CONCAT('User ', user_id) AS user_name  -- For example, generating a placeholder name
    FROM Users
)

-- Step 4: Combine the CTEs and filter users based on their rank and add their details
SELECT 
    ud.user_name, 
    usr.stock_count, 
    usr.rank
FROM 
    UserStockRank usr
JOIN 
    UserDetails ud ON usr.user_id = ud.user_id  -- Join with the user details
WHERE 
    usr.rank <= 5  -- Only show the top 5 users with the most stocks added
ORDER BY 
    usr.rank;  -- Order the results by rank

-- Step 5: Check the total number of users who have added stocks in the past 3 months
SELECT 
    COUNT(DISTINCT user_id) AS total_users
FROM 
    Watchlist
WHERE 
    added_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);  -- Filter for users who added stocks in the last 3 months

-- Step 6: Get a list of all the stock ids in the Watchlist for the last 3 months
SELECT 
    DISTINCT stock_id
FROM 
    Watchlist
WHERE 
    added_date >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH);  -- Only consider stocks added in the last 3 months

-- Step 7: Find the most recently added stock to the watchlist
SELECT 
    stock_id, 
    MAX(added_date) AS most_recent_date  -- Get the most recent date for each stock
FROM 
    Watchlist
GROUP BY 
    stock_id
ORDER BY 
    most_recent_date DESC  -- Sort to get the latest added stock first
LIMIT 1; 

-- table 10
-- Step 1: Create a table for storing company data
CREATE TABLE Companies (
    company_id INT PRIMARY KEY,
    company_name VARCHAR(100),
    industry VARCHAR(50),
    revenue DECIMAL(15, 2),
    employees INT
);

-- Step 2: Insert sample data into Companies table
INSERT INTO Companies (company_id, company_name, industry, revenue, employees)
VALUES
(101, 'TechCorp', 'Technology', 5000000.00, 1000),
(102, 'MedPlus', 'Healthcare', 2000000.00, 500),
(103, 'RetailMax', 'Retail', 1000000.00, 300),
(104, 'AutoTech', 'Automotive', 4000000.00, 800),
(105, 'Foodies', 'Food & Beverage', 2500000.00, 200);

-- Step 3: Define a CTE that selects only companies with revenue greater than 2 million
WITH HighRevenueCompanies AS (
    SELECT company_id, company_name, industry, revenue
    FROM Companies
    WHERE revenue > 2000000.00
)

-- Step 4: Use the CTE to further filter companies from the 'Technology' industry
, TechnologyCompanies AS (
    SELECT company_id, company_name, revenue
    FROM HighRevenueCompanies
    WHERE industry = 'Technology'
)

-- Step 5: Select the companies with their revenue in the 'Technology' industry
SELECT company_id, company_name, revenue
FROM TechnologyCompanies;

-- Step 6: Update the revenue of 'TechCorp' by increasing it by 10%
UPDATE Companies
SET revenue = revenue * 1.10
WHERE company_name = 'TechCorp';

-- Step 7: Select all companies to see the updated revenue
SELECT company_id, company_name, revenue
FROM Companies;

-- Step 1: Define the basic structure of the CTE, select all exchanges
WITH ExchangesCTE AS (
    SELECT
        exchange_id,
        exchange_name,
        country
    FROM Exchanges
)
-- Step 2: Filter exchanges that are located in India
, FilteredExchanges AS (
    SELECT
        exchange_id,
        exchange_name,
        country
    FROM ExchangesCTE
    WHERE country = 'India'
)
-- Step 3: Get the count of exchanges in India
, CountExchanges AS (
    SELECT
        COUNT(*) AS exchange_count
    FROM FilteredExchanges
)
-- Step 4: Retrieve exchanges along with their country and include the count of exchanges
, ExchangesWithCount AS (
    SELECT
        fe.exchange_id,
        fe.exchange_name,
        fe.country,
        ce.exchange_count
    FROM FilteredExchanges fe, CountExchanges ce
)
-- Step 5: Add a new column that indicates whether the exchange is large or small based on ID (example logic)
, CategorizedExchanges AS (
    SELECT
        exchange_id,
        exchange_name,
        country,
        exchange_count,
        CASE 
            WHEN exchange_id BETWEEN 600001 AND 600005 THEN 'Large'
            ELSE 'Small'
        END AS size_category
    FROM ExchangesWithCount
)
-- Step 6: Now, sort the exchanges by their category (large or small) and name
, SortedExchanges AS (
    SELECT
        exchange_id,
        exchange_name,
        country,
        exchange_count,
        size_category
    FROM CategorizedExchanges
    ORDER BY size_category DESC, exchange_name
)
-- Step 7: Select the final results showing the exchange details
SELECT
    exchange_id,
    exchange_name,
    country,
    exchange_count,
    size_category
FROM SortedExchanges;

-- table 11
-- table 12 
-- Step 1: Define the CTE to aggregate the stock prices by month
WITH MonthlyStockPrices AS (
    -- Step 2: Select the stock_id, the year and month of the date, and the average price
    SELECT
        stock_id,
        YEAR(date) AS year,
        MONTH(date) AS month,
        AVG(price) AS average_price
    -- Step 3: From the MarketHistory table
    FROM MarketHistory
    -- Step 4: Group the results by stock_id and year-month combination
    GROUP BY stock_id, YEAR(date), MONTH(date)
)

-- Step 5: Query the CTE to retrieve the stock_id, year, month, and the calculated average price
SELECT 
    stock_id, 
    year, 
    month, 
    average_price
-- Step 6: Order the results by year and month for clarity
FROM MonthlyStockPrices
ORDER BY year, month;

-- Step 7: The query ends here and returns the aggregated data by month and stock.

-- table 13

-- table 14 
-- Step 1: Create the Products table
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100)
);

-- Step 2: Create the Categories table
CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    category_name VARCHAR(100)
);

-- Step 3: Insert sample data into Products table
INSERT INTO Products (product_id, product_name)
VALUES
(1001, 'Laptop'),
(1002, 'Smartphone'),
(1003, 'Tablet'),
(1004, 'Smartwatch'),
(1005, 'Headphones');

-- Step 4: Insert sample data into Categories table
INSERT INTO Categories (category_id, category_name)
VALUES
(2001, 'Electronics'),
(2002, 'Accessories'),
(2003, 'Computers');

-- Step 5: Create the ProductCategoryMapping table to map products to categories
CREATE TABLE ProductCategoryMapping (
    product_id INT,
    category_id INT,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id),
    PRIMARY KEY (product_id, category_id)
);

-- Step 6: Insert data into ProductCategoryMapping table
INSERT INTO ProductCategoryMapping (product_id, category_id)
VALUES
(1001, 2001),  -- Laptop belongs to Electronics
(1002, 2001),  -- Smartphone belongs to Electronics
(1003, 2003),  -- Tablet belongs to Computers
(1004, 2002),  -- Smartwatch belongs to Accessories
(1005, 2002);  -- Headphones belongs to Accessories

-- Step 7: Use CTE to retrieve products along with their category names
WITH ProductCategoryCTE AS (
    SELECT 
        p.product_id,
        p.product_name,
        c.category_name
    FROM 
        Products p
    INNER JOIN 
        ProductCategoryMapping pcm ON p.product_id = pcm.product_id
    INNER JOIN 
        Categories c ON pcm.category_id = c.category_id
)
SELECT * FROM ProductCategoryCTE;

-- table 15 
	-- Step 1: Create a CTE to find all companies headquartered in Mumbai
WITH MumbaiCompanies AS (
    SELECT company_id, company_name, headquarters
    FROM Company
    WHERE headquarters = 'Mumbai, India'
)

-- Step 2: Select data from the CTE to ensure it contains the correct companies
SELECT * FROM MumbaiCompanies;

-- Step 3: Update the headquarters for some companies located in Mumbai
WITH UpdatedHeadquarters AS (
    SELECT company_id
    FROM Company
    WHERE headquarters = 'Mumbai, India'
    AND company_name IN ('Tata Consultancy Services', 'Reliance Industries')
)
UPDATE Company
SET headquarters = 'Mumbai, New Location'
WHERE company_id IN (SELECT company_id FROM UpdatedHeadquarters);

-- Step 4: Select the updated companies to confirm changes
SELECT company_id, company_name, headquarters
FROM Company
WHERE company_id IN (SELECT company_id FROM UpdatedHeadquarters);

-- Step 5: Create a CTE to join Company table with Stocks table (assuming Stocks table exists with stock_id and stock_name)
WITH CompanyStockInfo AS (
    SELECT C.company_name, C.headquarters, S.stock_name
    FROM Company C
    JOIN Stocks S ON C.stock_id = S.stock_id
)

-- Step 6: Query the CTE to get company stock information
SELECT * FROM CompanyStockInfo;

-- Step 7: Aggregate the number of companies per headquarters location
WITH CompanyCounts AS (
    SELECT headquarters, COUNT(*) AS company_count
    FROM Company
    GROUP BY headquarters
)

-- Final step: Display the headquarters and count of companies at each location
SELECT * FROM CompanyCounts;

-- table 16 
WITH IPO_CTE AS (
    -- Step 1: Select all IPO records to work with
    SELECT ipo_id, stock_id, issue_price, issue_date, shares_issued
    FROM IPO
),
Price_Filtered_CTE AS (
    -- Step 2: Filter IPOs with issue price greater than 500
    SELECT ipo_id, stock_id, issue_price, issue_date, shares_issued
    FROM IPO_CTE
    WHERE issue_price > 500
),
Share_Count_CTE AS (
    -- Step 3: Calculate the total shares issued for filtered IPOs
    SELECT SUM(shares_issued) AS total_shares_issued
    FROM Price_Filtered_CTE
),
Stock_Info_CTE AS (
    -- Step 4: Join with a fictional Stocks table to get additional stock info
    SELECT s.stock_id, s.stock_name, p.issue_price, p.shares_issued
    FROM Price_Filtered_CTE p
    JOIN Stocks s ON s.stock_id = p.stock_id
),
Stock_Price_Range_CTE AS (
    -- Step 5: Calculate the price range for the IPOs
    SELECT stock_id, 
           MIN(issue_price) AS min_price, 
           MAX(issue_price) AS max_price
    FROM Stock_Info_CTE
    GROUP BY stock_id
),
Date_Range_CTE AS (
    -- Step 6: Determine the range of IPO dates
    SELECT MIN(issue_date) AS first_ipo_date, 
           MAX(issue_date) AS last_ipo_date
    FROM Price_Filtered_CTE
),
Final_CTE AS (
    -- Step 7: Combine all the calculated data into one final result
    SELECT s.stock_id, 
           s.stock_name, 
           sr.min_price, 
           sr.max_price, 
           d.first_ipo_date, 
           d.last_ipo_date, 
           s.issue_price, 
           s.shares_issued
    FROM Stock_Info_CTE s
    JOIN Stock_Price_Range_CTE sr ON s.stock_id = sr.stock_id
    CROSS JOIN Date_Range_CTE d
)
-- Final Output: Select the final result
SELECT * 
FROM Final_CTE
ORDER BY stock_id;

-- table 17 
-- Step 1: CTE to get the most recent rating date for each stock
WITH MostRecentRatings AS (
    SELECT stock_id, MAX(rating_date) AS latest_rating_date
    FROM AnalystRatings
    GROUP BY stock_id
),

-- Step 2: CTE to join the previous CTE with the AnalystRatings table to get the corresponding rating
LatestRatings AS (
    SELECT ar.rating_id, ar.stock_id, ar.analyst_name, ar.rating, ar.rating_date
    FROM AnalystRatings ar
    JOIN MostRecentRatings mrr
    ON ar.stock_id = mrr.stock_id
    AND ar.rating_date = mrr.latest_rating_date
),

-- Step 3: CTE to filter stocks with a 'Buy' rating
BuyRatings AS (
    SELECT stock_id, analyst_name, rating, rating_date
    FROM LatestRatings
    WHERE rating = 'Buy'
),

-- Step 4: CTE to filter stocks with a 'Hold' rating
HoldRatings AS (
    SELECT stock_id, analyst_name, rating, rating_date
    FROM LatestRatings
    WHERE rating = 'Hold'
),

-- Step 5: CTE to filter stocks with a 'Sell' rating
SellRatings AS (
    SELECT stock_id, analyst_name, rating, rating_date
    FROM LatestRatings
    WHERE rating = 'Sell'
),

-- Step 6: CTE to get the total number of ratings for each stock
TotalRatings AS (
    SELECT stock_id, COUNT(rating_id) AS total_ratings
    FROM AnalystRatings
    GROUP BY stock_id
),

-- Step 7: Final result that combines data from all CTEs to give an overview of ratings
FinalRatingsOverview AS (
    SELECT
        sr.stock_id,
        COUNT(DISTINCT br.stock_id) AS buy_count,
        COUNT(DISTINCT hr.stock_id) AS hold_count,
        COUNT(DISTINCT sr.stock_id) AS sell_count,
        tr.total_ratings
    FROM SellRatings sr
    LEFT JOIN BuyRatings br ON sr.stock_id = br.stock_id
    LEFT JOIN HoldRatings hr ON sr.stock_id = hr.stock_id
    JOIN TotalRatings tr ON sr.stock_id = tr.stock_id
    GROUP BY sr.stock_id, tr.total_ratings
)

-- Step 8: Select the final output from the overview
SELECT * FROM FinalRatingsOverview;

-- table 18 
	-- Step 1: Define the CTE to get messages between users with date filtering
WITH CTE_MessageDates AS (
    SELECT message_id, sender_id, receiver_id, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-06-30'  -- Filtering messages sent in the first half of 2023
)

-- Step 2: Get user information by joining the CTE with the Users table for sender details
, CTE_UserDetails AS (
    SELECT m.message_id, m.sender_id, m.receiver_id, m.sent_date, u.name AS sender_name
    FROM CTE_MessageDates m
    JOIN Users u ON m.sender_id = u.user_id  -- Assuming 'Users' table has a 'name' column
)

-- Step 3: Get receiver details from Users table by joining with the previous CTE
, CTE_ReceiverDetails AS (
    SELECT m.message_id, m.sender_id, m.receiver_id, m.sent_date, m.sender_name, u.name AS receiver_name
    FROM CTE_UserDetails m
    JOIN Users u ON m.receiver_id = u.user_id  -- Assuming 'Users' table has a 'name' column
)

-- Step 4: Calculate the number of messages sent by each sender in the filtered period
, CTE_MessageCount AS (
    SELECT sender_id, COUNT(*) AS message_count
    FROM CTE_ReceiverDetails
    GROUP BY sender_id  -- Grouping by sender to count their messages
)

-- Step 5: Get the names of senders and their respective message counts from CTE_MessageCount
, CTE_SenderMessageCounts AS (
    SELECT m.sender_name, c.message_count
    FROM CTE_MessageCount c
    JOIN CTE_UserDetails m ON c.sender_id = m.sender_id
)

-- Step 6: Filter the senders who sent more than 3 messages in the first half of 2023
, CTE_FilteredSenders AS (
    SELECT sender_name, message_count
    FROM CTE_SenderMessageCounts
    WHERE message_count > 3  -- Only include senders with more than 3 messages
)

-- Step 7: Final result: List senders with their message count
SELECT * 
FROM CTE_FilteredSenders
ORDER BY message_count asc;  -- Ordering senders by message count in descending order

-- table 18 
-- Step 1: Define the CTE to fetch messages that were sent in 2023.
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)

-- Step 2: Select messages from the CTE
SELECT * 
FROM MessagesIn2023;

-- Step 3: Calculate the total number of messages sent in 2023
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT COUNT(*) AS TotalMessagesIn2023
FROM MessagesIn2023;

-- Step 4: Retrieve messages where the sender is from user 100001 or user 100002
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT * 
FROM MessagesIn2023
WHERE sender_id IN (100001, 100002);

-- Step 5: Rank messages sent by users and order by the most recent message
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)
, RankedMessages AS (
    SELECT 
        message_id,
        sender_id,
        receiver_id,
        message_text,
        sent_date,
        ROW_NUMBER() OVER (ORDER BY sent_date DESC) AS Rank
    FROM MessagesIn2023
)
SELECT * 
FROM RankedMessages
WHERE Rank <= 5;

-- Step 6: Get messages between two specific users (e.g., 100001 and 100005) within 2023
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)
SELECT * 
FROM MessagesIn2023
WHERE (sender_id = 100001 AND receiver_id = 100005)
   OR (sender_id = 100005 AND receiver_id = 100001);

-- Step 7: Retrieve the first message sent by each user in 2023
WITH MessagesIn2023 AS (
    SELECT message_id, sender_id, receiver_id, message_text, sent_date
    FROM UserMessages
    WHERE sent_date BETWEEN '2023-01-01' AND '2023-12-31'
)
, FirstMessages AS (
    SELECT 
        sender_id,
        MIN(sent_date) AS FirstMessageDate
    FROM MessagesIn2023
    GROUP BY sender_id
)
SELECT m.sender_id, m.message_text, m.sent_date
FROM MessagesIn2023 m
JOIN FirstMessages fm ON m.sender_id = fm.sender_id AND m.sent_date = fm.FirstMessageDate;

-- table 19
-- Step 1: Declare the CTE to calculate average trade fees
WITH FeeCalculations AS (
    -- Step 2: Select broker_id and trade_fee, including only the relevant date range
    SELECT broker_id, trade_fee, created_at
    FROM Fees
    WHERE created_at BETWEEN '2023-01-01' AND '2023-06-30'
),
-- Step 3: Calculate the average trade_fee per broker using the CTE data
AverageFees AS (
    SELECT broker_id, AVG(trade_fee) AS avg_trade_fee
    FROM FeeCalculations
    GROUP BY broker_id
),
-- Step 4: Filter brokers with average fees greater than a certain threshold
HighFeeBrokers AS (
    SELECT broker_id, avg_trade_fee
    FROM AverageFees
    WHERE avg_trade_fee > 15.00
),
-- Step 5: Calculate the count of brokers with high fees
BrokerCount AS (
    SELECT COUNT(*) AS high_fee_broker_count
    FROM HighFeeBrokers
),
-- Step 6: Select details about brokers with high fees and join with the BrokerCount CTE
FinalResults AS (
    SELECT hfb.broker_id, hfb.avg_trade_fee, bc.high_fee_broker_count
    FROM HighFeeBrokers hfb
    CROSS JOIN BrokerCount bc
)
-- Step 7: Final output displaying brokers with high fees and the count of such brokers
SELECT * FROM FinalResults;

-- table 20 
-- Step 1: Define a CTE (Common Table Expression) to filter relevant data from the MarketNews table.
WITH MarketGrowthCTE AS (
    -- Select news articles that mention market growth and have a publication date after 2024-10-01.
    SELECT news_id, headline, published_date
    FROM MarketNews
    WHERE body LIKE '%growth%' AND published_date > '2024-10-01'
),

-- Step 2: Define another CTE to filter out articles related to economic stability.
EconomicStabilityCTE AS (
    -- Select news articles with keywords related to economic stability.
    SELECT news_id, headline, published_date
    FROM MarketNews
    WHERE body LIKE '%economic stability%' AND published_date > '2024-10-02'
),

-- Step 3: Combine the results of both CTEs into a final result set.
CombinedCTE AS (
    -- Union the results of MarketGrowthCTE and EconomicStabilityCTE
    SELECT news_id, headline, published_date
    FROM MarketGrowthCTE
    UNION
    SELECT news_id, headline, published_date
    FROM EconomicStabilityCTE
),

-- Step 4: Sort the combined results by published date.
SortedNewsCTE AS (
    -- Order the combined news articles by the date they were published, from newest to oldest.
    SELECT news_id, headline, published_date
    FROM CombinedCTE
    ORDER BY published_date DESC
),

-- Step 5: Select the top 5 latest news articles.
Top5LatestNews AS (
    -- Retrieve the top 5 most recent news articles from the sorted list.
    SELECT TOP 5 news_id, headline, published_date
    FROM SortedNewsCTE
),

-- Step 6: Final step to select and display the top 5 news articles.
FinalResult AS (
    -- Show the final result of the top 5 latest news articles with their details.
    SELECT news_id, headline, published_date
    FROM Top5LatestNews
)

-- Step 7: Return the result of the final CTE
SELECT * FROM FinalResult;

-- Another Example: Query to get all articles related to inflation trends.
WITH InflationTrendsCTE AS (
    -- Select articles mentioning inflation trends
    SELECT news_id, headline, published_date
    FROM MarketNews
    WHERE body LIKE '%inflation%' AND published_date > '2024-10-01'
)
-- Display all the articles related to inflation trends
SELECT * FROM InflationTrendsCTE;

-- DCL 
-- TABLE 1 
-- Create a new role for managing database users
CREATE ROLE db_user_role;

-- Grant SELECT privilege on Users table to db_user_role, allowing users with this role to read the table
GRANT SELECT ON Users TO db_user_role;

-- Grant INSERT privilege on Users table to db_user_role, allowing users with this role to add new rows
GRANT INSERT ON Users TO db_user_role;

-- Grant UPDATE privilege on Users table to db_user_role, allowing users with this role to modify existing rows
GRANT UPDATE ON Users TO db_user_role;

-- Create a new user and assign the db_user_role to provide specific privileges
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'securePassword';
GRANT db_user_role TO 'user1'@'localhost';

-- Revoke the INSERT privilege from db_user_role, preventing further data insertions by role members
REVOKE INSERT ON Users FROM db_user_role;

-- Drop the db_user_role if it is no longer needed, removing any privileges associated with it
DROP ROLE db_user_role;

-- TABLE 2 

-- Step 1: Create a user for managing Brokers table
CREATE USER 'broker_manager'@'localhost' IDENTIFIED BY 'password123';
-- Creates a new user `broker_manager` with a password for access control.

-- Step 2: Grant SELECT permission to broker_manager
GRANT SELECT ON Brokers TO 'broker_manager'@'localhost';
-- Allows `broker_manager` to read data from the `Brokers` table.

-- Step 3: Grant INSERT permission to broker_manager
GRANT INSERT ON Brokers TO 'broker_manager'@'localhost';
-- Allows `broker_manager` to add new records to the `Brokers` table.

-- Step 4: Grant UPDATE permission to broker_manager
GRANT UPDATE ON Brokers TO 'broker_manager'@'localhost';
-- Allows `broker_manager` to modify existing records in the `Brokers` table.

-- Step 5: Grant DELETE permission to broker_manager
GRANT DELETE ON Brokers TO 'broker_manager'@'localhost';
-- Allows `broker_manager` to delete records from the `Brokers` table.

-- Step 6: Revoke DELETE permission from broker_manager
REVOKE DELETE ON Brokers FROM 'broker_manager'@'localhost';
-- Removes DELETE permissions from `broker_manager` to restrict them from deleting records.

-- Step 7: Verify permissions for broker_manager
SHOW GRANTS FOR 'broker_manager'@'localhost';
-- Displays the current privileges for `broker_manager` to confirm permission changes.


-- TABLE 3 
-- Create a new user called 'FinanceAdmin' with a secure password for full control over the database.
CREATE USER 'FinanceAdmin' IDENTIFIED BY 'SecurePassword123!';

-- Grant all privileges to 'FinanceAdmin' on the 'Accounts' table for full read, write, and modification access.
GRANT ALL PRIVILEGES ON Accounts TO 'FinanceAdmin';

-- Create a new user called 'FinanceReadOnly' with a secure password for read-only access.
CREATE USER 'FinanceReadOnly' IDENTIFIED BY 'ReadOnlyPassword!';

-- Grant SELECT permission to 'FinanceReadOnly' on the 'Accounts' table for read-only access.
GRANT SELECT ON Accounts TO 'FinanceAdmin';

-- Grant SELECT on only specific columns (account_id, account_balance) to a user for limited access.
GRANT SELECT (account_id, account_balance) ON Accounts TO 'FinanceAdmin';

-- Drop the user 'FinanceTemporary' who no longer needs access to the database.
DROP USER 'FinanceTemporary';


-- TABLE 4 
-- Step 1: Create a new database user who can access the Stocks table.
CREATE USER 'stock_user'@'localhost' IDENTIFIED BY 'password123';
-- This creates a new user called 'stock_user' who can connect from 'localhost'.

-- Step 2: Grant SELECT privileges to allow the user to read data from the Stocks table.
GRANT SELECT ON Stocks TO 'stock_user'@'localhost';
-- This grants read-only access to the Stocks table for 'stock_user'.

-- Step 3: Allow the user to update the current_price column in the Stocks table.
GRANT UPDATE (current_price) ON Stocks TO 'stock_user'@'localhost';
-- This allows 'stock_user' to update only the 'current_price' column, keeping other data secure.

-- Step 4: Allow the user to insert new records into the Stocks table.
GRANT INSERT ON Stocks TO 'stock_user'@'localhost';
-- This permission allows 'stock_user' to add new stocks to the Stocks table.

-- Step 5: Grant the user permission to delete records from the Stocks table.
GRANT DELETE ON Stocks TO 'stock_user'@'localhost';
-- This allows 'stock_user' to delete records from the Stocks table, if needed.

-- Step 6: Revoke the DELETE privilege if the user no longer needs it.
REVOKE DELETE ON Stocks FROM 'stock_user'@'localhost';
-- This removes the DELETE privilege, so 'stock_user' can no longer delete records.

DROP USER '';
 
 -- TABLE 5 
 -- Step 1: Create a user who will be granted permissions to interact with the Transactions table.
CREATE USER trade_user IDENTIFIED BY 'securepassword';
-- This creates a new user 'trade_user' with a password 'securepassword'.

-- Step 2: Grant SELECT permission on the Transactions table to the user.
GRANT SELECT ON Transactions TO trade_user;
-- This allows 'trade_user' to view data in the Transactions table.

-- Step 3: Grant INSERT permission on the Transactions table to the user.
GRANT INSERT ON Transactions TO trade_user;
-- This allows 'trade_user' to insert new records into the Transactions table.

-- Step 4: Grant UPDATE permission on the Transactions table to the user.
GRANT UPDATE ON Transactions TO trade_user;
-- This allows 'trade_user' to modify existing records in the Transactions table.

-- Step 5: Grant DELETE permission on the Transactions table to the user.
GRANT DELETE ON Transactions TO trade_user;
-- This allows 'trade_user' to delete records from the Transactions table.

-- Step 6: Revoke DELETE permission from the user if it’s deemed unnecessary later.
REVOKE DELETE ON Transactions FROM trade_user;
-- This removes the delete permission for 'trade_user' from the Transactions table.

-- Step 7: Drop the user if they no longer need access to the database.
DROP USER trade_user;
-- This completely removes 'trade_user' from the database.

-- TABLE 5 
-- Step 1: Create a new user called 'user_orders'
CREATE USER 'user_orders'@'localhost' IDENTIFIED BY 'password123';

-- Step 2: Grant SELECT privilege on Orders table to 'user_orders'
GRANT SELECT ON Orders TO 'user_orders'@'localhost';

-- Step 3: Grant INSERT privilege on Orders table to 'user_orders'
GRANT INSERT ON Orders TO 'user_orders'@'localhost';

-- Step 4: Grant UPDATE privilege on Orders table to 'user_orders'
GRANT UPDATE ON Orders TO 'user_orders'@'localhost';

-- Step 5: Grant DELETE privilege on Orders table to 'user_orders'
GRANT DELETE ON Orders TO 'user_orders'@'localhost';

-- Step 6: Grant ALL privileges on Orders table to 'admin_user'
GRANT ALL PRIVILEGES ON Orders TO 'admin_user'@'localhost';

-- Step 7: Revoke DELETE privilege from 'user_orders'
REVOKE DELETE ON Orders FROM 'user_orders'@'localhost';


-- TABLE 7
-- Step 1: Create a new user
-- This step creates a new user named 'dividend_user' with a specified password.
CREATE USER 'dividend_user'@'localhost' IDENTIFIED BY 'password123';

-- Step 2: Grant SELECT privileges on the Dividends table
-- This grants the 'dividend_user' the ability to read data from the Dividends table.
GRANT SELECT ON Dividends TO 'dividend_user'@'localhost';

-- Step 3: Grant INSERT privileges on the Dividends table
-- This grants the 'dividend_user' the ability to insert new rows into the Dividends table.
GRANT INSERT ON Dividends TO 'dividend_user'@'localhost';

-- Step 4: Grant UPDATE privileges on the Dividends table
-- This grants the 'dividend_user' the ability to modify existing rows in the Dividends table.
GRANT UPDATE ON Dividends TO 'dividend_user'@'localhost';

-- Step 5: Grant DELETE privileges on the Dividends table
-- This grants the 'dividend_user' the ability to delete rows from the Dividends table.
GRANT DELETE ON Dividends TO 'dividend_user'@'localhost';

-- Step 6: Grant ALL privileges on the Dividends table
-- This grants full administrative rights on the Dividends table (SELECT, INSERT, UPDATE, DELETE).
GRANT ALL PRIVILEGES ON Dividends TO 'dividend_user'@'localhost';

-- Step 7: Revoke specific privileges from the Dividends table
-- This step revokes the DELETE privilege from the 'dividend_user', so they can no longer delete records.
REVOKE DELETE ON Dividends FROM 'dividend_user'@'localhost';

-- TABLE 8
-- Step 1: Create a role called 'portfolio_manager'
-- This role will be used to assign permissions for managing portfolios.
CREATE ROLE portfolio_manager;

-- Step 2: Grant SELECT permission on Portfolios to the 'portfolio_manager' role
-- This allows the users assigned this role to view the portfolio details.
GRANT SELECT ON Portfolios TO portfolio_manager;

-- Step 3: Grant INSERT permission on Portfolios to the 'portfolio_manager' role
-- This allows users to add new records into the Portfolios table.
GRANT INSERT ON Portfolios TO portfolio_manager;

-- Step 4: Grant UPDATE permission on Portfolios to the 'portfolio_manager' role
-- This allows users to modify the quantity of stocks in portfolios.
GRANT UPDATE ON Portfolios TO portfolio_manager;

-- Step 5: Grant DELETE permission on Portfolios to the 'portfolio_manager' role
-- This allows users to remove records from the Portfolios table.
GRANT DELETE ON Portfolios TO portfolio_manager;

-- Step 6: Create a new user and assign the 'portfolio_manager' role to the user
-- Replace 'username' and 'password' with the actual username and password you want to set.
CREATE USER 'username' IDENTIFIED BY 'password';
GRANT portfolio_manager TO 'username';

-- Step 7: Revoke INSERT permission on Portfolios from the 'portfolio_manager' role
-- This prevents users assigned to this role from adding new records to the Portfolios table.
REVOKE INSERT ON Portfolios FROM portfolio_manager;


-- TABLE 9 
-- TANLE 10 

-- Creating a user named 'john_doe'
CREATE USER john_doe IDENTIFIED BY 'password123';

-- Granting select permission on 'Exchanges' table to 'john_doe'
GRANT SELECT ON Exchanges TO john_doe;

-- Granting insert and update permissions on 'Exchanges' table to 'john_doe'
GRANT INSERT, UPDATE ON Exchanges TO john_doe;

-- Granting all privileges on 'Exchanges' table to 'admin'
GRANT ALL PRIVILEGES ON Exchanges TO admin;

-- Revoking select permission on 'Exchanges' table from 'john_doe'
REVOKE SELECT ON Exchanges FROM john_doe;

-- Revoking all privileges on 'Exchanges' table from 'admin'
REVOKE ALL PRIVILEGES ON Exchanges FROM admin;


-- TABLE 12 
-- Step 1: Create a new user
CREATE USER 'market_user'@'localhost' IDENTIFIED BY 'password123';

-- Step 2: Grant SELECT privilege to the user
GRANT SELECT ON MarketHistory TO 'market_user'@'localhost';

-- Step 3: Grant INSERT privilege to the user
GRANT INSERT ON MarketHistory TO 'market_user'@'localhost';

-- Step 4: Grant UPDATE privilege to the user
GRANT UPDATE ON MarketHistory TO 'market_user'@'localhost';

-- Step 5: Grant DELETE privilege to the user
GRANT DELETE ON MarketHistory TO 'market_user'@'localhost';

-- Step 6: Revoke SELECT privilege from the user
REVOKE SELECT ON MarketHistory FROM 'market_user'@'localhost';

-- Step 7: Grant ALL privileges to the user
GRANT ALL PRIVILEGES ON MarketHistory TO 'market_user'@'localhost';

-- Apply changes to privileges
FLUSH PRIVILEGES;

-- TABLE 13 
-- TABLE 14 
-- Step 1: Create a user (replace 'username' and 'password' with actual values)
CREATE USER 'username'@'localhost' IDENTIFIED BY 'password';

-- Step 2: Grant SELECT privilege on Company table to the user
GRANT SELECT ON Company TO 'username'@'localhost';

-- Step 3: Grant INSERT privilege on Company table to the user
GRANT INSERT ON Company TO 'username'@'localhost';

-- Step 4: Grant UPDATE privilege on Company table to the user
GRANT UPDATE ON Company TO 'username'@'localhost';

-- Step 5: Grant DELETE privilege on Company table to the user
GRANT DELETE ON Company TO 'username'@'localhost';

-- Step 6: Grant REFERENCES privilege to the user for foreign key constraints
GRANT REFERENCES ON Stocks TO 'username'@'localhost';

-- Step 7: Revoke a privilege from the user (example for SELECT)
REVOKE SELECT ON Company FROM 'username'@'localhost';


-- TABLE 16 
-- Step 1: Create a new user with a specified username and password
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password123';

-- Step 2: Grant access to the database (example: 'my_database')
GRANT ALL PRIVILEGES ON STOCK_MARKET.* TO 'new_user'@'localhost';

-- Step 3: Grant specific permissions on the IPO table
GRANT SELECT, INSERT, UPDATE, DELETE ON STOCK_MARKET.IPO TO 'new_user'@'localhost';

-- Step 4: Optionally grant administrative privileges (e.g., for backups)
GRANT BACKUP_ADMIN ON *.* TO 'new_user'@'localhost';

-- Step 5: Optionally, create a role to group permissions
CREATE ROLE 'ipo_admin_role';

-- Step 6: Assign the role to the user
GRANT 'ipo_admin_role' TO 'new_user'@'localhost';


-- TABLE 17 
-- Step 1: Create the user
CREATE USER 'analyst_user'@'localhost' IDENTIFIED BY 'password';
-- This creates a new user 'analyst_user' with a password 'password' for local access

-- Step 2: Grant SELECT privilege on AnalystRatings table to analyst_user
GRANT SELECT ON AnalystRatings TO 'analyst_user'@'localhost';
-- This grants read-only access to the AnalystRatings table for querying

-- Step 3: Grant INSERT privilege on AnalystRatings table to analyst_user
GRANT INSERT ON AnalystRatings TO 'analyst_user'@'localhost';
-- This allows the user to insert new records into the AnalystRatings table

-- Step 4: Grant USAGE privilege to the user (optional if not already granted)
GRANT USAGE ON *.* TO 'analyst_user'@'localhost';
-- This grants the user the ability to access the database server itself

-- Step 5: Grant ALTER privilege (optional, if needed)
GRANT ALTER ON AnalystRatings TO 'analyst_user'@'localhost';
-- This allows the user to modify the structure of the AnalystRatings table (if necessary)

-- Step 6: Grant DELETE privilege (optional)
GRANT DELETE ON AnalystRatings TO 'analyst_user'@'localhost';
-- This grants the user the ability to delete rows from AnalystRatings

-- TABLE 18 
-- TABLE 19 
-- TABLE 20 


-- TCL 
-- TABLE 1 
-- Starting the transaction
START TRANSACTION;

-- Inserting data into Users table
INSERT INTO Users (user_id, name, email, password, created_at)
VALUES (100012, 'SUMIT KALYAN', 'SUMIT KALYANI@example.com', 'password112', '2023-11-23');

-- Set a savepoint to roll back to in case of an issue
SAVEPOINT before_error;

-- Inserting another row
INSERT INTO Users (user_id, name, email, password, created_at)
VALUES (100013, 'KUSHAVAHA SANJAY', 'KHUSH.SANJAY@example.com', 'password223', '2023-1-24');

-- An issue occurs (could be any failure, or business logic error)
-- ROLLBACK to the SAVEPOINT 'before_error', undoing the second insert
ROLLBACK TO SAVEPOINT before_error;

-- If no error occurs, commit the changes
COMMIT;



SELECT  * FROM USERS ;

-- TABLE 2 
-- Start a new transaction
START TRANSACTION;

-- Savepoint to mark a point in the transaction
SAVEPOINT before_insert;

-- Insert a new broker record (assuming this is an operation you want to manage in a transaction)
INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number)
VALUES (200012, 'Motilal Oswal', 'contact@motilaloswal.com', '9876543220');


-- Commit the transaction if everything is successful
COMMIT;

SELECT * FROM Brokers ;

-- TABLE 3 
-- Start a new transaction
START TRANSACTION;

-- Savepoint allows you to roll back to this point if needed
SAVEPOINT before_account_update;

-- Example of a query that might update a user's account balance
UPDATE Accounts
SET account_balance = account_balance + 5000
WHERE account_id = 300001;


-- If everything is correct and you want to commit the transaction:
COMMIT;


-- TABLE 4 
-- Start a new transaction
START TRANSACTION;

-- Set a SAVEPOINT to mark a point to which we can rollback
SAVEPOINT before_insert;

-- Example of an insert statement
INSERT INTO Stocks (stock_id, stock_symbol, stock_name, current_price, exchange)
VALUES (400011, 'HDFC', 'HDFC Ltd', 2550.00, 'NSE');

-- Example of a second insert
INSERT INTO Stocks (stock_id, stock_symbol, stock_name, current_price, exchange)
VALUES (400012, 'TATAMOTORS', 'Tata Motors', 450.00, 'BSE');


-- If there was an error and we want to undo the last insert
-- ROLLBACK to the SAVEPOINT (before_insert)
ROLLBACK TO before_insert;

-- After rollback, we can COMMIT if we are satisfied with the state
COMMIT;

SELECT * FROM Stocks  ;


-- TABLE 5 
-- Start a new transaction
START TRANSACTION;

-- Insert a new record into the Transactions table
INSERT INTO Transactions (transaction_id, account_id, stock_id, transaction_type, quantity, price_per_stock, transaction_date)
VALUES (500011, 300008, 400008, 'BUY', 20, 2950.25, '2023-11-12');

-- Create a savepoint
SAVEPOINT before_rollback;
-- Let's say there's an issue, and we want to roll back to the savepoint
-- ROLLBACK to the savepoint, undoing the insert
ROLLBACK TO SAVEPOINT before_rollback;

-- You can also rollback the entire transaction if needed
-- ROLLBACK;

-- Commit the transaction if everything is correct
COMMIT;

-- TABLE 6 
START TRANSACTION;

-- Example of inserting a new order
INSERT INTO Orders (order_id, account_id, stock_id, order_type, quantity, price, order_date, status)
VALUES (600011, 300009, 400009, 'BUY', 10, 5000.00, '2023-11-12', 'Pending');

-- Set a savepoint before performing another operation
SAVEPOINT before_update;

-- Example of updating an order (possibly an erroneous operation)
UPDATE Orders
SET price = 4500.00
WHERE order_id = 600009;

-- If an error occurs or something goes wrong, we can rollback to the savepoint
ROLLBACK TO SAVEPOINT before_update;

-- Commit the transaction if everything is correct
COMMIT;

-- TABLE 7 
-- Start a new transaction
START TRANSACTION;

-- Set a savepoint after an insert operation
INSERT INTO Dividends (dividend_id, stock_id, dividend_amount, dividend_date)
VALUES (700011, 400005, 55.00, '2023-11-30');

SAVEPOINT dividend_insert_savepoint;

-- Insert another row into Dividends
INSERT INTO Dividends (dividend_id, stock_id, dividend_amount, dividend_date)
VALUES (700012, 400006, 60.00, '2023-12-31');

-- Simulating an error or condition where we want to rollback
-- For example, let's assume we decide to rollback to the savepoint because the second insert is not needed
ROLLBACK TO dividend_insert_savepoint;

-- Commit the transaction if everything is correct
COMMIT;

-- TABLE 8 
START TRANSACTION;

SAVEPOINT savepoint_name;

START TRANSACTION;
INSERT INTO Portfolios (portfolio_id, account_id, stock_id, quantity)
VALUES (800010, 300010, 400010, 10);
SAVEPOINT before_rollback;
UPDATE Portfolios SET quantity = 5 WHERE portfolio_id = 800001;
-- Rollback to savepoint without affecting the above insert statement
ROLLBACK TO SAVEPOINT before_rollback;
COMMIT;

-- TABLE 9
-- Start a new transaction
START TRANSACTION;

-- Insert data into the Watchlist table
INSERT INTO Watchlist (watchlist_id, user_id, stock_id, added_date)
VALUES (900011, 100011, 400009, '2023-11-13');

-- Create a savepoint to allow rolling back to this point
SAVEPOINT before_rollback;

-- Attempting an insert that might cause an error or issue
-- For example, inserting a stock_id that does not exist (assuming stock_id 400999 does not exist)
INSERT INTO Watchlist (watchlist_id, user_id, stock_id, added_date)
VALUES (900012, 100012, 400009, '2023-11-14');

-- If an error occurs, roll back to the savepoint (before_rollback)
ROLLBACK TO SAVEPOINT before_rollback;

-- If everything is okay, commit the transaction to make changes permanent
COMMIT;

-- TABLE 10 
START TRANSACTION;

-- Let's assume you want to make a change to an exchange name.
UPDATE Exchanges SET exchange_name = 'New National Stock Exchange' WHERE exchange_id = 600001;

-- Create a savepoint
SAVEPOINT before_rollback;

-- Let's assume something goes wrong, so you rollback to the savepoint
ROLLBACK TO before_rollback;

-- If everything is fine, commit the transaction to make it permanent
COMMIT;

-- TABLE 11 
-- TABLE 12 
-- Start a new transaction
START TRANSACTION;

-- Insert some new data into MarketHistory table
INSERT INTO MarketHistory (history_id, stock_id, price, date)
VALUES (700011, 400011, 1500.00, '2023-11-12');

-- Create a SAVEPOINT
SAVEPOINT before_update;

-- Attempt to update data
UPDATE MarketHistory
SET price = 3500.00
WHERE history_id = 700001;


-- If everything goes well, we COMMIT the transaction
COMMIT;

-- TABLE 13 
-- Start a new transaction
START TRANSACTION;

-- Insert some data into the StockSectors table
INSERT INTO StockSectors (sector_id, sector_name)
VALUES (800011, 'Aerospace');

-- Set a savepoint after the first insert
SAVEPOINT before_update;

-- Let's update a record (assuming sector_id 800002 exists)
UPDATE StockSectors
SET sector_name = 'Financial Services'
WHERE sector_id = 800002;

-- If the update doesn't work or you want to revert to the previous state
ROLLBACK TO before_update;

-- If everything is fine, commit the transaction
COMMIT;


-- TABLE 15 
-- Start a transaction
START TRANSACTION;

-- Create a savepoint to allow partial rollback if needed
SAVEPOINT before_insert;

-- Try inserting a new record into the Company table
INSERT INTO Company (company_id, company_name, stock_id, headquarters)
VALUES (900011, 'Hindustan Unilever', 400011, 'Mumbai, India');

-- Check if the insert operation is successful (this could be done using a condition or error handling in the actual system)
-- If everything is good, commit the transaction
COMMIT;

-- TABLE 16 
-- Start a transaction
START TRANSACTION;

-- Set a savepoint before performing any operations
SAVEPOINT before_insert;

-- Example: Inserting a new IPO record (this is just an example, you can change it)
INSERT INTO IPO (ipo_id, stock_id, issue_price, issue_date, shares_issued)
VALUES (1000011, 400011, 1100.00, '2023-11-20', 1500000);

-- If everything works fine, commit the transaction
COMMIT;

-- TABLE 17 
START TRANSACTION;

SAVEPOINT savepoint_name;

ROLLBACK TO SAVEPOINT savepoint_name;
-- Or rollback the entire transaction
ROLLBACK;

COMMIT;


START TRANSACTION;

-- Try to insert a new rating for a stock
INSERT INTO AnalystRatings (rating_id, stock_id, analyst_name, rating, rating_date)
VALUES (1100011, 400011, 'Maya Shah', 'Buy', '2023-11-13');

-- Set a savepoint in case we need to roll back only part of the transaction
SAVEPOINT before_update;

-- Try to update a rating for a stock
UPDATE AnalystRatings
SET rating = 'Hold'
WHERE rating_id = 1100001;

-- If everything looks good, commit the transaction
COMMIT;

-- TABLE 18 
-- Begin a new transaction
START TRANSACTION;

-- Perform some operations on the UserMessages table
INSERT INTO UserMessages (message_id, sender_id, receiver_id, message_text, sent_date)
VALUES (1200011, 100011, 100012, 'Ananya, let’s talk about the new market trends.', '2023-11-12');

-- Set a savepoint to which you can roll back later if needed
SAVEPOINT before_error;

-- Simulate an error or check some condition before proceeding (can be customized based on application logic)
-- If some condition fails, rollback to the savepoint
ROLLBACK TO SAVEPOINT before_error;

-- If everything is fine, commit the transaction to make the changes permanent
COMMIT;

-- TABLE 19 
-- Start a new transaction
START TRANSACTION;

-- Create a savepoint (this allows us to roll back to this point if needed)
SAVEPOINT before_update;

-- Insert a new record in the Fees table (this is an example action within the transaction)
INSERT INTO Fees (fee_id, broker_id, trade_fee, created_at)
VALUES (1300011, 200011, 17.00, '2023-11-13');

-- Update a record in the Fees table (example action)
UPDATE Fees
SET trade_fee = 19.50
WHERE fee_id = 1300001;

-- If we detect an issue or decide to roll back to the savepoint
-- We can roll back to the 'before_update' savepoint without affecting earlier changes
ROLLBACK TO SAVEPOINT before_update;

-- If everything is good and we want to commit the changes (permanently save them)
COMMIT;

-- TABLE 20 
-- Start a new transaction
START TRANSACTION;

-- Insert some data into the MarketNews table
INSERT INTO MarketNews (news_id, headline, body, published_date)
VALUES (2345678, 'Rajeev Sharma Launches New Economic Model', 'Rajeev Sharma introduces a new economic model that aims to boost the middle class in India.', '2024-10-11');

-- Savepoint is a marker within a transaction to which you can roll back if needed
SAVEPOINT before_rollback;

-- Perform another insert or update if needed
INSERT INTO MarketNews (news_id, headline, body, published_date)
VALUES (2345679, 'Priya Mehta Evaluates Market Risks', 'Priya Mehta evaluates the potential risks facing investors in the market during 2024.', '2024-10-12');

-- If something goes wrong, you can rollback to the savepoint instead of rolling back the entire transaction
-- For example, let's assume there was an issue with the second insert
ROLLBACK TO before_rollback;

-- After resolving the issue, you can commit the transaction to save the changes
COMMIT;

-- Or if everything fails and you want to undo all changes
ROLLBACK; -- This will undo all the changes made since START TRANSACTION

SELECT * from watchlist ;


-- store procedure 

DELIMITER //

-- Create a stored procedure to fetch user details by email
CREATE PROCEDURE GetUserDetailsByEmail (IN user_email VARCHAR(100))
BEGIN
    -- Select user details from the Users table based on the passed email
    SELECT user_id, name, email, created_at
    FROM Users
    WHERE email = user_email;
END //

DELIMITER ;

CALL GetUserDetailsByEmail('amit.sharma@example.com');


-- table 2 
DELIMITER //

CREATE PROCEDURE GetBrokersInfo()
BEGIN
    -- This query retrieves all the broker details from the Brokers table
    SELECT * FROM Brokers;
END //

DELIMITER ;

CALL GetBrokersInfo();

-- table 3 
DELIMITER //

CREATE PROCEDURE GetAccountDetails()
BEGIN
    -- This query selects all account details, including account ID, user ID, broker ID, account balance, and creation date
    SELECT 
        account_id, user_id,  broker_id,  account_balance, created_at 
    FROM Accounts;
END //

DELIMITER ;

CALL GetAccountDetails();

-- table 4 
select * from stocks ;

ALTER TABLE Stocks
ADD COLUMN market_cap DECIMAL(15, 2);

-- Step 1: Create the stored procedure
DELIMITER //

CREATE PROCEDURE UpdateMarketCap()
BEGIN
    -- Update market_cap values for each stock_id
      UPDATE Stocks SET market_cap = 1009875678.90 WHERE stock_id = 400011;
    UPDATE Stocks SET market_cap = 1012989878.90 WHERE stock_id = 400012;
  
END //

DELIMITER ;

-- Step 2: Call the procedure to execute the updates
CALL UpdateMarketCap();

-- Step 1: Create the stored procedure
DELIMITER //

CREATE PROCEDURE UpdateMarketCap1()
BEGIN
    -- Update market_cap values for each stock_id
     UPDATE Stocks SET stock_sector = 'finance' WHERE stock_id = 400011;
     UPDATE Stocks SET stock_sector = 'it' WHERE stock_id = 400012;
     UPDATE Stocks SET sector = 'banking'  WHERE stock_id = 400011;
     UPDATE Stocks SET sector = 'it services' WHERE stock_id = 400012;
END //
DELIMITER ;
-- Step 2: Call the procedure to execute the updates
CALL UpdateMarketCap1();

-- table 5 

select * from Transactions  ;
-- table 5
delimiter //
create PROCEDURE updateTransactions()
begin 
update transactions set transaction_fee = 500 where Transaction_id = 500011 ;
update transactions set account_id = 300011 where Transaction_id = 500011 ;
update transactions set stock_id= 400011 where Transaction_id = 500011 ;

end //
delimiter ;

call updateTransactions() ;

-- table 6 
select * from orders ;
delimiter //
create procedure ordersuser()
begin
update orders set account_id = 300011 where order_id = 600011 ;
update orders set stock_id = 400011 where order_id = 600011 ;
update orders set status = 'Execute' where order_id = 600011 ;
update orders set commission = 5.09 where order_id = 600010 ; 
update orders set commission = 50.00 where order_id = 600011 ;
end //
delimiter ;

call ordersuser() ;


-- table 7 
select * from Dividends ;

DELIMITER //

CREATE PROCEDURE GetDividendStatistics()
BEGIN
    SELECT 
		count(dividend_amount) AS maximum_dividend,
        SUM(dividend_amount) AS total_dividend,
        AVG(dividend_amount) AS average_dividend,
        MIN(dividend_amount) AS minimum_dividend,
        MAX(dividend_amount) AS maximum_dividend
        
    FROM Dividends;
END //

DELIMITER ;

call GetDividendStatistics ;

-- table 8 
select * from Portfolios  ;

DELIMITER //

CREATE PROCEDURE GetPortfoliosByMinQuantity(IN min_quantity INT)
BEGIN
    SELECT *
    FROM Portfolios
    WHERE account_id IN (
        SELECT account_id
        FROM Portfolios
        WHERE quantity >= min_quantity
    );
END //

DELIMITER ;

CALL GetPortfoliosByMinQuantity(10);


-- table 9
DELIMITER //

CREATE PROCEDURE GetWatchlistByUser(IN in_user_id INT)
BEGIN
    SELECT * FROM Watchlist
    WHERE user_id = in_user_id;
END //

DELIMITER ;

CALL GetWatchlistByUser(100007);


-- table 10 
select * from Exchanges ;

DELIMITER //

CREATE PROCEDURE GetExchangesByCountry(IN input_country VARCHAR(50))
BEGIN
    SELECT exchange_id, exchange_name, country
    FROM Exchanges
    WHERE country = input_country;
END //

DELIMITER ;

CALL GetExchangesByCountry('india');

-- table 11 
select * from MarketHistory ;

DELIMITER //

CREATE PROCEDURE GetStocksAbovePrice(IN min_price DECIMAL(10, 2))
BEGIN
    SELECT *
    FROM MarketHistory
    WHERE price > min_price;
END //

DELIMITER ;

CALL GetStocksAbovePrice(1500.00);

-- table 13 
-- TABLE 14
-- TABLE 15 
SELECT * FROM company ;

DELIMITER //

CREATE PROCEDURE UpdateSECTORE()
BEGIN
    -- Update the headquarters for the specified company
    UPDATE Company
    SET SECTOR = 'CONGLOMERATE'
    WHERE company_id = 900011 ;
    END //

DELIMITER ;

CALL UpdateSECTORE ;

-- TABLE 16 
DELIMITER //

CREATE PROCEDURE GetIPOsAboveAverage()
BEGIN
    SELECT ipo_id, stock_id, issue_price, issue_date, shares_issued
    FROM IPO
    WHERE issue_price > (SELECT AVG(issue_price) FROM IPO);
END //

DELIMITER ;

CALL GetIPOsAboveAverage ;

-- TABLE 17 
DELIMITER //

CREATE PROCEDURE GetBuyRatings (IN stock_id_input INT)
BEGIN
    SELECT 
        analyst_name, 
        (SELECT rating FROM AnalystRatings WHERE stock_id = stock_id_input AND rating = 'Buy' LIMIT 1) AS rating,
        rating_date
    FROM AnalystRatings
    WHERE stock_id = stock_id_input AND rating = 'Buy';
END //

DELIMITER ;

CALL GetBuyRatings() ;

-- TABLE 18

DELIMITER //

CREATE PROCEDURE InsertUserMessage(
    IN p_sender_id INT,
    IN p_receiver_id INT,
    IN p_message_text TEXT,
    IN p_sent_date DATE
)
BEGIN
    DECLARE new_message_id INT;
    
    -- Generate new message ID (assuming auto-increment is not being used)
    SET new_message_id = (SELECT IFNULL(MAX(message_id), 0) + 1 FROM UserMessages);
    
    -- Insert the message into the UserMessages table
    INSERT INTO UserMessages (message_id, sender_id, receiver_id, message_text, sent_date)
    VALUES (new_message_id, p_sender_id, p_receiver_id, p_message_text, p_sent_date);
END //

DELIMITER ;

CALL InsertUserMessage(100001, 100002, 'Hello Priya, how are you?', '2023-01-20');

-- TABLE 19 
SELECT * FROM FEES  ;

DELIMITER //

CREATE PROCEDURE GetTradeFeeStats()
BEGIN
    -- Subquery to find the minimum trade_fee
    SELECT MIN(trade_fee) AS min_trade_fee
    FROM Fees;

    -- Subquery to find the maximum trade_fee
    SELECT MAX(trade_fee) AS max_trade_fee
    FROM Fees;

    -- Subquery to find the average trade_fee
    SELECT AVG(trade_fee) AS avg_trade_fee
    FROM Fees;

    -- Optional: Display all fees with brokers
    SELECT broker_id, trade_fee
    FROM Fees;

END //

DELIMITER ;

 CALL GetTradeFeeStats();

-- TABLE 20 
SELECT * FROM MarketNews ;

-- trigeer 

DELIMITER //

-- Create a BEFORE INSERT trigger for the Users table
CREATE TRIGGER before_users_insert 
BEFORE INSERT ON Users
FOR EACH ROW
BEGIN
    -- Ensure the name is in proper case
    SET NEW.name = CONCAT(UCASE(SUBSTRING(NEW.name, 1, 1)), LCASE(SUBSTRING(NEW.name, 2)));

    -- Ensure the email is in lowercase
    SET NEW.email = LOWER(NEW.email);
END //

DELIMITER ;

INSERT INTO Users (user_id, name, email, password, created_at)
VALUES (100013, 'sumitkalyan', 'sumitkalyan@EXAMPLE.COM', 'password12554', '2024-11-19');

-- Check the result
SELECT * FROM Users WHERE user_id = 100013;

-- table 2 
-- Create a log table to store details of inserted brokers
CREATE TABLE Broker_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY, 
    broker_id INT NOT NULL,              
    broker_name VARCHAR(100),         
    insert_time DATETIME                 
);

DELIMITER //

CREATE TRIGGER after_broker_insert1
AFTER INSERT ON Brokers
FOR EACH ROW
BEGIN
    -- Insert details into the Broker_Log table
    INSERT INTO Broker_Log (broker_id, broker_name, insert_time)
    VALUES (NEW.broker_id, NEW.broker_name, NOW());
END //

DELIMITER ;

-- Test the trigger by inserting a new broker
INSERT INTO Brokers (broker_id, broker_name, contact_email, phone_number)
VALUES (200014, 'Reliance Securities', 'info@reliancesecurities.com', '9876543920');



-- table 3 
DELIMITER //

CREATE TRIGGER before_account_insert
BEFORE INSERT ON Accounts
FOR EACH ROW
BEGIN
    -- Check if account balance is negative
    IF NEW.account_balance < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Account balance cannot be negative';
    END IF;
END //

DELIMITER ;

-- TABLE 4 
DELIMITER //

-- Create the trigger after inserting into the Stocks table
CREATE TRIGGER after_insert_stocks
AFTER INSERT
ON Stocks FOR EACH ROW
BEGIN
INSERT INTO Stock_Log (log_message, created_at)
    VALUES (CONCAT('Inserted stock: ', NEW.stock_symbol, ' - ', NEW.stock_name, ' at price ', NEW.current_price), NOW());
    END //

DELIMITER ;

-- TABLE 5 
DELIMITER //

-- Creating the AFTER INSERT trigger for the Transactions table
CREATE TRIGGER after_transaction_insert
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
IF NEW.transaction_type = 'BUY' THEN
UPDATE Accounts
        SET account_balance = account_balance - (NEW.quantity * NEW.price_per_stock)
        WHERE account_id = NEW.account_id;
    ELSEIF NEW.transaction_type = 'SELL' THEN
      UPDATE Accounts
        SET account_balance = account_balance + (NEW.quantity * NEW.price_per_stock)
        WHERE account_id = NEW.account_id;
    END IF;
    
    INSERT INTO TransactionLogs (transaction_id, account_id, transaction_type, quantity, transaction_date)
    VALUES (NEW.transaction_id, NEW.account_id, NEW.transaction_type, NEW.quantity, NEW.transaction_date);
    
    END //

DELIMITER ;

-- TABLE 6 
DELIMITER //

CREATE TRIGGER before_order_insert
BEFORE INSERT ON Orders
FOR EACH ROW
BEGIN
IF NEW.price <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Price must be greater than zero';
    END IF;
    
    IF NEW.quantity <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Quantity must be greater than zero';
    END IF;
END//
DELIMITER ;

-- TABLE 7 
-- Creating the BEFORE INSERT trigger

DELIMITER //

CREATE TRIGGER before_insert_dividends
BEFORE INSERT ON Dividends
FOR EACH ROW
BEGIN
    -- Check if the dividend amount is positive
    IF NEW.dividend_amount <= 0 THEN
        -- If not, signal an error with a custom message
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dividend amount must be positive';
    END IF;

    -- You can also add any other custom logic here, for example:
    -- Check if the dividend date is in the future
    IF NEW.dividend_date > CURDATE() THEN
        -- Signal an error if the date is in the future
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Dividend date cannot be in the future';
    END IF;
    
    END //

DELIMITER ;

-- TABLE 8 
	

DELIMITER //

-- Create a BEFORE INSERT trigger for the Portfolios table
CREATE TRIGGER before_portfolios_insert
BEFORE INSERT ON Portfolios
FOR EACH ROW
BEGIN
    -- Check if the quantity is negative
    IF NEW.quantity < 0 THEN
        -- Raise an error if the quantity is invalid
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Quantity cannot be negative.';
    END IF;
END//

DELIMITER ;

-- TABLE 9 
CREATE TABLE AuditLog (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    log_message VARCHAR(255),
    log_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
DELIMITER //

CREATE TRIGGER after_watchlist_insert
AFTER INSERT ON Watchlist
FOR EACH ROW
BEGIN
    -- Log message into the AuditLog table
    INSERT INTO AuditLog (log_message) 
    VALUES (CONCAT('New watchlist entry added: Watchlist ID ', NEW.watchlist_id, 
                   ', User ID ', NEW.user_id, 
                   ', Stock ID ', NEW.stock_id, 
                   ', Date ', NEW.added_date));
END //

DELIMITER ;

-- TABLE 10 
-- Step 1: Create the log table
CREATE TABLE Exchange_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    exchange_id INT NOT NULL,
    action VARCHAR(50),
    action_time DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Step 2: Create the AFTER INSERT trigger
DELIMITER //

CREATE TRIGGER after_exchange_insert
AFTER INSERT ON Exchanges
FOR EACH ROW
BEGIN
    -- Insert log into the log table
    INSERT INTO Exchange_Log (exchange_id, action)
    VALUES (NEW.exchange_id, 'INSERTED');
END//

DELIMITER ;

-- TABLE 12 
DELIMITER //

CREATE TRIGGER after_market_history_insert
AFTER INSERT ON MarketHistory
FOR EACH ROW
BEGIN
    -- Declare variables to log activity
    DECLARE log_message VARCHAR(255);
    
    -- Construct a log message containing details of the inserted row
    SET log_message = CONCAT(
        'New record added to MarketHistory: history_id = ', NEW.history_id, 
        ', stock_id = ', NEW.stock_id, 
        ', price = ', NEW.price, 
        ', date = ', NEW.date
    );

    -- Insert the log message into a logging table (you can create this table separately)
    INSERT INTO ActionLogs (log_message, log_date) 
    VALUES (log_message, NOW());
END //

DELIMITER ;

-- TABLE 13
-- Create a trigger to log new entries in the Company table
DELIMITER //

CREATE TRIGGER after_company_insert
AFTER INSERT ON Company
FOR EACH ROW
BEGIN
    -- Insert a record into the audit_log table with details about the new company
    INSERT INTO audit_log (action_time, action_type, details)
    VALUES (NOW(), 'INSERT', 
            CONCAT('New company added: ', NEW.company_name, 
                   ' (ID: ', NEW.company_id, 
                   ', Stock ID: ', NEW.stock_id, 
                   ', Headquarters: ', NEW.headquarters, ').'));
END//

DELIMITER ;

-- TABLE 16

DELIMITER //

CREATE TRIGGER before_ipo_insert
BEFORE INSERT ON IPO
FOR EACH ROW
BEGIN
    -- Ensure the issue_price is not negative
    IF NEW.issue_price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Issue price cannot be negative';
    END IF;

    -- Ensure the shares_issued is at least 1
    IF NEW.shares_issued < 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Shares issued must be at least 1';
    END IF;

    -- Example of additional logic: Default a value for issue_date if NULL
    IF NEW.issue_date IS NULL THEN
        SET NEW.issue_date = CURDATE();
    END IF;
END//

DELIMITER ;

-- TABLE 17 
DELIMITER //

CREATE TRIGGER before_insert_analyst_ratings
BEFORE INSERT ON AnalystRatings
FOR EACH ROW
BEGIN
    -- Ensure the 'rating' is one of the allowed values: 'Buy', 'Sell', 'Hold'
    IF NOT (NEW.rating IN ('Buy', 'Sell', 'Hold')) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid rating value. Allowed values are: Buy, Sell, Hold';
    END IF;

    -- Optional: You could also check if the stock_id exists in the Stocks table
    -- This ensures no invalid stock_id is being referenced in the AnalystRatings table.
    IF NOT EXISTS (SELECT 1 FROM Stocks WHERE stock_id = NEW.stock_id) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Invalid stock_id. Stock ID does not exist in the Stocks table.';
    END IF;
END //

DELIMITER ;

-- TABLE 18 
DELIMITER //
-- Create the BEFORE INSERT trigger
CREATE TRIGGER before_user_message_insert
BEFORE INSERT ON UserMessages
FOR EACH ROW
BEGIN
    -- Check if the sender and receiver are the same. If they are, prevent the insertion.
    IF NEW.sender_id = NEW.receiver_id THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Sender and receiver cannot be the same person';
    END IF;

    IF TRIM(NEW.message_text) = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Message text cannot be empty';
    END IF;

END//

DELIMITER ;

-- TABLE 19 
	DELIMITER //

CREATE TRIGGER before_insert_fees
BEFORE INSERT ON Fees
FOR EACH ROW
BEGIN
    -- Check if trade_fee is greater than 0
    IF NEW.trade_fee <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Trade fee must be greater than zero';
    END IF;
END //

DELIMITER ;

-- TABLE 20 
DELIMITER //

-- Creating a BEFORE INSERT Trigger on MarketNews table
CREATE TRIGGER before_marketnews_insert
BEFORE INSERT ON MarketNews
FOR EACH ROW
BEGIN
    -- Check if the headline is not empty before inserting
    IF NEW.headline IS NULL OR NEW.headline = '' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Headline cannot be empty';
    END IF;

    -- Check if the published_date is not in the future
    IF NEW.published_date > CURDATE() THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Published date cannot be in the future';
    END IF;
    
    -- Optional: You can set default values or modify the data before insertion
    -- For example, you can automatically capitalize the headline:
    SET NEW.headline = UPPER(NEW.headline);
    
END//

DELIMITER ;


-- windows funcation 
-- table 1 
-- Calculates the cumulative count of users grouped by the month of creation
SELECT 
    user_id,
    name,
    created_at,
    EXTRACT(MONTH FROM created_at) AS creation_month,
    COUNT(*) OVER (PARTITION BY EXTRACT(MONTH FROM created_at) ORDER BY created_at ASC) AS monthly_running_total
FROM Users;

-- table 2 
-- Rank brokers by their names alphabetically
SELECT 
    broker_id, 
    broker_name, 
    RANK() OVER (ORDER BY broker_name ASC) AS ranks
FROM Brokers;

-- example 2 
-- Dense rank brokers by their names alphabetically
SELECT 
    broker_id, 
    broker_name, 
    DENSE_RANK() OVER (ORDER BY broker_name ASC) AS dense_ranks
FROM Brokers;

-- table 3
SELECT 
    account_id,
    broker_id,
    account_balance,
    AVG(account_balance) OVER (PARTITION BY broker_id) AS avg_balance_by_broker
FROM Accounts;

-- table 4 
-- Similar to RANK(), but there are no gaps in the ranking
SELECT 
    stock_id,
    stock_symbol,
    stock_name,
    current_price,
    DENSE_RANK() OVER (ORDER BY current_price DESC) AS dense_ranks
FROM Stocks;

-- table 5 
-- 1. Calculate running total quantity of stocks bought or sold for each account
SELECT
    account_id,
    transaction_id,
    transaction_type,
    quantity,
    SUM(quantity) OVER (PARTITION BY account_id ORDER BY transaction_date) AS running_total_quantity
FROM Transactions
ORDER BY account_id, transaction_date;

-- Explanation:
-- - PARTITION BY account_id: Groups rows by each account.
-- - ORDER BY transaction_date: Orders transactions chronologically within each account.
-- - SUM(quantity): Computes the running total of the quantity.

-- 2. Rank transactions within each account based on the transaction date
SELECT
    account_id,
    transaction_id,
    transaction_date,
    RANK() OVER (PARTITION BY account_id ORDER BY transaction_date ASC) AS transaction_rank
FROM Transactions
ORDER BY account_id, transaction_rank;

-- table 6 
-- Determine the rank of orders by quantity across all orders
SELECT 
    order_id,
    quantity,
    DENSE_RANK() OVER (ORDER BY quantity DESC) AS quantity_rank
FROM Orders;

-- table 7
SELECT
    dividend_id,
    stock_id,
    dividend_amount,
    dividend_date,
    -- Calculate difference from the previous dividend
    dividend_amount - LAG(dividend_amount) OVER (ORDER BY dividend_date) AS difference_from_previous
FROM
    Dividends;
    
    -- table 8
    -- Calculate window functions in the Portfolios table
SELECT 
    portfolio_id,
    account_id,
    stock_id,
    quantity,

    -- Calculate the running total of quantity (cumulative sum)
    SUM(quantity) OVER (ORDER BY portfolio_id) AS running_total,

    -- Rank portfolios by quantity in descending order
    RANK() OVER (ORDER BY quantity DESC) AS rank_by_quantity,

    -- Calculate the average quantity within each account group
    AVG(quantity) OVER (PARTITION BY account_id) AS avg_quantity_per_account
FROM 
    Portfolios;
    
    -- table 9
    -- Query to rank watchlist entries by added_date for each user
SELECT 
    watchlist_id,
    user_id,
    stock_id,
    added_date,
    RANK() OVER (PARTITION BY user_id ORDER BY added_date ASC) AS rank_by_date
FROM 
    Watchlist;
    
    -- table 10
    -- Using RANK() to rank exchanges based on their country (in this case, India)
SELECT 
    exchange_id,
    exchange_name,
    country,
    RANK() OVER (PARTITION BY country ORDER BY exchange_name) AS ranks
FROM 
    Exchanges;
    
    -- table 11
    -- table 12 
   -- Example: Calculate the average price of each stock over the history, 
-- along with the price rank of each record within its stock group.
    SELECT
    history_id,
    stock_id,
    price,
    date,
     ROW_NUMBER() OVER (PARTITION BY stock_id ORDER BY date) AS row_num,
RANK() OVER (PARTITION BY stock_id ORDER BY price DESC) AS price_rank,
AVG(price) OVER (PARTITION BY stock_id) AS avg_price
FROM
    MarketHistory;
    
    -- table 15
    -- Use RANK to rank companies within each headquarters by stock_id
SELECT
    company_id,
    company_name,
    stock_id,
    headquarters,
    RANK() OVER (PARTITION BY headquarters ORDER BY stock_id) AS ranks
FROM
    Company;

-- Use SUM() window function to calculate a running total of stock IDs
SELECT
    company_id,
    company_name,
    stock_id,
    headquarters,
    SUM(stock_id) OVER (ORDER BY company_id) AS running_total
FROM
    Company;

-- table 16
-- Using window functions to calculate cumulative sum and rank for IPO shares

SELECT 
    ipo_id,                
    stock_id,                 
    issue_price,          
    issue_date,               
    shares_issued,      
    SUM(shares_issued) OVER (ORDER BY issue_date) AS cumulative_shares_issued,
	RANK() OVER (ORDER BY shares_issued DESC) AS shares_issued_rank,
	ROW_NUMBER() OVER (ORDER BY issue_date) AS ipo_row_number
FROM IPO;

-- table 17 
SELECT 
    rating_id, 
    stock_id, 
    analyst_name, 
    rating, 
    rating_date,
    ROW_NUMBER() OVER (PARTITION BY stock_id ORDER BY rating_date) AS row_num
FROM 
    AnalystRatings;
    
    SELECT 
    rating_id, 
    stock_id, 
    analyst_name, 
    rating, 
    rating_date,
    RANK() OVER (PARTITION BY stock_id ORDER BY rating_date DESC) AS ranks
FROM 
    AnalystRatings;
    
    
    -- table 18
    SELECT
    sender_id,
    COUNT(message_id) OVER (PARTITION BY sender_id) AS message_count_by_sender,
	message_text,
    sent_date
FROM
    UserMessages;
    
    SELECT
    sender_id,
    AVG(COUNT(message_id)) OVER (PARTITION BY sender_id) AS avg_messages_per_sender  -- Average number of messages sent by each sender
FROM
    UserMessages
GROUP BY sender_id;

-- table 19 
-- Using a window function to calculate the cumulative sum of trade fees for each broker
SELECT 
    fee_id, 
    broker_id, 
    trade_fee, 
    created_at,
	SUM(trade_fee) OVER (PARTITION BY broker_id ORDER BY created_at) AS cumulative_trade_fee
FROM Fees;

SELECT 
    fee_id, 
    broker_id, 
    trade_fee, 
    created_at,
    ROW_NUMBER() OVER (PARTITION BY broker_id ORDER BY trade_fee DESC) AS fee_rank
FROM Fees;

-- table 20 
-- Dense rank the records by published date
SELECT news_id, headline, published_date,
       DENSE_RANK() OVER (ORDER BY published_date) AS dense_ranks
FROM MarketNews;

select * from users ;
select * from brokers ;
select * from Accounts ;
select * from Stocks  ;
select * FROM Transactions  ;
SELECT * FROM Orders ;
SELECT * FROM Dividends ;
SELECT * FROM Portfolios ;
SELECT * FROM Watchlist ;
select * from Exchanges  ;
select * from StockExchange ;
select * FROM MarketHistory ;
SELECT * from StockSectors ;
select * from StockSectorMapping ;
select * from Company  ;
select * from IPO ;
select * from AnalystRatings ;
select * from UserMessages ;
select * from fees ;
select * from MarketNews ;





    













