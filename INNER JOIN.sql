
-- Understanding INNER JOIN in SQL

-- INNER JOIN SQL mein do ya do se zyada tables se data combine karne ka sabse commonly used method hai. Iska maqsad sirf 
-- un rows ko return karna hai jinke liye JOIN condition ke mutabiq dono tables mein matching records maujood hon.

-- Concept:
-- INNER JOIN bilkul Venn Diagram ke "intersection" (mushtarak hisse) ki tarah kaam karta hai. Agar do tables hain, Table A aur Table B, aur tum unko
-- INNER JOIN karte ho, toh result set mein sirf woh rows aayengi jinke JOIN columns ki values Table A aur Table B dono mein exactly match karti hon.

-- Matching Records Only: Sirf woh records shamil honge jinke liye ON clause mein specify ki gayi condition (usually common columns ki equality) TRUE return karti hai.
-- No Non-Matching Records: Agar kisi table mein koi record hai jiska matching record doosri table mein nahi hai, toh woh record result set mein shamil nahi hoga.
-- Analogy (Misaal):

-- Imagine karo tumhare paas do lists hain:

-- List A (Table A): Tumhare "College Ke Dost" (Friends from College).
-- List B (Table B): Tumhare "School Ke Dost" (Friends from School).
-- INNER JOIN se kya milega?

-- Sirf woh log jo tumhare "College Ke Dost" bhi hain AUR "School Ke Dost" bhi hain. Yaani, woh dost jo tumne College aur School dono jagah par banaye hain.


-- Example With Our Tables (customers & orders):

-- Hum chahte hain ke sirf un customers ke orders ki details milen jinhone actually order kiya hai. Yaani, customers aur orders tables mein customerNumber par matching records.

SELECT
    c.customerName,    -- Customer ka naam customers table se
    o.orderNumber,     -- Order number orders table se
    o.orderDate,       -- Order date orders table se
    o.status           -- Order status orders table se
