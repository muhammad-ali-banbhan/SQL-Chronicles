
-- Question 1: Employees and Their Offices (Including Those Not Assigned to Any Office)
-- Saare employees ka firstName, lastName, aur agar woh kisi office mein assigned hain toh us office ka city nikalen.
--  Un employees ko bhi shamil karein jinhe abhi tak koi office assign nahi hua hai.

SELECT * from  employees;
select * from offices;

select e.firstName, e.lastName,  o.city
from employees e left join offices o
on e.officeCode = o.officeCode;

 
-- Question 2: All Products and Their Total Sales (Even if Never Sold)
-- Saare productName, productLine nikalen, aur unki total_quantity_sold aur total_revenue bhi show karein. Un products ko bhi 
-- list karein jinko ab tak kabhi order nahi kiya gaya hai, aur unke total_quantity_sold aur total_revenue NULL ya 0 show hon.


select * from products;
select * from orders;
select * from orderdetails;

SELECT
    p.productName,
    p.productLine,
    IFNULL(SUM(od.quantityOrdered), 0) AS total_quantity_sold, -- SUM use kiya aur NULL ko 0 mein convert kiya
    IFNULL(SUM(od.quantityOrdered * od.priceEach), 0) AS total_revenue -- NULL ko 0 mein convert kiya
FROM
    products p
LEFT JOIN -- LEFT JOIN use kiya taake saare products aayen
    orderdetails od ON p.productCode = od.productCode
GROUP BY
    p.productName,
    p.productLine
ORDER BY
    total_revenue DESC; -- Optional: Sorting for better understanding


-- Question 3: Customers and Their Sales Representatives (Including Reps with No Customers)
-- Har sales representative (employee) ka firstName, lastName, jobTitle nikalen, aur agar unke assigned customers hain toh un customers ka 
-- customerName bhi show karein. Un sales representatives ko bhi shamil karein jinhe abhi tak koi customer assign nahi hua hai.

select *  from customers;
select * from employees;

select e.firstName, e.lastName, e.jobTitle, c.customerName
from employees e left join customers c 
on e.employeeNumber = c.salesRepEmployeeNumber;

-- Question 4: Orders from Customers in 'USA' (with Customer Details)
-- Un saare orderNumber, orderDate, customerName, aur customerNumber nikalen, jinke customers USA se hain.

select *  from orders;
select * from   customers;

select o.orderNumber, o.orderDate, c.customerName, c.customerNumber, c.country
from  orders o right join  customers c
on o.customerNumber = c.customerNumber
WHERE c.country = "USA";


-- Question 5: Employees Who Have Customers ONLY in 'France' (and No Other Country)
-- Un employees ka firstName, lastName, aur jobTitle nikalen jinhone sirf France ke customers ko handle kiya hai, aur kisi doosre country ke 
-- customer ko nahi.
-- (Hint: Thoda complex hai. GROUP BY, HAVING, aur COUNT(DISTINCT) ka combination lag sakta hai. 
-- LEFT JOIN ya INNER JOIN ke saath NOT IN ya NOT EXISTS bhi dekh sakte ho.)

SELECT
    e.firstName,
    e.lastName,
    e.jobTitle
FROM
    employees e
INNER JOIN -- INNER JOIN use kiya kyunki humein sirf un employees mein interest hai jinke paas customers hain.
    customers c ON e.employeeNumber = c.salesRepEmployeeNumber
GROUP BY
    e.employeeNumber, e.firstName, e.lastName, e.jobTitle
HAVING
    COUNT(DISTINCT c.country) = 1 -- Jin employees ne sirf ek unique country ke customers handle kiye hain
    AND MAX(c.country) = 'France'; -- Aur woh country 'France' hai
    
    
    
    -- Alternative Correct Query (Using NOT EXISTS - More advanced):
    
    SELECT
    e.firstName,
    e.lastName,
    e.jobTitle
FROM
    employees e
WHERE
    EXISTS ( -- Check if they have *any* customer in France
        SELECT 1
        FROM customers c1
        WHERE c1.salesRepEmployeeNumber = e.employeeNumber
        AND c1.country = 'France'
    )
    AND NOT EXISTS ( -- Check if they *don't* have any customer *not* in France
        SELECT 1
        FROM customers c2
        WHERE c2.salesRepEmployeeNumber = e.employeeNumber
        AND c2.country <> 'France' -- Not equal to France
    );
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
--     SQL Practice Questions - All Joins (Second Ultimate Mixed Challenge)
-- Instructions: Har sawaal ke liye sahi JOIN type (ya types) ka faisla khud karna hai, aur phir query likhni hai. MySQL FULL OUTER JOIN ke liye workaround yaad rakhna.

-- Question 1: All Products and Their Total Sales (Even if Never Sold)
-- Saare productName, productLine nikalen, aur unki total_quantity_sold aur total_revenue bhi show karein. Un products ko bhi list karein jinko ab tak kabhi order nahi kiya gaya hai, aur unke total_quantity_sold aur total_revenue 0 show hon.

-- Question 2: Orders from Customers in 'France' (with Customer Details)
-- Un saare orderNumber, orderDate, customerName, aur country nikalen, jinke customers France se hain.

-- Question 3: Employees Not Assigned to Any Office
-- Identify karein un saare employees ko jo abhi tak kisi office mein assigned nahi hain. Unka firstName, lastName, aur jobTitle nikalen.

-- Question 4: All Offices and Any Assigned Employees
-- Saare officeCode, city nikalen, aur agar un offices mein koi employee assigned hai toh us employee ka firstName aur lastName bhi show karein. Un offices ko bhi shamil karein jinhe currently koi employee assigned nahi hai.

-- Question 5: All Employees and All Offices (Full Outer View)
-- Saare officeCode, city, firstName, aur lastName nikalen. Is mein woh offices bhi shamil hon jinhe koi employee assigned nahi hai, aur woh employees bhi shamil hon jinhe koi office assign nahi hua hai. (MySQL FULL OUTER JOIN workaround use karein.)

-- Question 6: Top 5 Customers by Total Order Value
-- Un 5 customers ke customerName aur total_order_value (sabhi orders ki quantityOrdered * priceEach ka sum) nikalen jinhone sabse zyada value ke orders place kiye hain. Results ko total_order_value ke descending order mein sort karein.

-- Question 7: Monthly Sales Revenue for 'Classic Cars' in 2004
-- Har mahine (Month) ke liye 'Classic Cars' productLine ki total_revenue (sum of quantityOrdered * priceEach) nikalen, sirf 2004 ke orders ke liye. Month ko numerical value (1-12) mein show karein. 0 revenue wale mahine skip kar sakte hain. Results ko Month ke ascending order mein sort karein.

-- Question 8: Products Never Ordered by Customers from 'Germany'
-- Un productName aur productCode ko nikalen jinko ab tak kabhi bhi 'Germany' ke customer ne order nahi kiya hai.

-- Question 9: Customers Who Placed Orders in Both 2003 AND 2005 (But Not 2004)
-- Un customerName aur customerNumber ko nikalen jinhone 2003 aur 2005 dono saalon mein kam se kam ek order place kiya ho, lekin 2004 mein koi order na kiya ho.

-- Question 10: Sales Representatives Managing Customers in At Least Two Distinct Countries
-- Un firstName, lastName, aur jobTitle nikalen un employees ke jinhone kam se kam do mukhtalif (distinct) countries ke customers ko handle kiya hai.