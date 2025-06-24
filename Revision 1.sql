select * from customers;

select  * from movies;



-- SQL Practice Questions

-- Question 1: Basic Selection & Filtering (from customers table)
-- customers table se un saare customers ki customerName, city, aur country nikalen jo USA se hain aur jinka creditLimit 50000 se zyada hai. Results ko customerName ke hisaab se ascending order mein sort karein.
select * from classicmodels.customers;
select  customerName, city,  country, creditLimit from  customers
where country = "USA" and  creditLimit > 50000
order by customerName asc;



-- Question 2: Aggregation & Grouping (from orders & orderdetails tables)
-- Har status (e.g., Shipped, In Process, On Hold) ke hisaab se total number of orders count karein orders table se. Sirf un statuses ko show karein jinka order count 20 se zyada hai.
select count(*) as total_orders, status from orders
group by status
having count(*) > 20;


-- Question 3: Date Functions & Calculation (from orders table)
-- orders table se un saare orders ka orderNumber, orderDate, aur shippedDate nikalen jinko ship hone mein 5 din se zyada lage (yaani DATEDIFF between shippedDate and orderDate is greater than 5). Sirf un orders ko consider karein jinka status 'Shipped' hai.
select orderNumber, orderDate,  shippedDate, status from orders
where datediff(shippedDate,  orderDate) > 5 and status = "shipped";


-- Question 4: CASE Statement (from employees table)
-- employees table se har employee ka firstName, lastName, aur jobTitle nikalen. salary ke basis par ek naya column Salary_Category banayein:

Agar salary 80,000 se zyada hai, toh 'High Salary'.
Agar salary 50,000 aur 80,000 ke beech mein hai (inclusive), toh 'Medium Salary'.
Agar salary 50,000 se kam hai, toh 'Low Salary'.;

-- Question 5: LIKE & Wildcards (from products table)
-- products table se un saare productName aur productLine ko nikalen jinke productName mein word 'Ford' aata hai (case-insensitive search).

select * from products;
select productName, productLine from  products
where  productName LIKE "%Ford%";






-- SQL Practice Questions - Set 2
-- Question 1: Subquery in WHERE Clause (from orders and customers tables)
-- Un customerName aur city ko nikalen customers table se, jinhone aise orders diye hain jinka status 'On Hold' hai. (Hint: customerNumber ko join column ke taur par use kar sakte hain ya subquery mein.)
SELECT
    customerName,
    city
FROM
    customers
WHERE
    customerNumber IN (SELECT customerNumber FROM orders WHERE status = 'On Hold');
    
-- Question 3: Nested Aggregates & Filtering (from orderdetails table)
-- Har productCode ke liye average_quantity_ordered nikalen. Sirf un productCode ko show karein jinka average_quantity_ordered overall average quantity ordered se zyada hai. (Hint: Ek subquery mein overall average calculate hoga).
SELECT
    productCode,
    AVG(quantityOrdered) AS average_quantity_ordered
FROM
    orderdetails
GROUP BY
    productCode
HAVING
    AVG(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails);
    
-- Question 4: Date Functions & GROUP BY (from orders table)
--  year aur month ke hisaab se total number of orders count karein. Results ko year ke ascending aur phir month ke ascending order mein sort karein. MONTH() aur YEAR() functions ka use karein.
SELECT
    YEAR(orderDate) AS order_year,
    MONTH(orderDate) AS order_month,
    COUNT(orderNumber) AS total_orders_count
FROM
    orders
GROUP BY
    YEAR(orderDate),
    MONTH(orderDate)
ORDER BY
    order_year ASC,
    order_month ASC;
    
-- Question 5: IN with Subquery (from products and orderdetails tables)
-- Un productName aur productLine ko nikalen products table se jo kabhi order nahi kiye gaye hain. (Hint: productCode ko join column ke taur par use karein.)
select productName, productLine from products
where productCode not in (select productCode from orderdetails);





-- SQL Practice Questions - Set 3
-- Question 1: Multiple AND/OR and BETWEEN (from products table)
-- products table se un saare productName, productLine, aur MSRP ko nikalen jinki productLine ya toh 'Classic Cars' hai ya 'Motorcycles' hai, aur unka MSRP 50 se 100 ke beech mein hai (inclusive). Results ko productName ke hisaab se ascending order mein sort karein.
select * from products;
select productName, productLine, MSRP from products
where (productLine = "Classic Cars" or productLine = "Motorcycles") AND (MSRP between 50 and  100)
order by productName ;

-- Question 2: COUNT(DISTINCT...) and GROUP BY (from orders table)
-- Har status (e.g., Shipped, In Process) ke hisaab se orders table mein kitne unique customers hain jinhone us particular status ke order place kiye hain, woh count karein.

select * from orders;
select count(distinct orderNumber) as  unique_orders, status, count(*)  as total_orders from orders
group by status;

-- Question 3: CASE Statement with Date Functions (from orders table)
-- orders table se orderNumber, orderDate, aur shippedDate nikalen. Ek naya column Delivery_Status banayein:
-- Agar shippedDate requiredDate se pehle hai, toh 'Delivered Early'.
-- Agar shippedDate requiredDate ke barabar hai, toh 'Delivered On Time'.
-- Agar shippedDate requiredDate ke baad hai, toh 'Delivered Late'.
-- Agar shippedDate NULL hai, toh 'Not Shipped Yet'.

SELECT
    orderNumber,
    orderDate,
    shippedDate,
    requiredDate, -- requiredDate ko bhi select kar liya clarity ke liye
    CASE
        WHEN shippedDate IS NULL THEN 'Not Shipped Yet'        -- NULL check pehle
        WHEN shippedDate < requiredDate THEN 'Delivered Early'  -- Pehle Delivered Early
        WHEN shippedDate = requiredDate THEN 'Delivered On Time' -- Phir On Time
        WHEN shippedDate > requiredDate THEN 'Delivered Late'   -- Last mein Delivered Late
        ELSE 'Unknown Status' -- Ek fallback case bhi de sakte hain, agar koi aur condition na mile
    END AS Delivery_Status
FROM
    orders;
    
    
-- Question 4: Subquery in SELECT (from customers table)
-- customers table se har customer ka customerName, city, aur us customer ke total orders ka count nikalen. 
-- Total orders ka count ek alag column mein show ho, jo ek scalar subquery se aaye. (Hint: customerNumber ko link karein).
SELECT
    c.customerName,
    c.city,
    (SELECT COUNT(o.orderNumber)
     FROM orders o
     WHERE o.customerNumber = c.customerNumber) AS total_orders_count
FROM
    customers c;
    
    
-- Question 5: IS NULL/IS NOT NULL and ORDER BY (from orders table)
-- orders table se un orders ka orderNumber, orderDate, aur comments nikalen jinke comments NULL nahi hain. Phir un orders ko sort karein jinke comments
 -- NULL hain sabse pehle, aur phir baaki orders ko orderDate ke descending order mein. (Hint: NULL values ORDER BY mein apni jagah leti hain). 
SELECT
    orderNumber,
    orderDate,
    comments
FROM
    orders
WHERE
    comments IS NOT NULL  -- Comments NULL nahi hone chahiye
ORDER BY
    CASE
        WHEN comments IS NULL THEN 0  -- Comments NULL hain to sabse pehle (rank 0)
        ELSE 1                        -- Comments NULL nahi hain to baad mein (rank 1)
    END ASC,                      -- is CASE expression par ascending sort (0 phir 1)
    orderDate DESC;               -- Phir orderDate par descending sort