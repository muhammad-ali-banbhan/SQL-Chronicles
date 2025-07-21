-- ROW_NUMBER()

SELECT
    brand,
    mobile_model,
    transaction_id,
    (units_sold * price_per_unit) AS transaction_revenue,
    ROW_NUMBER() OVER (PARTITION BY brand ORDER BY (units_sold * price_per_unit) DESC) AS revenue_rank_in_brand_per_transaction
FROM
    mobile_sales;
    
    
    
-- RANK()


    SELECT
    brand,
    mobile_model,
    transaction_id,
    (units_sold * price_per_unit) AS transaction_revenue,
    RANK() OVER (PARTITION BY brand ORDER BY (units_sold * price_per_unit) DESC) AS revenue_rank_in_brand_per_transaction
FROM
    mobile_sales;
    
    
    
-- DENSE_RANK()

SELECT
    brand,
    mobile_model,
    transaction_id,
    (units_sold * price_per_unit) AS transaction_revenue,
    DENSE_RANK() OVER (PARTITION BY brand ORDER BY (units_sold * price_per_unit) DESC) AS revenue_rank_in_brand_per_transaction
FROM
    mobile_sales;
    
    
    
    
    
    -- 2. Value Functions: LAG(), LEAD()
    
    -- LAG()
    
    SELECT
    transaction_id,
    transaction_date,
    brand,
    units_sold,
    LAG(units_sold, 1, 0) OVER (PARTITION BY brand ORDER BY transaction_date) AS previous_units_sold
FROM
    mobile_sales;
    
    -- LEAD()
    
    SELECT
    transaction_id,
    transaction_date,
    city,
    customer_ratings,
    LEAD(customer_ratings, 1, 0.0) OVER (PARTITION BY city ORDER BY transaction_date) AS next_customer_rating
FROM
    mobile_sales;
    
    
-- 3. Aggregate Window Functions (Running Totals, Moving Averages): SUM(), AVG(), COUNT() (with OVER)

-- SUM() OVER (...) (Running Total):

SELECT
    transaction_id,
    city,
    transaction_date,
    (units_sold * price_per_unit) AS transaction_revenue,
    SUM(units_sold * price_per_unit) OVER (PARTITION BY city ORDER BY transaction_date) AS running_city_revenue
FROM
    mobile_sales;
    
    
    -- AVG() OVER (...) (Moving Average / Partition Average):
    
    SELECT
    transaction_id,
    mobile_model,
    customer_ratings,
    AVG(customer_ratings) OVER (PARTITION BY mobile_model) AS avg_model_rating
FROM
    mobile_sales;
    
    
    
    
    
    
    
    
    
    
    
    
    -- PRACTICE 
    
-- ROW_NUMBER() for Top Sales per City
-- Question: Display all sales data (including transaction_id, city, mobile_model, and total_revenue which is units_sold * price_per_unit) along with a 
-- rank for each mobile_model based on its total_revenue within each city. The rank should be unique for each transaction within its city.

select transaction_id, city, mobile_model, (units_sold * price_per_unit) AS total_revenue,
ROW_NUMBER() OVER(PARTITION BY city order by (units_sold * price_per_unit)) AS rank_for_each_mobile_model
from mobile_sales;



-- AVG() as a Window Function for Brand Performance
-- Question: For each transaction, display the transaction_id, brand, mobile_model, transaction_revenue (calculated as units_sold * price_per_unit),
--  and the average transaction_revenue for that specific brand across all its transactions.

select transaction_id, brand, mobile_model,(units_sold * price_per_unit) AS  transaction_revenue , 
AVG(units_sold * price_per_unit) OVER (PARTITION BY brand) AS avg_brand_transaction_revenue
FROM
    mobile_sales;



-- Question 21: LAG() for Day-over-Day Comparison
-- Question: For each transaction, display its transaction_id, transaction_date, city, total_revenue. Also, include the total_revenue of the previous 
-- transaction for that specific city, ordered by transaction_date. If there is no previous transaction for a city, show 0 for the previous revenue.

select  transaction_id, transaction_date, city, (units_sold*price_per_unit) AS total_revenue,
LAG((units_sold*price_per_unit),1,0) OVER(PARTITION BY city  ORDER BY transaction_date ) AS previous_transaction 
from mobile_sales;




-- DENSE_RANK() for Top-N within Groups
-- Question: For each brand, identify the top 2 mobile_models based on their total_revenue (units_sold * price_per_unit)
--  within that brand. Display brand, mobile_model, total_revenue, and their dense_rank.

SELECT
    brand,
    mobile_model,
    total_revenue,
    rankk_based_on_total_revenue
FROM
    (
        SELECT
            brand,
            mobile_model,
            (units_sold * price_per_unit) AS total_revenue,
            DENSE_RANK() OVER (PARTITION BY brand ORDER BY (units_sold * price_per_unit) DESC) AS rankk_based_on_total_revenue
        FROM
            mobile_sales
    ) AS ranked_sales -- Outer query is subquery ko 'ranked_sales' naam se refer karegi
WHERE
    rankk_based_on_total_revenue <= 2; -- Yahan filter kar rahe hain!
    
    
    
    
--     SUM() as a Running Total with ROWS BETWEEN (Advanced)
-- Question: For each city, calculate the running sum of total_revenue (units_sold * price_per_unit) over transaction_date. Also, include a 
-- column that shows the sum of total_revenue for the current transaction and the previous two transactions within that city.
--  Display transaction_id, city, transaction_date, total_revenue, running_total_city_revenue, and 3_day_rolling_sum.

-- (Hint: For the running total, use SUM() OVER (PARTITION BY city ORDER BY transaction_date). For the 3-day rolling sum, 
-- you'll need to use a ROWS BETWEEN clause inside OVER() like ROWS BETWEEN 2 PRECEDING AND CURRENT ROW.)


-- Question 24: LEAD() for Future Comparison
-- Question: For each mobile_model, display its transaction_id, transaction_date, city, customer_ratings. Also, include the
--  customer_ratings of the next transaction for that specific mobile_model, ordered by transaction_date. If there is no next transaction, show 0.0.

-- (Hint: Use LEAD() with PARTITION BY mobile_model and ORDER BY transaction_date.)
