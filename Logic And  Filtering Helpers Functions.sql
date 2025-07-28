
--  Logic & Filtering Helpers

-- IFNULL() – Handle Missing Data
-- Replaces NULL values with a default.

SELECT IFNULL(Profit_Loss, 0) AS safe_profit FROM sales_data;


-- CASE Statement – Conditional Logic
-- Allows multi-condition logic like IF-ELSE in SQL.

SELECT Order_ID,
       CASE 
           WHEN Net_Sales >= 5000 THEN 'High Sale'
           WHEN Net_Sales >= 2000 THEN 'Medium Sale'
           ELSE 'Low Sale'
       END AS Sale_Category
FROM sales_data;



-- ROUND() / CEIL() / FLOOR() – Control Decimals
-- ROUND() = Nearest decimal
-- CEIL() = Round up
-- FLOOR() = Round down

SELECT ROUND(Net_Sales, 2), CEIL(Net_Sales), FLOOR(Net_Sales)
FROM sales_data;



--  MOD() – Remainder of Division (Useful for grouping logic)
-- Returns the remainder of one number divided by another.

SELECT Order_ID, MOD(Order_ID, 2) AS even_or_odd
FROM sales_data;


-- RAND() – Generate Random Number
-- Returns a random number between 0 and 1.

SELECT Customer_Name, 
       CASE WHEN RAND() < 0.5 THEN 'Male' ELSE 'Female' END AS gender
FROM sales_data;
