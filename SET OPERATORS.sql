

-- ####################################################################################################
-- # SQL SET OPERATORS: UNION, INTERSECT (WORKAROUND), EXCEPT (WORKAROUND)                           #
-- # Database: mobile_sales                                                                           #
-- # Mentor: Your AI Assistant                                                                        #
-- # Learner: Jani (You!)                                                                             #
-- ####################################################################################################

-- --- SET OPERATORS: FUNDAMENTAL PRINCIPLES ---
-- SET OPERATORS combine the result sets of two or more SELECT statements.
-- They are powerful for merging, finding common elements, or excluding elements from different datasets.

-- Basic Rules for SET Operators:
-- 1. Number of Columns: Both SELECT statements must have the same number of columns.
-- 2. Order of Columns: The order of columns in both SELECT statements must be the same.
-- 3. Compatible Data Types: Corresponding columns (by their order) must have compatible data types
--    (e.g., VARCHAR with VARCHAR, INT with INT).

-- Main SET Operators:
-- - UNION / UNION ALL: Combines result sets.
-- - INTERSECT: Returns common rows from both result sets. (Directly NOT supported in MySQL)
-- - EXCEPT / MINUS: Returns rows from the first result set that are not in the second. (Directly NOT supported in MySQL)


-- ####################################################################################################
-- --- SECTION 1: UNION & UNION ALL ---
-- ####################################################################################################

-- UNION: Combines result sets and removes duplicate rows.
-- UNION ALL: Combines result sets and includes all rows, even duplicates.

-- --- Conceptual Example: UNION ALL Basic Use ---
-- Display brands sold in Mumbai OR Indore. This is a basic illustration of UNION ALL.
SELECT brand, city
FROM mobile_sales
WHERE city = 'Mumbai'

UNION ALL

SELECT brand, city
FROM mobile_sales
WHERE city = 'Indore';


-- --- Question 13: UNION with Aggregation and Filtering ---
-- Question: Get a unique list of Payment Methods that were either used in transactions where Units Sold were less than 3,
-- OR were used in transactions where Price Per Unit was greater than 50,000. Display only the Payment Method.
-- (Note: Original prompt asked for a unique list, hence UNION is used to remove duplicates.)
SELECT payment_method
FROM mobile_sales
WHERE units_sold < 3
GROUP BY payment_method

UNION -- Used UNION (not UNION ALL) as a unique list was requested

SELECT payment_method
FROM mobile_sales
WHERE price_per_unit > 50000
GROUP BY payment_method;


-- --- Question 16: UNION ALL with Mixed Data Types and Static Column ---
-- Question: Combine a list of Mobile Models that had Units Sold less than 5 with a list of Brands that received at least one Customer Rating of 5.0.
-- For the combined list, display a common text column named ItemType indicating whether the item
-- is a "Low Volume Model" or a "Perfectly Rated Brand".
-- (Note: Corrected based on previous discussion for column compatibility and conditions.)
SELECT
    mobile_model AS ItemName,     -- Renamed 'mobile_model' to 'ItemName' for consistency
    'Low Volume Model' AS ItemType
FROM
    mobile_sales
WHERE
    units_sold < 5

UNION ALL

SELECT
    brand AS ItemName,            -- Renamed 'brand' to 'ItemName' to match first SELECT's column name
    'Perfectly Rated Brand' AS ItemType
FROM
    mobile_sales
WHERE
    customer_ratings = 5.0        -- Corrected condition to exactly 5.0 rating
GROUP BY
    brand;                        -- Grouped by brand to get unique brands with 5.0 rating


-- ####################################################################################################
-- --- SECTION 2: INTERSECT Workaround (in MySQL) ---
-- ####################################################################################################

-- INTERSECT Concept: Returns rows that are present in BOTH result sets.
-- MySQL Workaround: Achieved using INNER JOIN between two subqueries.

-- --- Example: Brands in Mumbai AND with High Average Rating ---
-- Find brands sold in 'Mumbai' AND whose average customer rating is > 4.2.
-- (This was a mentor-provided example to explain INTERSECT workaround)
SELECT DISTINCT T1.brand
FROM
    (
        SELECT brand
        FROM mobile_sales
        WHERE city = 'Mumbai'
        GROUP BY brand
    ) AS T1 -- Brands sold in Mumbai
INNER JOIN
    (
        SELECT brand
        FROM mobile_sales
        GROUP BY brand
        HAVING AVG(customer_ratings) > 4.2
    ) AS T2 -- Brands with high average rating
ON
    T1.brand = T2.brand;


