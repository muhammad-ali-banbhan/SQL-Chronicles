SELECT * FROM sales_data;

-- DATEDIFF
-- Calculates the number of days between two dates.

SELECT Order_date, Ship_Date, DATEDIFF(Order_date, Ship_Date) AS Days_difference 
FROM sales_data;


-- COUNT
-- Calculates the number of days between two dates.

SELECT COUNT(Order_ID) AS total_orders FROM sales_data;


-- MIN AND MAX
-- MIN() finds the smallest value; MAX() finds the largest value in a column.

SELECT  Region, MIN(Net_Sales) AS minimum_sales, MAX(Net_Sales) AS maximum_sales
FROM sales_data
GROUP BY Region;


-- SUM
-- Calculates the total (sum) of values in a numeric column.

SELECT SUM(Net_Sales) As total_sales
FROM sales_data;


-- AVERAGE
-- Returns the average (mean) of numeric values.

SELECT Region,  AVG(Profit_Loss) AS average_profit_loss 
FROM sales_data
GROUP BY Region;



-- LENGTH
-- Returns the number of characters in a string.

SELECT Customer_Name, LENGTH(Customer_Name) AS name_lenth
FROM sales_data;


-- UPPER AND LOWER
-- UPPER() converts text to uppercase.
-- LOWER() converts text to lowercase.
 
SELECT UPPER(Customer_Name) AS name_in_upper_case, LOWER(Customer_Name) AS name_in_lower_case
FROM sales_data;


-- CONCAT
-- The CONCAT() function is used to combine two or more strings (columns, values, etc.) into one single string.

SELECT CONCAT(Salesman, "5262") As salesman_username
FROM sales_data;

-- CONCAT_WS()
-- It means: "Concatenate With Space" – and skip NULL values.

-- SELECT CONCAT_WS(' ', first_name, middle_name, last_name) AS full_name
-- FROM users;


-- IF() / CASE – Conditional Logic
-- Creates conditional expressions like IF/ELSE.

SELECT Order_ID,
       IF(Net_Sales > 5000, 'High', 'Low') AS Sale_Category
FROM sales_data;


SELECT Order_ID,
       CASE 
           WHEN Net_Sales > 5000 THEN 'High'
           WHEN Net_Sales > 2000 THEN 'Medium'
           ELSE 'Low'
       END AS Sale_Level
FROM sales_data;


-- ROUND() – Round Numeric Values
-- Rounds numeric values to the nearest integer or decimal place.

SELECT ROUND(Net_Sales, 2) FROM sales_data;