FROM
    customers c        -- Customers table (Left side, but order doesn't strictly matter for INNER JOIN)
INNER JOIN
    orders o ON c.customerNumber = o.customerNumber; -- Orders table (Right side)
    
-- ON condition: customers table ka customerNumber orders table ke customerNumber se match ho.

-- What the Output Shows:
-- Output mein sirf woh rows shamil hongi jahan customers table ke customerNumber ka orders table mein customerNumber se match milta hai.
-- Agar koi customer hai jisne abhi tak koi order nahi kiya (yani customers table mein record hai lekin orders table mein koi matching customerNumber nahi), toh woh customer output mein shamil nahi hoga.
-- Agar koi order hai jiska customerNumber kisi wajah se customers table mein nahi hai (data inconsistency, rarely happens), toh woh order bhi output mein shamil nahi hoga.





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
-- Un customerName aur city ko nikalen jinhone productLine 'Classic Cars' ya 'Motorcycles' se koi bhi product order kiya hai. 
-- Results mein koi duplicate customer na ho.
-- (Hint: INNER JOIN multiple tables, WHERE with OR, DISTINCT)

select DISTINCT c.customerName,  c.city, p.productLine
from products p inner join orderdetails od 
on p.productCode = od.productCode 
inner join
		orders o on o.orderNumber = od.orderNumber
inner join 
		customers c  on  o.customerNumber =c.customerNumber
 where 
		p.productLine IN ('Classic Cars' ,'Motorcycles');
        
    
-- Question 3: Employees with No Sales to Specific Countries (employees, customers tables)
-- Un firstName, lastName, aur jobTitle nikalen un employees ke jinhone kabhi bhi 'USA' ya 'Canada' ke customers ko sales nahi ki hain.
-- (Hint: NOT IN with a subquery, or LEFT JOIN then WHERE IS NULL - INNER JOIN context mein NOT IN better hai abhi. Also, GROUP BY employee details)

select * from employees;
select  * from customers;

select  e.firstName, e.lastName, e.jobTitle
from employees e 
where 
	e.employeeNumber NOT IN (
        SELECT DISTINCT c.salesRepEmployeeNumber
        FROM customers c
        WHERE c.country IN ('USA', 'Canada')
    )
GROUP BY -- Agar koi employee multiple times ata ho result set mein to group karlo
    e.employeeNumber, e.firstName, e.lastName, e.jobTitle;



-- Question 4: Orders with Total Items and Total Value (orders, orderdetails tables)
-- Har orderNumber ke liye orderDate, total number_of_items (total quantityOrdered per order), 
-- aur total order_value (sum of quantityOrdered * priceEach per order) nikalen.
-- (Hint: INNER JOIN, GROUP BY, SUM)

select * from orderdetails;
select * from orders;

select o.orderNumber, o.orderDate, sum(od.quantityOrdered*od.priceEach) as total_revenue, count(od.quantityOrdered) as total_quantityOrdered_per_order
from  orderdetails od  inner  join  orders o 
on   od.orderNumber =  o.orderNumber
group by o.orderNumber, o.orderDate;














-- SQL Practice Questions - INNER JOIN (Ultimate Challenge Set - Remaining Qs)
-- Question 3: Employees with No Sales to Specific Countries (employees, customers tables)
-- Un firstName, lastName, aur jobTitle nikalen un employees ke jinhone kabhi bhi 'USA' ya 'Canada' ke customers ko sales nahi ki hain.
-- (Hint: NOT IN with a subquery, or LEFT JOIN then WHERE IS NULL - INNER JOIN context mein NOT IN better hai abhi. Also, GROUP BY employee details)

select e.firstName, e.lastName, e.jobTitle
from employees e
WHERE e.employeeNumber NOT IN (
select distinct c.salesRepEmployeeNumber
FROM customers c 
where c.country IN ("USA","Canada"))
group by e.firstName, e.lastName, e.jobTitle;


-- Question 4: Orders with Total Items and Total Value (orders, orderdetails tables)
-- Har orderNumber ke liye orderDate, total number_of_items (total quantityOrdered per order), 
-- aur total order_value (sum of quantityOrdered * priceEach per order) nikalen.
-- (Hint: INNER JOIN, GROUP BY, SUM)

select o.orderNumber,o.orderDate,  sum(od.quantityOrdered*od.priceEach) as total_revenue, count(od.quantityOrdered) as qty_ordered_per_order
from orders o inner join orderdetails od
on od.orderNumber = o.orderNumber
group by o.orderNumber;










-- SQL Practice Questions - INNER JOIN (The Grand Finale Challenge)
-- Question 1: Product Sales Performance by Vendor and Product Line (products, orderdetails tables)
-- Har productLine aur uske productVendor ke liye total_quantity_sold aur total_revenue (quantityOrdered * priceEach) nikalen. 
-- Sirf un combinations ko show karein jinki total_revenue 100,000 se zyada hai. Results ko total_revenue ke descending order mein sort karein.
-- (Hint: INNER JOIN, GROUP BY multiple columns, SUM, HAVING)

select *   from  products;
select * from orderdetails;

select  p.productLine,p.productVendor, count(od.quantityOrdered) as total_quantity_sold, sum(od.quantityOrdered * od.priceEach) as total_revenue
from products p inner join orderdetails od 
on p.productCode =  od.productCode
group by p.productLine,p.productVendor
having total_revenue > 100000 
order by total_revenue DESC;



-- Question 2: Customers Who Made Purchases in Both 2003 and 2004 (customers, orders tables)
-- Un customerName aur customerNumber ko nikalen jinhone 2003 aur 2004 dono saalon mein kam se kam ek order place kiya ho.
-- (Hint: INNER JOIN (same tables ko do bar join kar sakte ho ya subquery use kar sakte ho with AND EXIST or IN with year filtering in subqueries.
 -- GROUP BY and HAVING COUNT(DISTINCT YEAR()) could also work. Tum INNER JOIN context mein solve karna)
 
SELECT
    c.customerName,
    c.customerNumber
FROM
    customers c
INNER JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE
    YEAR(o.orderDate) IN (2003, 2004) -- Pehle sirf 2003 ya 2004 ke orders filter kiye
GROUP BY
    c.customerNumber, c.customerName -- Customer par group kiya
HAVING
    COUNT(DISTINCT YEAR(o.orderDate)) = 2; -- Sirf un customers ko rakha jinhone 2 unique saalon mein (2003 & 2004) order kiya


-- Question 3: Employees Managing Customers with Specific Credit Limits (employees, customers tables)
-- Un firstName, lastName, aur jobTitle nikalen un employees ke jinhone aise customers ko manage kiya hai jinka creditLimit 50,000 se 70,000 
-- (inclusive) ke beech mein hai, aur un employees ne kam se kam 3 aise unique customers ko handle kiya ho.
-- (Hint: INNER JOIN, WHERE with BETWEEN, GROUP BY, COUNT(DISTINCT), HAVING)

SELECT
    e.firstName,
    e.lastName,
    e.jobTitle,
    COUNT(DISTINCT c.customerNumber) AS num_customers_in_credit_range -- Optional: customers count bhi dikhana
FROM
    employees e
INNER JOIN
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
WHERE
    c.creditLimit BETWEEN 50000 AND 70000 -- Correct use of BETWEEN
GROUP BY
    e.employeeNumber, e.firstName, e.lastName, e.jobTitle
HAVING
    COUNT(DISTINCT c.customerNumber) >= 3;