-- --- Question 11: INTERSECT Workaround - "Dual City Dominance" ---
-- Question: Identify the Mobile Models that were sold in both 'Delhi' AND 'Mumbai' in 2022. Display only the Mobile Model name.
-- (Note: Corrected based on previous discussion to filter for models in *both* cities and the specific year.)
SELECT
    ModelsInDelhi.mobile_model -- Select mobile_model from one of the joined subqueries
FROM
    (
        -- Models sold in Delhi in 2022
        SELECT mobile_model
        FROM mobile_sales
        WHERE city = 'Delhi' AND year_num = 2022
        GROUP BY mobile_model
    ) AS ModelsInDelhi
INNER JOIN
    (
        -- Models sold in Mumbai in 2022
        SELECT mobile_model
        FROM mobile_sales
        WHERE city = 'Mumbai' AND year_num = 2022
        GROUP BY mobile_model
    ) AS ModelsInMumbai
ON
    ModelsInDelhi.mobile_model = ModelsInMumbai.mobile_model;


-- --- Question 14: INTERSECT Workaround - "High-Value, High-Rated Brands" ---
-- Question: Identify the Brands that have both a Total Revenue greater than 2,000,000 (20 Lakhs)
-- AND an Average Customer Rating of 4.6 or higher. Display only the Brand name.
-- (This query was perfectly solved by you, jani!)
SELECT high_value_brands.brand
FROM
    (
        SELECT brand
        FROM mobile_sales
        GROUP BY brand
        HAVING SUM(units_sold * price_per_unit) > 2000000
    ) AS high_value_brands
INNER JOIN
    (
        SELECT brand
        FROM mobile_sales
        GROUP BY brand
        HAVING AVG(customer_ratings) >= 4.6
    ) AS high_rated_brands
ON
    high_value_brands.brand = high_rated_brands.brand;


-- --- Question 17: INTERSECT Workaround - "Consistent High Performers" ---
-- Question: Find the Brands that were among the top 3 brands by Total Revenue in 2021
-- AND were also among the top 3 brands by Total Revenue in 2022. Display only the Brand name.
-- (Note: Corrected based on previous discussion for Top N logic using ORDER BY and LIMIT.)
SELECT T2021.brand
FROM
    (
        -- Top 3 Brands by Total Revenue in 2021
        SELECT brand
        FROM mobile_sales
        WHERE year_num = 2021
        GROUP BY brand
        ORDER BY SUM(units_sold * price_per_unit) DESC
        LIMIT 3
    ) AS T2021
INNER JOIN
    (
        -- Top 3 Brands by Total Revenue in 2022
        SELECT brand
        FROM mobile_sales
        WHERE year_num = 2022
        GROUP BY brand
        ORDER BY SUM(units_sold * price_per_unit) DESC
        LIMIT 3
    ) AS T2022
ON
    T2021.brand = T2022.brand;


-- ####################################################################################################
-- --- SECTION 3: EXCEPT / MINUS Workaround (in MySQL) ---
-- ####################################################################################################

-- EXCEPT Concept: Returns rows from the first result set that are NOT in the second result set.
-- MySQL Workaround: Achieved using LEFT JOIN and WHERE IS NULL.

-- --- Example: Payment Methods in 2022 BUT NOT in 2023 ---
-- Find payment methods used in 2022 but NOT in 2023.
-- (This was a mentor-provided example to explain EXCEPT workaround)
SELECT DISTINCT T1.payment_method
FROM
    (
        SELECT payment_method
        FROM mobile_sales
        WHERE year_num = 2022
        GROUP BY payment_method
    ) AS T1 -- Payment methods in 2022
LEFT JOIN
    (
        SELECT payment_method
        FROM mobile_sales
        WHERE year_num = 2023
        GROUP BY payment_method
    ) AS T2 -- Payment methods in 2023
ON
    T1.payment_method = T2.payment_method
WHERE
    T2.payment_method IS NULL; -- Filtering for methods only in T1 (2022) and not in T2 (2023)


-- --- Question 12: EXCEPT Workaround - "Exclusive Market Entry" ---
-- Question: Find the Brands that made sales in 2023 but did NOT make any sales in 2021. Display only the Brand name.
-- (This query was perfectly solved by you, jani!)
SELECT brands_2023.brand
FROM
    (
        SELECT brand
        FROM mobile_sales
        WHERE year_num = 2023
        GROUP BY brand
    ) AS brands_2023
LEFT JOIN
    (
        SELECT brand
        FROM mobile_sales
        WHERE year_num = 2021
        GROUP BY brand
    ) AS brands_2021
ON
    brands_2023.brand = brands_2021.brand
WHERE
    brands_2021.brand IS NULL;


