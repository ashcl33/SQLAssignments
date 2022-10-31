# ----Viewing tables in the db----
select * from employees;
select * from offices;
select * from customers;
select * from orders;
select * from orderdetails;
select * from payments;
select * from productlines;
select * from products;

INSERT IGNORE INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (0,"N/A","N/A","N/A","N/A","N/A","N/A", "Remote" ,"USA");

INSERT IGNORE INTO offices (officeCode,phone,addressLine1,addressLine2,state,postalCode,territory,city,country)
VALUES (9,"435-647-7654","1435 Bart ST","Office 36","MN","94324","USA", "St Paul" ,"USA"),
(10,"435-647-7654","1435 Test ST","Office 5","TX","75036","USA", "Frisco" ,"USA");

INSERT IGNORE INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (7567,"Worker", "Remote" ,"x3643", "remotework@gmail.com",0,1143,"Sales Rep"),
(7568,"Jenkins", "Ralph" ,"x3633", "Theralphster@gmail.com",0,1143,"Sales Rep");

# ***FROM EASY PROMPTS***
#(Q1) Select the newly added St. Paul office with officecode, phone number, and city

SELECT officeCode, phone, city FROM offices WHERE officeCode=9;

#(Q2) Top 10 highest MSRP products with columns productName, productLine, buyPrice, MSRP

SELECT productName, productLine, buyPrice, MSRP FROM products
ORDER BY MSRP DESC
LIMIT 10;

#(Q3) Employees with remote office 0.

SELECT CONCAT(firstName," ", lastName) AS "Full Name" FROM employees WHERE officeCode = 0;

# ***FROM MEDIUM PROMPTS***

#(Q1) Employees with remote office and offices with no employees

SELECT CONCAT(firstName, '', lastName) AS 'Full Name', city, officeCode FROM employees
LEFT JOIN offices USING (officeCode)
WHERE officeCode = 0
UNION
SELECT CONCAT(firstName,'', lastName) AS 'Full Name', city, officeCode FROM offices
LEFT JOIN employees USING (officeCode)
GROUP BY officeCode, employeeNumber HAVING COUNT(employeeNumber)=0;

#(Q2) Write a query to display the amount of employees per country with columns country and number of employees.
#Order by number of employees with the highest values first (use group by and aggregate functions and a join)

SELECT country, COUNT(employeeNumber)'# of employees' FROM offices
INNER JOIN employees USING (officeCode)
GROUP BY country
ORDER BY COUNT(employeeNumber) DESC;

# ***FROM DIFFICULT PROMPTS***

#(Q1) Number of products ordered and their order status, include columns product, total ordered, and status. Hint: use a double groupby

SELECT productName AS "Product",
SUM(quantityOrdered) AS "Total",
STATUS AS "Status" FROM products
INNER JOIN orderDetails USING (productCode)
INNER JOIN  orders USING (orderNumber)
WHERE orderDetails.productCode = products.productCode
GROUP BY orderDetails.productCode, STATUS
ORDER BY productName ASC, STATUS DESC;






    










