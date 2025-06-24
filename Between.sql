select * from orders;

select * from orders
where orderNumber between 10100 and 10150;

select * from  orders
where (orderDate between "2003-08-01" AND "2003-12-31") AND (status = "Shipped") ;

select * from  orderdetails
where (orderLineNumber between 5 and  20 ) AND  (quantityOrdered > 50) or (priceEach < 100);





-- BETWEEN – Practice Set (10 Questions)

-- Q1. List all orders placed between 2004-01-01 and 2004-03-31.
select * from orders;
select orderNumber,orderDate from orders
where orderDate between "2004-01-01" and "2004-03-31";

-- Q2. Show order details where priceEach is between 80 and 150.
select * from orderdetails
where priceEach between 80 and 150;

-- Q3. Find all orderLineNumbers that lie between 10 and 25 and have a quantityOrdered above 40.
select orderLineNumber, quantityOrdered from orderdetails
where (orderLineNumber between 10 and 25) AND (quantityOrdered > 40);

-- Q4. Display orders where orderNumber is between 10120 and 10150, and the status is 'Resolved'.
select * from orders
where (orderNumber between 10120 and 10150) AND (status= "Resolved");

-- Q5. List all orders that were shipped between '2005-05-01' and '2005-08-31'.
select * from orders
where shippedDate between '2005-05-01' and '2005-08-31';


-- Q6. Find all orderdetails where: orderLineNumber is between 5 and 15 AND either priceEach is less than 50 OR quantityOrdered is greater than 80
select * from orderdetails
where (orderLineNumber between 5 and 15) and (priceEach < 50 OR quantityOrdered > 80);

-- Q7. Show orderNumbers where the orderDate is between '2003-11-01' and '2003-11-30' and status is NOT 'Cancelled'.
select orderNumber, orderDate, status from orders
where (orderDate between '2003-11-01' and '2003-11-30') and (status != "Cancelled");

-- Q8. Find all orderdetails where both quantityOrdered and priceEach fall in between 30–100.
select * from orderdetails
where quantityOrdered and priceEach between 30 and 100;

SELECT * FROM orderdetails
WHERE quantityOrdered BETWEEN 30 AND 100
AND priceEach BETWEEN 30 AND 100;

-- Q9. List all orders where the shipping date is after the order date, but within 5 days only (hint: use DATEDIFF + BETWEEN).
SELECT * FROM orders
WHERE DATEDIFF(shippedDate, orderDate) BETWEEN 1 AND 5;

-- Q10. Show orders placed in the last 7 days of any month (i.e., orderDate day between 25 and 31).

SELECT * FROM orders
WHERE DAY(orderDate) BETWEEN 25 AND 31;







-- Q1. Show all orders placed between the 15th and 25th of any month.
select orderDate from orders
where DAY(orderDate) between 15 and  25;
 
-- Q2. List all orders where the shippedDate is within 7 days after the orderDate (inclusive).
select *, shippedDate, orderDate from  orders
WHERE datediff(shippedDate, orderDate) between  0 and 7;

-- Q3. Find orders where the order date falls in Q2 (April to June) of any year.
select *, orderDate from orders
where month(orderDate) between 4 and 6;

-- Q4. List all orderdetails where priceEach is between 80 and 150, and quantityOrdered is between 20 and 60.
select * from  orderdetails
where (priceEach between 80 and 150) and (quantityOrdered between 20 and 60);

-- Q5. Show orders placed between '2004-07-01' and '2004-12-31' AND the status is either 'Shipped' or 'In Process'.
select * from  orders
where (orderDate between '2004-07-01' and '2004-12-31') and (status = "Shipped" or status = "In Process");

-- Q6. Find all orders where shipping date is within 5 days before the order date. (Hint: use DATEDIFF and BETWEEN on negative values)
SELECT * FROM orders
WHERE DATEDIFF(shippedDate, orderDate) BETWEEN -5 AND -1;
 
-- Q7. List orderdetails where orderLineNumber lies between 1 and 10, but priceEach is NOT between 50 and 100.
select * from orderdetails
where orderLineNumber between 1 and 10  and (priceEach not between 50 and 100);

-- Q8. Show orders where the order date is in the last 5 days of any month (e.g., 27–31).
select * from orders 
where day(orderDate) between 27 and 31;

-- Q9. Display orders where year is 2005 AND the order day of month is between 10 and 20.
select * from orders
where year(orderDate) = 2005 and  (dayofmonth(orderDate) between 10 and 20);

-- Q10. Find all orders where the difference between shippedDate and orderDate is between 3 and 10 days.
select orderNumber,  orderDate, shippedDate from orders
where datediff(shippedDate, orderDate) between 3  and 10;