-- --- Question 15: EXCEPT Workaround - "Declining Cities" ---
-- Question: Find the Cities that had sales in 2021 but did NOT have any sales in 2022. Display only the City name.
-- (This query was perfectly solved by you, jani!)
SELECT cities_2021.city
FROM
    (
        SELECT city
        FROM mobile_sales
        WHERE year_num = 2021
        GROUP BY city
    ) AS cities_2021
LEFT JOIN
    (
        SELECT city
        FROM mobile_sales
        WHERE year_num = 2022
        GROUP BY city
    ) AS cities_2022
ON
    cities_2021.city = cities_2022.city
WHERE
    cities_2022.city IS NULL;


-- --- Question 18: EXCEPT Workaround - "Lost Markets" ---
-- Question: Identify the Cities that had sales from Mobile Models whose Price Per Unit was greater than 70,000 in 2021,
-- but did NOT have any sales from Mobile Models with Price Per Unit greater than 70,000 in 2023. Display only the City name.
-- (Note: Corrected based on previous discussion for consistent price condition and correct year in the second subquery.)
SELECT Cities_2021_High_Value.city
FROM
    (
        -- Cities with high-value sales in 2021
        SELECT city
        FROM mobile_sales
        WHERE price_per_unit > 70000 AND year_num = 2021
        GROUP BY city
    ) AS Cities_2021_High_Value
LEFT JOIN
    (
        -- Cities with high-value sales in 2023 (to be excluded)
        SELECT city
        FROM mobile_sales
        WHERE price_per_unit > 70000 AND year_num = 2023 -- Corrected year to 2023 and same price condition
        GROUP BY city
    ) AS Cities_2023_High_Value
ON
    Cities_2021_High_Value.city = Cities_2023_High_Value.city
WHERE
    Cities_2023_High_Value.city IS NULL;

-- ####################################################################################################
-- --- END OF SET OPERATORS PRACTICE ---
-- ####################################################################################################
















































































































































































































-- SET OPERATORS

-- SET OPERATORS tumhe SQL mein multiple SELECT statements ke results ko combine karne ki taqat dete hain. Socho, tumhare paas do alag-alag lists hain, aur tum unko jorna chahte ho, ya un mein se common cheezein nikalna chahte ho, ya aik list se doosri list ki cheezein nikalna chahte ho. Yahan SET OPERATORS kaam aate hain.

-- SET OPERATORS Ka Buniyadi Usool:
-- Columns Ka Count Aur Order Same Hona Chahiye: Dono SELECT statements mein SELECT kiye gaye columns ki taadad (number of columns) aur unka order (pehle brand hai toh doosri query mein bhi pehle brand ho) same hona zaroori hai.

-- Compatible Data Types: Corresponding columns ke data types compatible hone chahiye (maslan, INT ke saath INT, VARCHAR ke saath VARCHAR).

-- Buniyadi SET OPERATORS:
-- SQL mein teen main SET OPERATORS hain:

-- UNION & UNION ALL

-- INTERSECT (MySQL mein direct support nahi, workaround karna padta hai)

-- EXCEPT / MINUS (MySQL mein direct support nahi, workaround karna padta hai)


-- 1. UNION & UNION ALL
-- UNION operator do ya do se zyada SELECT statements ke result sets ko combine karta hai aur duplicate rows ko remove kar deta hai.

-- UNION ALL operator bhi result sets ko combine karta hai, lekin yeh duplicate rows ko remove nahi karta. Yeh har row ko include karta hai, bhale hi woh doosre result set mein pehle se maujood ho.

-- Kab Use Karte Hain?
-- Jab tumhe do ya do se zyada tables (ya aik hi table ke different parts) se data ko combine kar ke ek single list banani ho.

-- Syntax:

-- SELECT column1, column2, ...
-- FROM table1
-- WHERE conditions1
-- UNION [ALL]
-- SELECT column1, column2, ...
-- FROM table2
-- WHERE conditions2;

-- Example (tumhare mobile_sales data par):

select *  from mobile_sales;
-- Karachi mein bikne wale Brands
SELECT brand,city
FROM mobile_sales
WHERE city = 'Mumbai'
UNION ALL
-- Lahore mein bikne wale Brands
SELECT brand,city
FROM mobile_sales
WHERE city = 'Indore';



-- Tumhare Liye Practice Question 1 (SET OPERATORS):

