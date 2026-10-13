create database employee_management;
use employee_management;

CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
department VARCHAR(30),
salary DECIMAL(10,2),
city VARCHAR(30),
joining_date DATE
);
INSERT INTO Employee VALUES
(101,'John','IT',60000,'Chennai','2022-01-15'),
(102,'David','HR',45000,'Bangalore','2021-03-10'),
(103,'Smith','IT',70000,'Chennai','2020-07-12'),
(104,'Mary','Finance',55000,'Mumbai','2023-01-20'),
(105,'James','HR',48000,'Delhi','2022-05-05'),
(106,'Linda','Finance',65000,'Mumbai','2021-08-18');

CREATE TABLE Customers ( 
customer_id INT PRIMARY KEY,
customer_name VARCHAR(50), 
city VARCHAR(30) );

insert into Customers value 
(111,'Sanjay','Chennai'),
(112,'Gopi','Nellore'),
(113,'Sanju','Hyderbad'),
(114,'Vijay','Salem'),
(115,'Kumari','Chennai'),
(116,'Chandu','Bangalore'),
(117,'Teja','Mysore');

CREATE TABLE Orders ( 
order_id INT PRIMARY KEY, 
customer_id INT, 
amount DECIMAL(10,2), 
order_date DATE, 
FOREIGN KEY(customer_id) REFERENCES Customers(customer_id) );

Insert into Orders values
(1,111,20000,'2026-09-20'),
(2,112,30000,'2026-09-24'),
(3,113,40000,'2026-09-21'),
(4,114,25000,'2026-09-18'),
(5,115,29000,'2026-09-19'),
(6,116,50000,'2026-09-17'),
(7,117,10000,'2026-09-12');

CREATE TABLE Students ( 
student_id INT PRIMARY KEY, 
student_name VARCHAR(50), 
department VARCHAR(30), 
marks INT );

insert into Students value
(1,'Raju','CSE',95),
(2,'Kaju','ECE',95),
(3,'Ben','AiDS',95),
(4,'Gwen','ECE',95),
(5,'Suni','CSE',95),
(6,'Mani','CSE',95),
(7,'Gani','AidS',95);



-- Employee Table
-- 1. Find the total number of employees in each department.
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department;

-- 2. Find the average salary of employees in each department.
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department;

-- 3. Display departments having more than one employee.
SELECT department, COUNT(*) AS total_employees
FROM Employee
GROUP BY department
HAVING COUNT(*) > 1;

-- 4. Find the highest salary in each department.
SELECT department, MAX(salary) AS highest_salary
FROM Employee
GROUP BY department;

-- 5. Find the lowest salary in each department.
SELECT department, MIN(salary) AS lowest_salary
FROM Employee
GROUP BY department;

-- 6. Find departments whose average salary is greater than 50,000.
SELECT department, AVG(salary) AS average_salary
FROM Employee
GROUP BY department
HAVING AVG(salary) > 50000;

-- 7. Calculate the total salary expenditure for each department.
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department;

-- 8. Display all employees sorted by salary in descending order.
SELECT *
FROM Employee
ORDER BY salary DESC;

-- 9. Display employees sorted first by department and then by salary in descending order.
SELECT *
FROM Employee
ORDER BY department ASC, salary DESC;

-- 10. Find cities that have more than one employee.
SELECT city, COUNT(*) AS total_employees
FROM Employee
GROUP BY city
HAVING COUNT(*) > 1;

-- 11. Find the total salary paid in each city.
SELECT city, SUM(salary) AS total_salary
FROM Employee
GROUP BY city;

-- 12. Display departments ordered by total salary expenditure from highest to lowest.
SELECT department, SUM(salary) AS total_salary
FROM Employee
GROUP BY department
ORDER BY total_salary DESC;

-- 13. Find the number of employees in each department whose salary is greater than 50,000.
SELECT department, COUNT(*) AS employee_count
FROM Employee
WHERE salary > 50000
GROUP BY department;

