SELECT * FROM orders;

SELECT month(orderDate), monthname(orderDate) FROM orders;

SELECT year(orderDate) , dayname(shippedDate),  shippedDate FROM  orders;


SELECT abs(datediff(orderDate, shippedDate)) FROM orders;



#Date Functions Practice Questions (10 Questions)
#Show all orders that were placed in the month of December.
SELECT  *, monthname(orderDate) As month_name FROM orders
WHERE monthname(orderDate) = "December";

SELECT * , monthname(orderDate) AS order_month, (shippedDate) AS shipped_month  FROM orders
WHERE monthname(shippedDate) = "April" AND  monthname(orderDate) = "March";

#Find orders where the shipping date and order date fall in the same month.
SELECT *FROM orders
WHERE MONTH(orderDate) = MONTH(shippedDate)
  AND YEAR(orderDate) = YEAR(shippedDate);

#List orders that took more than 7 days to ship.
SELECT * FROM orders
WHERE DATEDIFF(shippedDate, orderDate) > 7;

SELECT *  FROM orders
WHERE datediff(orderDate, shippedDate) < 7;

#Show the names of the weekdays on which orders were placed.
SELECT dayname(orderDate) FROM orders;

#List order numbers and how many days it took to ship each order (positive value).
SELECT orderNumber, abs(datediff(orderDate,shippedDate)) AS days_take FROM orders;

SELECT  orderNumber , abs(datediff(shippedDate,  orderDate)) AS days_take FROM orders;

#Find orders where the shipping year is different from the order year.
SELECT * FROM orders
WHERE year(orderDate) != year(shippedDate);

#Get the total number of orders placed each month.
SELECT count(orderNumber) AS  total_orders , month(orderDate)  AS month_num FROM orders
GROUP BY month_num;

SELECT count(shippedDate) AS shipped_orders, count(orderDate) AS orders FROM orders;

#List all orders placed on a Monday or Friday.
SELECT dayname(orderDate) FROM orders
WHERE dayname(orderDate) = "Monday" OR dayname(orderDate) = "Friday";

SELECT dayname(shippedDate) FROM orders
WHERE dayname(shippedDate) = "Tuesday"  OR dayname(shippedDate) = "Saturday";

#Show the month name and number of orders placed in each month.
SELECT count(orderNumber) AS  total_orders , monthname(orderDate)  AS month_name FROM orders
GROUP BY month_name;

#Find orders where the order date is after the shipped date (i.e., wrongly entered).
SELECT * FROM orders
WHERE orderDate > shippedDate;






#Date Functions – Level 2 Tricky/Logical Practice Set
#Q1.Find all orders that were placed in the first week of any month.
SELECT orderNumber, orderDate
FROM orders
WHERE DAY(orderDate) <= 7;

#Q2.List orders where the shipping month and order month are different.
SELECT * FROM orders
WHERE month(shippedDate) != month(orderDate);


#Q3.Show the orders that were placed on a weekend (Saturday or Sunday).
SELECT *, weekday(orderDate) FROM orders
WHERE  dayname(orderDate) IN ("Saturday","Sunday");

#Q4.Find how many orders were shipped in each year. Show year and total orders.
SELECT YEAR(shippedDate) AS year, COUNT(*) AS total_orders
FROM orders
GROUP BY YEAR(shippedDate);


#Q5.List orders where the shipping took more than 10 days.
SELECT * FROM orders
WHERE datediff(shippedDate, orderDate) > 10;

#Q6.Find orders placed in Q1 (Jan–Mar) of any year.
SELECT * FROM orders 
WHERE month(orderDate) BETWEEN 1 AND 3;   

#Q7.Show orders where the day of shipping is before the day of ordering (not full date, just day of month).
SELECT * FROM orders
WHERE dayofmonth(shippedDate) < dayofmonth(orderDate) ;

#Q8.Display all orders where the order date was in the last 5 days of the month (i.e., date = 26 to 31).
SELECT * FROM orders
WHERE DAY(orderDate) >= 26;

#Q9.Find orders that were placed on the same day of week as their shipping date (e.g., both Monday).
SELECT * FROM  orders
WHERE dayname(orderDate) = dayname(shippedDate);


#Q10.List the top 3 months with the highest number of orders.
SELECT MONTHNAME(orderDate) AS month, COUNT(*) AS total_orders
FROM orders
GROUP BY MONTH(orderDate), MONTHNAME(orderDate)
ORDER BY total_orders DESC
LIMIT 3;








-- Date Functions – Logical Practice (Set 2)
-- Q1. Show all orders that were placed in the last week of any month (e.g., date = 25–31).
SELECT * FROM orders
WHERE DAY(orderDate) >=25;

-- Q2. List orders that were shipped before they were placed (data error check).
SELECT * FROM orders
WHERE shippedDate < orderDate ;

-- Q3. Show total number of orders placed on each weekday (e.g., Monday, Tuesday, ...).
SELECT dayname(orderDate) AS weekday, COUNT(*) AS total_orders
FROM orders
GROUP BY dayname(orderDate);

-- Q4. Find the average number of days it took to ship an order.
SELECT avg(datediff(orderDate,shippedDate)) AS avg_days FROM orders;

-- Q5. Display orders where the order year is 2005 and shipping month is after June.
SELECT * FROM orders
WHERE year(orderDate) = 2005 AND month(shippedDate) > 6;

-- Q6. Find orders placed on a weekend and shipped on a weekday.
SELECT dayofweek(orderDate) AS order_day,  dayofweek(shippedDate) AS ship_day FROM orders
WHERE dayofweek(orderDate) BETWEEN 6 AND 7  AND dayofweek(shippedDate) BETWEEN 1 AND  5; 

-- Q7. Show all orders placed in Q2 (April–June).
SELECT  * FROM orders
WHERE month(orderDate) between 4 AND 6;

-- Q8. List orders where the shipping date and order date fall in the same day of week but different weeks.
SELECT * FROM orders
WHERE dayofweek(orderDate) = dayofweek(shippedDate)
AND WEEK(orderDate) != WEEK(shippedDate);

-- Q9. Find orders that were delivered (shipped) in December, regardless of order month.
SELECT * FROM orders
WHERE monthname(shippedDate) = "December";

-- Q10. List the top 2 weekdays when most orders were placed.
SELECT dayname(orderDate) AS day_, COUNT(*) AS total_orders FROM orders
group by day_
order by total_orders DESC
limit 2;