-- Jani, tumhare mobile_sales dataset par, mujhe un saari Payment Methods ki list dikhao jo 2021 mein use hue the YA jinki Customer Ratings 4.5 se zyada the.
-- List mein Payment Method aur uske saath yeh batana ke woh "High Rated Sale" hai ya "Year 2021 Sale" (aik naya column bana kar).
-- (Hint: Dono conditions ko alag alag SELECT queries mein use karo aur phir UNION ALL karo. Aik naya column banane ke liye SELECT 'Text' use kar sakte ho).

select payment_method,  year_num from mobile_sales
where year_num = 2021;


-- Pehla SELECT: 2021 mein use hone wale Payment Methods
SELECT
    payment_method,
    'Year 2021 Sale' AS sale_type -- Naya column bana kar type specify kiya
FROM
    mobile_sales
WHERE
    year_num = 2021

UNION ALL -- Yahan UNION ALL operator use kiya

-- Doosra SELECT: Jinki Customer Ratings 4.5 se zyada the
SELECT
    payment_method,
    'High Rated Sale' AS sale_type -- Naya column bana kar type specify kiya
FROM
    mobile_sales
WHERE
    customer_ratings > 4.5;
    

    
-- UNION ALL with Static Column for Source Identification
-- Question: Display a list of Mobile Models that were either sold in 'Lahore' OR had a Customer Rating of 4.8 or higher.
-- For each model, also include a new column to indicate if it's a "Lahore Sale" or a "High Rated Model".

select  mobile_model, 'Indore Sale' AS sale_type from mobile_sales
where city = "Indore"
union all
select mobile_model, "High Rated Model" AS  sale_type from  mobile_sales
where customer_ratings >= 4.8;




-- UNION for Unique Values Across Conditions
-- Question: Get a unique list of all Brands that either recorded Total Revenue greater than 1,000,000 (10 Lakhs) 
-- OR had an Average Customer Rating of 4.5 or less.
-- Display only the Brand name.

select  brand from mobile_sales
group by brand
having  sum(units_sold*price_per_unit) > 1000000

union 

select  brand from mobile_sales
group by brand
having avg(customer_ratings) <=4.5;





SELECT DISTINCT
    Brands_by_Revenue.brand -- Result mein brand ka naam chahiye
FROM
    (
        -- Pehla set: Brands jinka Total Revenue 5,000,000 se zyada hai
        SELECT brand
        FROM mobile_sales
        GROUP BY brand
        HAVING SUM(units_sold * price_per_unit) > 500000
    ) AS Brands_by_Revenue -- Is subquery ko aik temporary naam diya
INNER JOIN
    (
        -- Doosra set: Brands jinka Average Customer Rating 4.2 se zyada hai
        SELECT brand
        FROM mobile_sales
        GROUP BY brand
        HAVING AVG(customer_ratings) < 4.2
    ) AS Brands_by_Rating -- Is subquery ko bhi aik temporary naam diya
ON
    Brands_by_Revenue.brand = Brands_by_Rating.brand; -- Dono sets ko 'brand' par join kiya
    
    
    
    SELECT DISTINCT
    Cities_2023.city -- Result mein city ka naam chahiye
FROM
    (
        -- Pehla set: Cities jahan 2023 mein sales hue
        SELECT city
        FROM mobile_sales
        WHERE year_num = 2023
        GROUP BY city -- DISTINCT ya GROUP BY for unique cities
    ) AS Cities_2023 -- Is subquery ko temporary naam diya
LEFT JOIN
    (
        -- Doosra set: Cities jahan 2024 mein sales hue
        SELECT city
        FROM mobile_sales
        WHERE year_num = 2024
        GROUP BY city -- DISTINCT ya GROUP BY for unique cities
    ) AS Cities_2024 ON Cities_2023.city = Cities_2024.city -- Dono sets ko 'city' par join kiya
WHERE
    Cities_2024.city IS NULL; -- Yahi hai EXCEPT ka magic: Agar 2024 mein match nahi mila to NULL aayega
    
    
    
    
    
--     Question 11: INTERSECT Workaround - "Dual City Dominance"
-- Question: Identify the Mobile Models that were sold in both 'Delhi' AND 'Mumbai' in 2022. Display only the Mobile Model name.

SELECT
    Models_in_Delhi_2022.mobile_model
FROM
    (
        -- Models jo 2022 mein Delhi mein bikay
        SELECT mobile_model
        FROM mobile_sales
        WHERE city = 'Delhi' AND year_num = 2022
        GROUP BY mobile_model
    ) AS Models_in_Delhi_2022
INNER JOIN
    (
        -- Models jo 2022 mein Mumbai mein bikay
        SELECT mobile_model
        FROM mobile_sales
        WHERE city = 'Mumbai' AND year_num = 2022
        GROUP BY mobile_model
    ) AS Models_in_Mumbai_2022
