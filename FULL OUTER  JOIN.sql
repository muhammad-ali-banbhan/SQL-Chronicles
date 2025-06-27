
-- Understanding FULL OUTER JOIN in SQL

-- FULL OUTER JOIN (ya sirf FULL JOIN) LEFT JOIN aur RIGHT JOIN ka combination hai.

-- Concept:

-- FULL OUTER JOIN ka matlab hai:

-- Left table ke saare records return karo.

-- Right table ke saare records return karo.

-- Agar dono tables mein matching records hain, toh unko combine karo.

-- Agar left table ke kisi record ke liye right table mein koi matching record nahi milta, toh left table ka record return karo, 
-- aur right table ke columns ke liye NULL values show karo.

-- Agar right table ke kisi record ke liye left table mein koi matching record nahi milta, toh right table ka record return karo, 
-- aur left table ke columns ke liye NULL values show karo.


Syntax:

SELECT
    column1,
    column2,
    ...
FROM
    LeftTable
FULL OUTER JOIN
    RightTable
ON
    LeftTable.common_column = RightTable.common_column;


-- Key Difference from LEFT JOIN and RIGHT JOIN:

-- LEFT JOIN: Returns all rows from the left table, and matching rows from the right table.

-- RIGHT JOIN: Returns all rows from the right table, and matching rows from the left table.

-- FULL OUTER JOIN: Returns all rows from both tables, with NULLs where there is no match.



-- MySQL ka Equivalent of FULL OUTER JOIN
-- Part 1: All Customers and their matching Orders (covers Left-only and Matching)
SELECT
    c.customerName,
    o.orderNumber,
    o.orderDate
FROM
    customers c
LEFT JOIN
    orders o ON c.customerNumber = o.customerNumber

UNION ALL -- Dono parts ke results ko combine karta hai, duplicates ko bhi shamil karta hai

-- Part 2: All Orders that do NOT have a matching Customer (covers Right-only)
SELECT
    c.customerName, -- c.customerName yahan NULL hoga agar match nahi mila
    o.orderNumber,
    o.orderDate
FROM
    customers c
RIGHT JOIN
    orders o ON c.customerNumber = o.customerNumber
WHERE
    c.customerNumber IS NULL; -- Ye condition ensures karti hai ke sirf woh rows aayen jo RIGHT JOIN mein RIGHT side (orders) par hain
                              -- lekin LEFT side (customers) par koi match nahi mila (yani customerName NULL hai)




-- Practice Questions for MySQL FULL OUTER JOIN Workaround

-- Question 1: All Customers and All Orders (customers & orders tables)
-- Saare customerName, orderNumber, aur orderDate nikalen. Is mein woh customers bhi shamil hon jinhone koi order nahi kiya, 
-- aur woh orders bhi shamil hon jinke liye koi customer record nahi milta (hypothetically).

select c.customerName, o.orderNumber, o.orderDate
from customers c left join orders o
on  c.customerNumber =o.customerNumber

UNION ALL

select c.customerName, o.orderNumber, o.orderDate
from customers c right join orders o
on c.customerNumber = o.customerNumber
where c.customerNumber IS NULL;



-- Question 2: All Products and All Order Details (products & orderdetails tables)
-- Saare productName, productLine, orderNumber, aur quantityOrdered nikalen. Is mein woh products bhi shamil hon jo abhi tak kisi
--  order mein nahi hain, aur woh orderdetails records bhi shamil hon jinke liye koi product record nahi milta (hypothetically).

select  p.productName, p.productLine, od.orderNumber, od.quantityOrdered
from products p left join orderdetails od
ON p.productCode  = od.productCode

UNION ALL

select  p.productName, p.productLine, od.orderNumber, od.quantityOrdered
from products p right join orderdetails od
ON p.productCode  = od.productCode
where p.productCode IS  NULL;