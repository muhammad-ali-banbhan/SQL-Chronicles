
-- Understanding LEFT JOIN in SQL
-- LEFT JOIN (ya LEFT OUTER JOIN) INNER JOIN se thoda mukhtalif hai. Yaad hai INNER JOIN sirf woh records deta hai jo dono tables mein match karte hain? 
-- LEFT JOIN ka concept isse aage badhta hai.

-- Concept:
-- LEFT JOIN ka matlab hai:
-- FROM clause mein jo pehli table likhi hoti hai (jise "left table" kehte hain), uske saare records return karo.
-- Aur uske saath, ON clause ki condition ke mutabiq right table se matching records ko bhi shamil karo.
-- Agar left table ke kisi record ke liye right table mein koi matching record nahi milta, toh bhi left table ka record toh return hoga,
--  lekin right table ke columns ke liye NULL values show hongi.


-- Syntax:

SELECT
    column1,
    column2
FROM
    LeftTable -- Yeh LEFT Table hai
LEFT JOIN
    RightTable -- Yeh RIGHT Table hai
ON
    LeftTable.common_column = RightTable.common_column;

-- Key Difference from INNER JOIN:

-- INNER JOIN: Returns only matching rows from both tables.
-- LEFT JOIN: Returns all rows from the left table, and matching rows from the right table. If no match in right table, NULL for right table's columns.


-- Example With Our Tables: customers (Left) and orders (Right)
-- Agar hum yeh chahen ke saare customers ki list mile, chahe unhone koi order kiya ho ya na kiya ho, aur agar order kiya hai toh unki order details bhi show ho.

SELECT
    c.customerName,
    o.orderNumber,
    o.orderDate,
    o.status
FROM
    customers c           -- Ye hamari LEFT Table hai
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber; -- Ye hamari RIGHT Table hai
    
-- Output Kya Hoga?

-- Har customerName dikhega.
-- Agar us customer ne order kiya hai, toh uski orderNumber, orderDate, status dikhega.
-- Agar us customer ne koi order nahi kiya hai, tab bhi uska customerName dikhega, lekin orderNumber, orderDate, status columns mein NULL show hoga.




-- SQL Practice Questions - LEFT JOIN

-- Question 1: All Customers and Their First Order (customers & orders tables)
-- Un saare customers ka customerName, customerNumber, aur agar unhone koi order kiya hai toh us order ka orderNumber aur orderDate nikalen. 
-- Agar kisi customer ne koi order nahi kiya, tab bhi woh list mein shamil hona chahiye.

select c.customerName, c.customerNumber, o.orderNumber, o.orderDate
FROM customers c LEFT JOIN orders o 
ON  c.customerNumber = o.customerNumber;


-- Question 2: All Products and Their Order Details (Even if Not Ordered) (products & orderdetails tables)
-- Saare productName, productLine nikalen, aur agar woh product kisi order mein shamil hai toh us order ki orderNumber aur quantityOrdered bhi 
-- show karein. Un products ko bhi dikhayen jo abhi tak kisi order mein nahi hain.

select  * from products;
select * from  orderdetails;

select p.productName, p.productLine, od.orderNumber, od.quantityOrdered
FROM  products p left join orderdetails od
ON p.productCode = od.productCode;

-- Question 3: Employees and Their Assigned Customers (Including Those Without Customers) (employees & customers tables)
-- Har employee ka firstName, lastName, aur agar usne koi customer handle kiya hai toh us customer ka customerName nikalen. 
-- Un employees ko bhi dikhayen jinhe abhi tak koi customer assign nahi hua hai.

select e.firstName, e.lastName, c.customerName
from employees e left join customers c
on e.employeeNumber = c.salesRepEmployeeNumber;


-- Question 4: Identify Products Never Ordered (products & orderdetails tables)
-- Un productName aur productCode ko nikalen jinko ab tak kabhi order nahi kiya gaya hai.
-- (Hint: LEFT JOIN ka use karein aur phir WHERE clause mein IS NULL check karein.)

select p.productName, p.productCode
FROM products p left  join  orderdetails od
on p.productCode = od.productCode
where od.orderNumber IS NULL;  