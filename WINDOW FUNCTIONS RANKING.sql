

-- ROW_NUMBER()
 
 select * from mobile_sales;
 
 
 -- Question: Har Brand ke andar, har Mobile Model ko uski Price Per Unit ke hisaab se rank karo. 
 -- Price Per Unit zyada hone par behtar rank milega. Har rank unique hona chahiye, bhale hi prices same hon
 
 select brand, mobile_model, city, price_per_unit,
	ROW_NUMBER()  OVER(partition by brand order by price_per_unit DESC) AS rank_order
from mobile_sales;



-- DENSE_RANK()

-- Question: Sirf 'Mumbai' city mein hone wali sales ke liye, har Brand ke andar har Mobile Model ko uski Price Per Unit ke hisaab se rank karo. Agar 
-- Price Per Unit same ho, to unhein same rank milna chahiye, aur agla rank skip nahi hona chahiye (yaani, ranks sequential rahenge, maslan 1, 2, 2, 3).

 select brand, mobile_model, city, price_per_unit,
	DENSE_RANK()  OVER(partition by brand order by price_per_unit DESC) AS rank_order
from mobile_sales
WHERE city = "Mumbai";



-- RANK()

-- Question: "Har Brand ke andar, har Mobile Model ko uski Price Per Unit ke hisaab se rank karo. Agar Price Per Unit same ho,
--  to unhein same rank milna chahiye, lekin agla rank skip ho jana chahiye (yaani, ranks ho sakte hain 1, 2, 2, 4)."

 select brand, mobile_model, city, price_per_unit,
	RANK()  OVER(partition by brand order by price_per_unit DESC) AS rank_order
from mobile_sales;


-- Har transaction ke liye brand, mobile_model, city, price_per_unit display karo. Iske saath, ek Running Total column bhi 
-- shamil karo jo price_per_unit ka cumulative sum dikhaye, poore dataset mein price_per_unit ke descending order mein.

 select brand, mobile_model, city, price_per_unit,
	SUM(price_per_unit)  OVER( order by price_per_unit DESC) AS running_price_total
from mobile_sales;




-- Har transaction ke liye brand, mobile_model, city, price_per_unit display karo. Iske saath, ek Running Total column bhi shamil karo jo
--  price_per_unit ka cumulative sum dikhaye har Brand ke andar, aur har brand mein yeh sum price_per_unit ke descending order mein ho. 

 select brand, mobile_model, city, price_per_unit,
	SUM(price_per_unit)  OVER(partition by brand order by price_per_unit DESC) AS running_brand_price_total
from mobile_sales;




-- ROW_NUMBER() for Latest Transaction per City
-- Question: Display the transaction_id, transaction_date, city, mobile_model, and total_revenue for the latest transaction 
-- (most recent transaction_date) for each city. If there are multiple transactions on the same latest date, pick any one.

select transaction_id, transaction_date, city, mobile_model, (units_sold*price_per_unit) AS total_revenue,
row_number() over(partition by city order by transaction_date DESC) AS latest_transactions
from mobile_sales;



SELECT
    transaction_id,
    transaction_date,
    city,
    mobile_model,
    total_revenue
FROM
    (
        SELECT
            transaction_id,
            transaction_date,
            city,
            mobile_model,
            (units_sold * price_per_unit) AS total_revenue,
            ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date DESC) AS latest_transactions
        FROM
            mobile_sales
    ) AS RankedTransactions -- Tumhari poori query ko brackets mein band kar ke ek naam de diya
WHERE
    latest_transactions = 1; -- Ab yahan filter kar sakte hain!
    
    
    
    
    WITH CityLatestTransactions AS ( -- CTE ka naam 'CityLatestTransactions' rakha
    SELECT
        transaction_id,
        transaction_date,
        city,
        mobile_model,
        (units_sold * price_per_unit) AS total_revenue,
        ROW_NUMBER() OVER(PARTITION BY city ORDER BY transaction_date DESC) AS latest_transactions
    FROM
        mobile_sales
)
SELECT
    transaction_id,
    transaction_date,
    city,
    mobile_model,
    total_revenue
FROM
    CityLatestTransactions -- CTE ko FROM clause mein istemal kiya
WHERE
    latest_transactions = 1; -- Yahan filter kiya
    
    
    
    
    
    
    
    
-- RANK() for Customer Rating within Brand
-- Question: For each brand, rank the mobile_models based on their customer_ratings (highest rating first). If two models have the same rating, they 
-- should get the same rank, and the next rank should be skipped. Display brand, mobile_model, customer_ratings, and their rank.

select brand, mobile_model, customer_ratings,
RANK() over(partition by brand order by customer_ratings DESC) AS new_rank
from mobile_sales;



--  DENSE_RANK() for Top 3 Cities by Total Units Sold
-- Question: Identify the top 3 cities based on their total units_sold. Display the city, total_units_sold, and their dense_rank.

-- (Hint: First, calculate total_units_sold per city using GROUP BY. Then apply DENSE_RANK() on that result using a subquery/CTE. 
-- Remember, you'll be ranking cities, not individual transactions here.)



WITH CityUnitsSold AS ( -- Pehla CTE: Har city ki total units sold nikalo
    SELECT
        city,
        SUM(units_sold) AS total_units_sold
    FROM
        mobile_sales
    GROUP BY
        city
),

RankedCities AS ( -- Doosra CTE: Pichle CTE ke result par DENSE_RANK() lagao
    SELECT
        city,
        total_units_sold,
        DENSE_RANK() OVER (ORDER BY total_units_sold DESC) AS city_rank
    FROM
        CityUnitsSold -- Yahan pehle CTE ka istemal kiya ja raha hai
)
SELECT -- Final SELECT: Ranked cities mein se top 3 filter karo
    city,
    total_units_sold,
    city_rank
FROM
    RankedCities
WHERE
    city_rank <= 3; -- Yahan filter kar rahe hain!