ON
    Models_in_Delhi_2022.mobile_model = Models_in_Mumbai_2022.mobile_model;

-- Question 12: EXCEPT Workaround - "Exclusive Market Entry"
-- Question: Find the Brands that made sales in 2023 but did NOT make any sales in 2021. Display only the Brand name.

select brands_2023.brand
from(
	select brand from mobile_sales
    where year_num = 2023
    group by brand ) AS brands_2023 
    
    LEFT JOIN 
(select brand from mobile_sales
where year_num = 2021
group by brand ) AS brands_2021 

ON brands_2023.brand = brands_2021.brand
WHERE brands_2021.brand IS NULL;









-- Question 13: UNION with Aggregation and Filtering
-- Question: Get a unique list of Payment Methods that were either used in transactions where Units Sold were less than 3, 
-- OR were used in transactions where Price Per Unit was greater than 50,000. Display only the Payment Method.

select  payment_method from mobile_sales
where  units_sold < 3
group by payment_method

union 

select payment_method from  mobile_sales 
where price_per_unit > 50000
group by payment_method;


-- Question 14: INTERSECT Workaround - "High-Value, High-Rated Brands"
-- Question: Identify the Brands that have both a Total Revenue greater than 2,000,000 (20 Lakhs) AND an Average Customer Rating 
-- of 4.6 or higher. Display only the Brand name.

select high_value_brands.brand from
(select brand from mobile_sales
group by brand
having sum(units_sold*price_per_unit) > 2000000) AS  high_value_brands

inner join

(
select brand from mobile_sales
group by brand
having avg(customer_ratings) >= 4.6 
) AS high_rated_brands
ON high_value_brands.brand = high_rated_brands.brand;


-- Question 15: EXCEPT Workaround - "Declining Cities"
-- Question: Find the Cities that had sales in 2021 but did NOT have any sales in 2022. Display only the City name.

select cities_2021.city from
(
select city from mobile_sales
where year_num = 2021
group by city
) AS cities_2021

LEFT  JOIN

(
select  city  from mobile_sales
where year_num = 2022
group by city
) AS cities_2022

ON cities_2021.city =  cities_2022.city
where cities_2022.city IS NULL;




-- Question 16: UNION ALL with Mixed Data Types and Static Column
-- Question: Combine a list of Mobile Models that had Units Sold less than 5 with a list of Brands that received at least one Customer Rating of 5.0.
-- For the combined list, display a common text column named ItemType indicating whether the item 
-- is a "Low Volume Model" or a "Perfectly Rated Brand".
    
select mobile_model AS ItemName,     
    "Low Volume Model" AS ItemType
    from  mobile_sales
    where units_sold < 5 
    
union all
	select brand AS ItemName,
    "Perfectly Rated Brand" AS ItemType
    from mobile_sales
    WHERE customer_ratings >= 1
    group by brand;



-- Question 17: INTERSECT Workaround - "Consistent High Performers"
-- Question: Find the Brands that were among the top 3 brands by Total Revenue in 2021 AND were also among the top 3 brands 
-- by Total Revenue in 2022. Display only the Brand name.

select Consistent_High_Performers_2021.brand from
(
select  brand from mobile_sales
where year_num = 2021
group by brand
order by sum(units_sold*price_per_unit) DESC
limit 3
) AS Consistent_High_Performers_2021

inner join

(
select brand from mobile_sales
where year_num = 2022
group by brand
order by sum(units_sold*price_per_unit) DESC
limit 3
) AS Consistent_High_Performers_2022

ON Consistent_High_Performers_2021.brand  = Consistent_High_Performers_2022.brand;



-- Question 18: EXCEPT Workaround - "Lost Markets"
-- Question: Identify the Cities that had sales from Mobile Models whose Price Per Unit was greater than 70,000 in 2021, 
-- but did NOT have any sales from Mobile Models with Price Per Unit greater than 70,000 in 2023. Display only the City name.

SELECT Cities_2021_High_Value.city
FROM
    (
        -- Cities with high-value sales in 2021
        SELECT city
        FROM mobile_sales
        WHERE price_per_unit > 70000 AND year_num = 2021
        GROUP BY city
    ) AS Cities_2021_High_Value
LEFT JOIN
    (
        -- Cities with high-value sales in 2023 (to be excluded)
        SELECT city
        FROM mobile_sales
        WHERE price_per_unit > 70000 AND year_num = 2023 -- Year 2023 aur same price condition
        GROUP BY city
    ) AS Cities_2023_High_Value
ON Cities_2021_High_Value.city = Cities_2023_High_Value.city
WHERE Cities_2023_High_Value.city IS NULL;