-- 14. Find the difference between the highest and lowest salary in each department.
SELECT department,
       MAX(salary) AS highest_salary,
       MIN(salary) AS lowest_salary,
       MAX(salary) - MIN(salary) AS salary_difference
FROM Employee
GROUP BY department;

-- 15. Display the top 3 highest-paid employees.
SELECT *
FROM Employee
ORDER BY salary DESC
LIMIT 3;

-- Customers & Orders Tables

-- 16. Find the total order amount for each customer.
SELECT c.customer_id, c.customer_name,
       SUM(o.amount) AS total_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 17. Find customers who have placed more than 3 orders.
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 3;

-- 18. Find the average order amount for each customer.

SELECT c.customer_name,
       AVG(o.amount) AS average_order_amount
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 19. Find the highest order amount placed by each customer.
SELECT c.customer_name,
       MAX(o.amount) AS highest_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 20. Display customers sorted by their total purchase amount.
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC;

-- 21. Find customers whose total purchase amount exceeds 10,000.
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 10000;

-- 22. Display customer names along with the total number of orders placed.
SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 23. Find the customer who spent the highest amount.
SELECT c.customer_name,
       SUM(o.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC
LIMIT 1;

-- 24. Find the customer who placed the maximum number of orders.

SELECT c.customer_name,
       COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC
LIMIT 1;


-- 25. Find customers whose average order amount is greater than 2,000.
SELECT c.customer_name,
       AVG(o.amount) AS average_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING AVG(o.amount) > 2000;

-- 26. Display the top 5 customers based on total purchase amount.
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_purchase DESC
LIMIT 5;

-- 27. Find the minimum order amount for each customer.
SELECT c.customer_name,
       MIN(o.amount) AS minimum_order
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 28. Find customers who have placed orders worth more than 5,000 in total.
SELECT c.customer_name,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.amount) > 5000;

-- 29. Display customer-wise total orders and total purchase amount.
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders,
       COALESCE(SUM(o.amount), 0) AS total_purchase
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name;

-- 30. Find customers who placed more than 2 orders and spent more than 8,000.
SELECT c.customer_id, c.customer_name,
       COUNT(o.order_id) AS total_orders,
       SUM(o.amount) AS total_purchase
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(o.order_id) > 2
   AND SUM(o.amount) > 8000;
   
   
-- 31. Find the average marks scored by students in each department.
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department;

-- 32. Find departments whose average marks are above 75.
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) > 75;

-- 33. Find the highest mark scored in each department.
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department;

-- 34. Find the total number of students in each department.
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department;

-- 35. Find departments having more than 5 students.
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department
HAVING COUNT(*) > 5;

-- 36. Display departments sorted by average marks in descending order.
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC;

-- 37. Find the top 3 departments based on average marks.
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
ORDER BY average_marks DESC
LIMIT 3;

-- 38. Find departments whose average marks are between 70 and 90.
SELECT department, AVG(marks) AS average_marks
FROM Students
GROUP BY department
HAVING AVG(marks) BETWEEN 70 AND 90;

-- 39. Find the total marks scored by students in each department.
SELECT department, SUM(marks) AS total_marks
FROM Students
GROUP BY department;

-- 40. Display departments sorted by the total number of students.
SELECT department, COUNT(*) AS total_students
FROM Students
GROUP BY department
ORDER BY total_students DESC;

-- 41. Find the lowest mark scored in each department.
SELECT department, MIN(marks) AS lowest_marks
FROM Students
GROUP BY department;

-- 42. Find departments where the highest mark is greater than 90.
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department
HAVING MAX(marks) > 90;

-- 43. Find the number of students scoring above 80 in each department.
SELECT department, COUNT(*) AS students_above_80
FROM Students
WHERE marks > 80
GROUP BY department;

-- 44. Find departments where more than 3 students scored above 75.
SELECT department, COUNT(*) AS students_above_75
FROM Students
WHERE marks > 75
GROUP BY department
HAVING COUNT(*) > 3;

-- 45. Display departments ordered by highest mark in descending order.
SELECT department, MAX(marks) AS highest_marks
FROM Students
GROUP BY department
ORDER BY highest_marks DESC;