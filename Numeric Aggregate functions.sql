SELECT * FROM orderdetails;

SELECT sum(quantityOrdered) , avg(priceEach) from orderdetails;

SELECT  * FROM products;

SELECT avg(quantityOrdered) FROM orderdetails;

SELECT round(avg(quantityOrdered),1) FROM orderdetails;

SELECT ceil(avg(quantityOrdered)) FROM orderdetails;

SELECT floor(avg(quantityOrdered)) FROM orderdetails;

SELECT max(quantityInStock) AS MAX_QTY,  avg(MSRP) AS AVG_MSRP, min(buyPrice) AS LOW_PRICE FROM products;


-- Aggregate Functions Practice Questions
-- Q1. Find the total quantity of products ordered for each productCode.
select * from products;
select * from orderdetails;
SELECT productCode, SUM(quantityOrdered) AS total_quantity
FROM orderdetails
GROUP BY productCode;

-- Q2. List productCodes where the average priceEach is more than 50.
SELECT productCode, avg(priceEach) AS avg_price from  orderdetails
GROUP BY productCode
having avg(priceEach) >50;

-- Q3. Show productCodes where the total quantity ordered is above 500.
SELECT productCode, SUM(quantityOrdered) AS total_quantity
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > 500;

-- Q4. Display the product with the highest MSRP and the lowest buyPrice.
SELECT MAX(MSRP) AS highest_msrp, MIN(buyPrice) AS lowest_buy_price
FROM products;

-- Q5. Round the average quantityOrdered to 2 decimal places for each orderNumber.
SELECT orderNumber, ROUND(AVG(quantityOrdered), 2) AS avg_qty
FROM orderdetails
GROUP BY orderNumber;


-- Q6. List orders where the total revenue (quantityOrdered * priceEach) exceeds $10,000.
SELECT orderNumber, SUM(quantityOrdered * priceEach) AS total_revenue
FROM orderdetails
GROUP BY orderNumber
HAVING SUM(quantityOrdered * priceEach) > 10000;

-- Q7. For each productCode, show the max and min quantityOrdered.
SELECT productCode, MAX(quantityOrdered) AS high_quantity, MIN(quantityOrdered) AS low_quantity FROM orderdetails
GROUP BY  productCode;

-- Q8. Find how many distinct orderNumbers exist in the orderdetails table.
SELECT COUNT(DISTINCT orderNumber) AS total_unique_orders
FROM orderdetails;

-- Q9. Show all product lines from the products table where the average MSRP is greater than 75.
SELECT productLine, avg(MSRP) AS avg_msrp from products
group by productLine
having avg(MSRP) > 75;

-- Q10. Find products whose quantityInStock is below the average quantityInStock of all products.
SELECT productName, quantityInStock
FROM products
WHERE quantityInStock < (SELECT AVG(quantityInStock) FROM products);





-- --Aggregate Functions – Practice Set 2 (Intermediate/Logical)
-- Find the total revenue (quantityOrdered × priceEach) for each productCode. Show only those products with revenue > 20,000.
select productCode, sum(quantityOrdered * priceEach) AS total_revenue FROM  orderdetails
group by productCode
having sum(quantityOrdered*priceEach) > 20000;

-- Show the top 5 productCodes with the highest average selling price (priceEach).
select productCode, avg(priceEach) AS avg_selling_price from orderdetails
group by productCode
order by avg_selling_price DESC
limit 5;


-- List the orderNumbers where more than 3 products were ordered (i.e., count of productCode > 3).
select orderNumber, count(productCode) AS pd_code from orderdetails
group by orderNumber
having count(productCode) >3;

-- Find the productCode(s) with the lowest average quantity ordered.
select * from  orderdetails;
select productCode, avg(quantityOrdered) as avg_of_qty from orderdetails
group by productCode
order by avg_of_qty ASC;
--   OR  limit 1;

-- Show productCodes where the minimum selling price (priceEach) is below 30.
select productCode, min(priceEach) AS low_price from orderdetails
group by productCode
having min(priceEach) < 30;

-- Find the average revenue per order (across all orders).
SELECT 
    ROUND(SUM(quantityOrdered * priceEach) / COUNT(DISTINCT orderNumber), 2) 
    AS avg_revenue_per_order
FROM orderdetails;

-- List the products (from products table) whose buyPrice is more than the average buyPrice of all products.
select  * from products;
select productName, buyPrice FROM products
where buyPrice > (select avg(buyPrice) from products);

-- Show productLine(s) with the highest average MSRP. Only show the top 2 productLines.
SELECT productLine, AVG(MSRP) AS avg_msrp 
FROM products
GROUP BY productLine
ORDER BY avg_msrp DESC
LIMIT 2;

