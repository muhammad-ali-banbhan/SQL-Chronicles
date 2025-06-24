
-- INNER JOIN

-- SQL Practice Questions - INNER JOIN


-- Question 1: Orders and Customers Join (orders & customers tables)
-- Un orders ki orderNumber, orderDate, aur corresponding customerName nikalen. 
-- Sirf un orders ko show karein jo customer table mein bhi maujood hain (common records).

select  * from  orders;
select *  from customers;

select orders.orderNumber, orders.orderDate, customers.customerName
from orders inner join customers
on orders.customerNumber = customers.customerNumber;


SELECT
    o.orderNumber,
    o.orderDate,
    c.customerName
FROM
    orders o  -- 'orders' table ko 'o' alias diya
INNER JOIN
    customers c -- 'customers' table ko 'c' alias diya
ON
    o.customerNumber = c.customerNumber;
    
    
    
    -- Question 2: Product Details in Orders (orderdetails & products tables)
-- Har order mein kis productName ki kitni quantityOrdered thi aur uski priceEach kya thi, woh nikalen. 
-- Ismein orderNumber, productName, quantityOrdered, aur priceEach columns show karein.

select * from  products;
select * from  orderdetails;

select orderdetails.orderNumber, products.productName, orderdetails.quantityOrdered, orderdetails.priceEach
from products inner join orderdetails
on  products.productCode  =  orderdetails.productCode;

-- Question 3: Employee and Office Info (employees & offices tables - assuming officeCode is common)
-- Har employee ka firstName, lastName, jobTitle, aur woh kis city mein located office se belong karta hai, woh nikalen.
-- (Note: employees table mein officeCode column hai, but offices table tumhari list mein nahi hai. Toh hum assume kar lete hain 
-- ke officeCode ek common column hai jo employees table ko customers table se ya orders table se connect karta hai, agar offices 
-- table available nahi hai. Agar tumhare paas offices 
-- table hai to use karna, warna employees aur customers ya orders table ko officeCode / customerNumber ke through join karne ki koshish karna).

select employees.firstName, employees.lastName,  offices.city,  offices.officeCode
from  employees inner join offices
on employees.officeCode = offices.officeCode;


-- Question 4: Order Details with Product Line (orderdetails & products tables)
-- orderNumber, productCode, productName, quantityOrdered, aur productLine nikalen.

select orderdetails.orderNumber, products.productCode,  products.productName, orderdetails.quantityOrdered,  products.productLine
from orderdetails inner join products
on orderdetails.productCode = products.productCode;





-- Question 1: Employees and Their Handled Customers in Specific Cities (employees, customers tables)
-- Un employees ka firstName, lastName, aur jobTitle nikalen jinhone 'NYC' ya 'Boston' city se belong karne wale 
-- customers ko handle kiya hai. Sirf un employees ko show karein jinhone at least 2 unique customers ko handle kiya hai in cities se.
-- (Hint: salesRepEmployeeNumber se join, GROUP BY, COUNT(DISTINCT), HAVING ka use karein)

select * from employees;
select * from customers;

SELECT
    e.firstName,
    e.lastName,
    e.jobTitle,
    COUNT(DISTINCT c.customerNumber) AS total_unique_customers_in_selected_cities
FROM
    employees e
INNER JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE
    c.city IN ('NYC', 'Boston') -- Customers ko NYC ya Boston mein filter kiya
GROUP BY
    e.employeeNumber, e.firstName, e.lastName, e.jobTitle -- Employees par group kiya
HAVING
    COUNT(DISTINCT c.customerNumber) >= 2; -- Sirf un employees ko rakha jinhone 2 ya zyada customers handle kiye


-- Question 2: Products Ordered by Specific Customer (products, orderdetails, orders, customers tables)
-- productName, productLine, aur quantityOrdered nikalen un products ki jo customer 'Atelier graphique' ne order kiye hain.
-- (Hint: 4 tables join hongi: products, orderdetails, orders, customers.)

SELECT
    p.productName,
    p.productLine,
    od.quantityOrdered
FROM
    products p
INNER JOIN
    orderdetails od ON p.productCode = od.productCode -- Products ko OrderDetails se joda
INNER JOIN
    orders o ON od.orderNumber = o.orderNumber       -- OrderDetails ko Orders se joda
INNER JOIN
    customers c ON o.customerNumber = c.customerNumber -- Orders ko Customers se joda
WHERE
    c.customerName = 'Atelier graphique'; -- Specific customer filter kiya
    
    
    
    
-- Question 1: Top 5 Most Ordered Products by Revenue (products, orderdetails tables)
-- Un 5 productName aur unki total revenue nikalen (calculated as quantityOrdered * priceEach) 
-- jinko sabse zyada order kiya gaya hai, revenue ke hisaab se descending order mein.
-- (Hint: INNER JOIN, GROUP BY, SUM, ORDER BY, LIMIT)
select * from orderdetails;
select *  from products;

select p.productName, sum(od.quantityOrdered*od.priceEach) as total_revenue
from products p inner join orderdetails od
on p.productCode = od.productCode 
group by p.productName
order by total_revenue desc
limit 5;



-- Question 2: Customers Who Ordered Products from 'Classic Cars' or 'Motorcycles' (customers, orders, orderdetails, products tables)
Un customerName aur city ko nikalen jinhone productLine 'Classic Cars' ya 'Motorcycles' se koi bhi product order kiya hai. Results mein koi duplicate customer na ho.
(Hint: INNER JOIN multiple tables, WHERE with OR, DISTINCT)

Question 3: Employees with No Sales to Specific Countries (employees, customers tables)
Un firstName, lastName, aur jobTitle nikalen un employees ke jinhone kabhi bhi 'USA' ya 'Canada' ke customers ko sales nahi ki hain.
(Hint: NOT IN with a subquery, or LEFT JOIN then WHERE IS NULL - INNER JOIN context mein NOT IN better hai abhi. Also, GROUP BY employee details)

Question 4: Orders with Total Items and Total Value (orders, orderdetails tables)
Har orderNumber ke liye orderDate, total number_of_items (total quantityOrdered per order), aur total order_value (sum of quantityOrdered * priceEach per order) nikalen.
(Hint: INNER JOIN, GROUP BY, SUM)