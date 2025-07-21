

 -- Revision  2
 
 -- Kaunse Brands aise hain jinki average customer rating 4.0 se kam hai, lekin unhone Total Units Sold 5000 se zyada ki hain?
-- Is query mein Brand ka naam, uski Average Customer Rating, aur Total Units Sold dikhana. Results ko Average Customer Rating
--  ke ascending order mein sort karna.

SELECT
    brand,
    AVG(customer_ratings) AS avg_ratings,        -- Average customer rating for each brand
    SUM(units_sold) AS total_units_sold          -- Total units sold for each brand
FROM
    mobile_sales
GROUP BY
    brand                                        -- Sirf brand par group kiya taake overall total units milen
HAVING
    AVG(customer_ratings) < 4.0                  -- Pehli condition: Avg Rating 4.0 se kam ho
    AND SUM(units_sold) > 5000                   -- Doosri condition: Total Units Sold 5000 se zyada ho
ORDER BY
    avg_ratings ASC;                             -- Results ko avg_ratings ke ascending order mein sort kiya
    
    
    
    
    
--     Question 1: Basic Retrieval & Filtering
-- Sawal: Mujhe un saari sales transactions ki details dikhao jo October 2021 mein hui hain, aur jahan Units Sold 5 se zyada the.
-- Transaction ID, Brand, Mobile Model, Units Sold, Price Per Unit, aur City columns show karna.

select * from mobile_sales;
select transaction_id, brand, mobile_model, units_sold, price_per_unit, city
from mobile_sales
where month_num = 10 AND units_sold >  5;


-- Question 2: Aggregation & Grouping
-- Sawal: Har Payment Method ke liye total revenue kitna generate hua, aur us payment method ka average customer rating kya raha?
-- Results ko Total Revenue ke descending order mein sort karna, aur sirf woh Payment Methods dikhana
--  jinka Total Revenue 100,000 (one lakh) se zyada tha.

select * from mobile_sales;
select payment_method, sum(units_sold*price_per_unit) as total_revenue, avg(customer_ratings) avg_customer_rating
from mobile_sales
group by payment_method
having total_revenue > 100000
order by total_revenue desc;


-- Question 3: Joins (Conceptual - mobile_sales table ke context mein)
-- Sawal: Imagine karo tumhare paas ek aur table hoti jiska naam brand_details hai, aur usmein Brand (jo mobile_sales mein bhi hai) aur 
-- Headquarters_City ke columns hote.
-- Agar tumhe har brand ki total units sold nikalni hoti, aur uske saath us brand ki Headquarters_City bhi dikhani hoti,
--  toh tum kaunsa JOIN use karte aur kaisa dikhta? (Query likhne ki zarurat nahi, bas JOIN ka naam aur logic samjhana).

-- men is men inner join use krunga aur  on men dono  tables ko  brand pe connect krunga 




-- Question 4: Filtering with Multiple Conditions & Date Parts
-- Sawal: Mujhe 2021 mein hui un saari transactions ki details dikhao jahan Payment Method 'UPI' ya 'Credit Card' tha, aur Customer Ratings 4 se kam the.
-- Transaction ID, Day Name, Brand, Mobile Model, Units Sold, Price Per Unit, City, Payment Method, aur Customer Ratings columns show karna.
select *  from mobile_sales;
select transaction_id, day_name, brand, mobile_model, units_sold, price_per_unit, city, payment_method, customer_ratings
from mobile_sales
where (payment_method = "UPI" OR payment_method ="Credit Card" )
		AND (customer_ratings < 4.0) 
        AND (year_num = 2021);
        


-- Question 5: Aggregation with Filtering on Aggregated Data
-- Sawal: Har City ke liye Total Revenue aur Average Price Per Unit calculate karo.
-- Sirf un cities ko dikhao jinka Average Price Per Unit 15,000 se zyada hai, aur jahan Total Units Sold 1000 se kam hain.
-- Results ko Total Revenue ke descending order mein sort karna.

select * from mobile_sales;
select city,  sum(units_sold*price_per_unit) AS total_revenue, avg(price_per_unit) AS avg_price_unit
from mobile_sales
group by city
having avg(price_per_unit) > 15000  AND sum(units_sold) < 1000
order by total_revenue desc;



-- Question 6: Identifying Missing Data (Conceptual / Basic WHERE & IS NULL)
-- Sawal: Tumhare mobile_sales dataset mein, kon se columns mein NULL values ho sakti hain jiske baare mein dataset description ne bataya tha? 
-- (Sirf column ke naam batao).
-- Agar tumhe yeh check karna ho ke Customer Ratings column mein kitni NULL values hain, toh tum kaunsi WHERE condition use karte?
--  (Query nahi, bas condition likhna).

  -- mere dataset men  currently kisi b column men null values nahi  hein  acc to me.
  
  -- aur  agr  mujhe  check  krna ho to  rating column  men kitni  null values hein  to men count(*) lagaunga aur  where ratings IS NULL use krunga.
  
  
  
--   Question 7: String Functions & LIKE Operator
-- Sawal: Mujhe un saare mobile models ke naam dikhao jin mein word "Note" aata hai (case-insensitive).
-- Mobile Model aur Brand columns show karna.

select brand, mobile_model from mobile_sales
where mobile_model LIKE "%Note%";


-- Question 8: Date Functions (Basic - Year/Month Extraction) & BETWEEN
-- Sawal: Mujhe un saari transactions ki details dikhao jo May 15, 2021 aur August 15, 2021 ke darmiyan hui hain.
-- Transaction ID, Transaction Date, Brand, Mobile Model, Units Sold, aur Price Per Unit columns show karna.

SELECT
    transaction_id,
    -- Assuming your table has Day, Month, Year columns
    -- CONCAT(year_num, '-', month_num, '-', day_of_month) AS transaction_date_formatted, -- Agar date ko format kar ke dikhana hai
    brand,
    mobile_model,
    units_sold,
    price_per_unit
FROM
    mobile_sales
WHERE
    (
        (year_num = 2021 AND month_num = 5 AND day_of_month >= 15) -- 2021 May, 15th ya uske baad
        OR
        (year_num = 2021 AND month_num > 5 AND month_num < 8)     -- 2021 June aur July ke saare din
        OR
        (year_num = 2021 AND month_num = 8 AND day_of_month <= 15) -- 2021 Aug, 15th ya usse pehle
    );
    
    
    
    