-- For each orderNumber, find the maximum quantityOrdered and the corresponding productCode.
SELECT orderNumber, MAX(quantityOrdered) AS max_qty
FROM orderdetails
GROUP BY orderNumber;

-- Count how many products have MSRP greater than twice their buyPrice.
SELECT COUNT(*) AS product_count
FROM products
WHERE MSRP > 2 * buyPrice;





-- Q1. Find the top 3 productCodes with the highest average selling price (priceEach).
-- Hint: Use AVG(priceEach) + ORDER BY + LIMIT
SELECT productCode, AVG(priceEach) as avg_price FROM  orderdetails
group by productCode
order by avg_price DESC
limit 3;

--  Q2. List the productCodes where the average quantityOrdered is equal to the minimum average among all products.
-- Hint: Subquery — calculate min of all avg(quantityOrdered), phir match karo.
SELECT productCode, AVG(quantityOrdered) AS avg_qty
FROM orderdetails
GROUP BY productCode
HAVING AVG(quantityOrdered) = (
  SELECT MIN(avg_quantity)
  FROM (
    SELECT AVG(quantityOrdered) AS avg_quantity
    FROM orderdetails
    GROUP BY productCode
  ) AS sub
);


--  Q3. Show orderNumbers that had more than 2 distinct products AND average priceEach above 80.
-- Hint: Use COUNT(DISTINCT ...) + HAVING
SELECT orderNumber, COUNT(DISTINCT productCode) AS num_products, AVG(priceEach) AS avg_price
FROM orderdetails
GROUP BY orderNumber
HAVING COUNT(DISTINCT productCode) > 2 AND AVG(priceEach) > 80;


--  Q4. For each productLine, calculate average MSRP. Then list only the one(s) with maximum average MSRP.
-- Hint: Group first, then use subquery to compare AVG(MSRP) with MAX(AVG(...)).
SELECT productLine, AVG(MSRP) AS avg_msrp
FROM products
GROUP BY productLine
HAVING AVG(MSRP) = (
  SELECT MAX(avg_msrp) 
  FROM (
    SELECT AVG(MSRP) AS avg_msrp
    FROM products
    GROUP BY productLine
  ) AS sub
);


--  Q5. Find the orderNumber(s) that generated the highest total revenue (quantity × price).
-- Hint: Use SUM(quantityOrdered * priceEach) grouped by orderNumber, then filter by max.
select orderNumber, sum(quantityOrdered*priceEach) AS total_revenue from  orderdetails
group by orderNumber
order by total_revenue DESC;




-- List the productCode(s) whose average selling price (priceEach) is equal to the highest average among all products.
SELECT 
    productCode, AVG(priceEach) AS avg_price
FROM orderdetails
GROUP BY productCode
HAVING AVG(priceEach) = (
SELECT max(avg_price)
    FROM(
    SELECT AVG(priceEach) AS avg_price
        FROM orderdetails
        GROUP BY productCode
        ) AS sub
	);
 
 
 
 -- Find orderNumber(s) where the total quantityOrdered is equal to the lowest total quantityOrdered across all orders.
 select orderNumber,  sum(quantityOrdered) as total_qty from orderdetails
 group by orderNumber
 having sum(quantityOrdered) = (
 select min(total_qty) FROM (
 select  sum(quantityOrdered) as total_qty 
 from orderdetails 
 group by orderNumber) as sub  );
 
 
 
 -- Q3.Show productLine(s) where the average MSRP is equal to the maximum average MSRP of all productLines.
select productLine,  avg(MSRP) as avg_msrp from products
group by productLine
having avg(MSRP)  = (
select max(avg_msrp) FROM (
select avg(MSRP) as avg_msrp 
from products
group by productLine) as sub );

select *  from orderdetails;
select *  from products;

-- Q4.List orderNumber(s) where the average priceEach is less than the overall average priceEach (across all orders).
select orderNumber, avg(priceEach) as avg_price from  orderdetails
group by orderNumber
having avg(priceEach) < (
select avg(avg_price) FROM (
select avg(priceEach) as avg_price  from orderdetails
group by orderNumber)  as sub );


--  Q5.Find all productCode(s) whose minimum selling price (priceEach) is equal to the lowest price across the table.
select productCode,  min(priceEach) as  low_selling_price from  orderdetails
group by productCode
having min(priceEach) = (
select min(low_selling_price) FROM (
select min(priceEach) as low_selling_price from orderdetails
group by  productCode) as sub);


 