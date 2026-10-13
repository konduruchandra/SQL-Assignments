-- Banking Scenario 
Create database banking;
use banking;
 
 CREATE TABLE customers
 ( customer_id INT PRIMARY KEY AUTO_INCREMENT, 
 name VARCHAR(50), 
 city VARCHAR(50) );
 
 CREATE TABLE accounts ( account_id INT PRIMARY KEY AUTO_INCREMENT, 
 customer_id INT, 
 account_type VARCHAR(20), 
 balance DECIMAL(10,2), 
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id) );
 
 INSERT INTO customers (name, city) VALUES 
 ('Janani','Chennai'), 
 ('Arun','Coimbatore'), 
 ('Priya','Madurai'), 
 ('Karthik','Salem'),
 ('Chandu', 'Nellore'),
 ('Mahi','Kavali'),
 ('Dinesh','hyderabad'),
 ('Karthick','Vizag'),
 ('Yawanth','Bangalore'),
 ('Rishi','Mangalore');
 
 INSERT INTO accounts (customer_id, account_type, balance) VALUES 
 (1,'Savings',50000), 
 (1,'Current',20000), 
 (2,'Savings',30000), 
 (3,'Savings',15000), 
 (4,'Current',40000),
 (5,'Savings',60000),
 (6,'Current',50000),
 (7,'Savings',55000),
 (8,'Current',650000),
 (9,'Savings',600000),
 (10,'Current',700000);
 
 select  * from accounts;
 select * from customers;
 
 -- Basic + WHERE + Operators (1–15)
 
 -- 1. Retrieve all accounts with balance greater than 20,000.
 select account_type from accounts where balance > 20000;
 
-- 2. Find customers who live in Chennai.
select * from customers where city = "Chennai";

-- Display accounts with balance between 20,000 and 50,000
select * from accounts where balance between 20000 and 50000;

-- Find customers whose names start with 'J' 
SELECT * FROM customers WHERE name LIKE 'J%';

-- Retrieve accounts of type 'Savings' or 'Current'
SELECT * FROM accounts WHERE account_type IN ('Savings', 'Current');

-- Display accounts that are not 'Savings'
SELECT * FROM accounts WHERE account_type <> 'Savings';

-- Find customers whose names contain the letter 'a'
SELECT * FROM customers WHERE name LIKE '%a%';

-- Retrieve accounts with balance less than or equal to 30,000
SELECT * FROM accounts WHERE balance <= 30000;

-- Find customers who are not from Madurai
SELECT * FROM customers WHERE city <> 'Madurai';
 
 -- 10. Display accounts where balance is not between 10,000 and 40,000
 SELECT * FROM accounts WHERE balance NOT BETWEEN 10000 AND 40000;
 
 -- 11. Retrieve customers whose names end with 'i'.
 SELECT * FROM customers WHERE name LIKE '%i';

-- 12. Find accounts with balance equal to 50,000.
SELECT * FROM accounts WHERE balance = 50000;

-- 13. Display customers whose city is either Chennai or Salem.
SELECT * FROM customers WHERE city IN ('Chennai', 'Salem');

-- 14. Find accounts with balance greater than 10,000 and less than 40,000
SELECT * FROM accounts WHERE balance > 10000 AND balance < 40000;

-- 15. Retrieve accounts where account type is not in ('Current').
SELECT * FROM accounts WHERE account_type NOT IN ('Current');

-- ORDER BY (16–18)

-- 16. Display all accounts sorted by balance in descending order.
SELECT * FROM accounts ORDER BY balance DESC;

-- 17. List customers sorted alphabetically by name.
SELECT * FROM customers ORDER BY name ASC;

-- 18. Display accounts sorted by account type and then by balance (descending).
SELECT * FROM accounts ORDER BY account_type ASC, balance DESC;

-- Aggregate Functions (19–23) 

-- 19. Find the total balance of all accounts.
SELECT SUM(balance) AS total_balance FROM accounts;

-- 20. Calculate the average balance of accounts.
SELECT AVG(balance) AS average_balance FROM accounts;

-- 21. Find the maximum account balance.
SELECT MAX(balance) AS maximum_balance FROM accounts;

-- 22. Find the minimum account balance.
SELECT MIN(balance) AS minimum_balance FROM accounts;

-- 23. Count the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- GROUP BY + HAVING (24–28)

-- 24. Find total balance grouped by account type.
SELECT account_type, SUM(balance) AS total_balance FROM accounts GROUP BY account_type;

-- 25. Find average balance for each account type.
SELECT account_type, AVG(balance) AS average_balance FROM accounts GROUP BY account_type;

-- 26. Display account types having average balance greater than 20,000.
SELECT account_type, AVG(balance) AS average_balance FROM accounts 
GROUP BY account_type HAVING AVG(balance) > 20000;

-- 27. Count number of accounts for each customer.
SELECT customer_id, COUNT(*) AS total_accounts FROM accounts GROUP BY customer_id;

-- 28. Display customers having more than one account.
SELECT c.customer_id, c.name,
       COUNT(a.account_id) AS total_accounts
FROM customers c
JOIN accounts a ON c.customer_id = a.customer_id 
GROUP BY c.customer_id, c.name HAVING COUNT(a.account_id) > 1;

-- JOINS (29–35)

-- 29. Retrieve customer names along with their account balances.
SELECT c.name, a.balance
FROM customers c
INNER JOIN accounts a
ON c.customer_id = a.customer_id;

-- 30. Display all customers and their accounts (including customers without accounts).
SELECT c.customer_id, c.name, c.city,
       a.account_id, a.account_type, a.balance
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id;

-- 31. Display all accounts and corresponding customer details.
SELECT a.account_id, a.account_type, a.balance,
       c.customer_id, c.name, c.city
FROM accounts a
INNER JOIN customers c
ON a.customer_id = c.customer_id;

-- 32. Retrieve customer names and account types where balance is greater than 20,000.
SELECT c.name, a.account_type, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.balance > 20000;

-- 33. List customers with their total balance using JOIN.
SELECT c.customer_id, c.name,
       SUM(a.balance) AS total_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.customer_id, c.name;

-- 34. Display customer names and balances sorted by balance.
SELECT c.name, a.balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;

-- 35. Count number of accounts for each city using JOIN.
SELECT c.city, COUNT(a.account_id) AS total_accounts
FROM customers c
LEFT JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.city
ORDER BY total_accounts DESC;

-- SUBQUERIES (36–40)

-- 36. Find accounts with balance greater than average balance.
SELECT *
FROM accounts
WHERE balance > (
    SELECT AVG(balance)
    FROM accounts
);

-- 37. Retrieve customers who have accounts.
SELECT *
FROM customers c
WHERE EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
);

-- 38. Find customers who do not have any accounts.
SELECT *
FROM customers c
WHERE NOT EXISTS (
    SELECT 1
    FROM accounts a
    WHERE a.customer_id = c.customer_id
);

-- 39. Display account(s) with the maximum balance.
SELECT *
FROM accounts
WHERE balance = (
    SELECT MAX(balance)
    FROM accounts
);

-- 40. Find customers whose total balance is greater than 40,000.
SELECT *
FROM customers c
WHERE (
    SELECT SUM(a.balance)
    FROM accounts a
    WHERE a.customer_id = c.customer_id
) > 40000;
 