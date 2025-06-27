-- Understanding RIGHT JOIN in SQL
-- RIGHT JOIN (ya RIGHT OUTER JOIN) bilkul LEFT JOIN ka ulta (mirror image) hai.

-- Concept:
-- RIGHT JOIN ka matlab hai:
-- FROM clause mein jo doosri table (ya JOIN keyword ke right side par jo table likhi hoti hai) use "right table" kehte hain, 
-- uske saare records return karo.
-- Aur uske saath, ON clause ki condition ke mutabiq left table se matching records ko bhi shamil karo.
-- Agar right table ke kisi record ke liye left table mein koi matching record nahi milta, toh bhi right table
--  ka record toh return hoga, lekin left table ke columns ke liye NULL values show hongi.



-- Syntax:

-- SELECT
--     column1,
--     column2,
--     ...
-- FROM
--     LeftTable
-- RIGHT JOIN
--     RightTable -- Yeh RIGHT Table hai, iske saare records aayenge
-- ON
--     LeftTable.common_column = RightTable.common_column;
--     
--     
-- Key Difference from LEFT JOIN:

-- LEFT JOIN: Favors the LeftTable (all its rows are returned).

-- RIGHT JOIN: Favors the RightTable (all its rows are returned).

-- Important Note: Mostly cases mein, RIGHT JOIN ko LEFT JOIN se avoid kiya ja sakta hai simply table order change kar ke.

-- TableA RIGHT JOIN TableB ON condition is functionally equivalent to TableB LEFT JOIN TableA ON condition.

-- Zyadatar developers LEFT JOIN ko prefer karte hain kyunki query ka flow (FROM se LEFT JOIN tak) zayada intuitive lagta hai. Lekin 
-- conceptual understanding ke liye RIGHT JOIN ko samajhna zaroori hai.

-- Example With Our Tables: customers (Left) and orders (Right)
-- Agar hum yeh chahen ke saare orders ki list mile, chahe unke corresponding customer record maujood hon ya na hon, 
-- aur agar customer hai toh unke naam bhi show hon.

SELECT
    o.orderNumber,
    o.orderDate,
    o.status,
    c.customerName -- Customer ka naam
FROM
    customers c          -- Ye hamari LEFT Table hai
RIGHT JOIN
    orders o ON c.customerNumber = o.customerNumber; -- Ye hamari RIGHT Table hai

-- Output Kya Hoga?

-- Har orderNumber, orderDate, status dikhega (saare orders).

-- Agar us order ke liye customers table mein matching customerName mila, toh woh dikhega.

-- Agar kisi order ke liye customers table mein koi matching customer record nahi mila (jo ke ideally nahi hona chahiye reference integrity ki wajah se,
--  but hypothetical scenario), tab bhi woh order (right table ka record) output mein aayega, lekin customerName column mein NULL show hoga.









-- SQL Practice Questions - RIGHT JOIN

-- Question 1: All Orders and Their Customer Details (Even if Customer Record Missing) (orders & customers tables)
-- Saare orderNumber, orderDate, aur agar un orders ke liye customer details available hain toh customerName aur city nikalen. 
-- Un orders ko bhi show karein jinke liye koi customer record maujood nahi hai (hypothetically, ideally aisa nahi hota due to foreign keys, 
-- but for practice).

SELECT
    o.orderNumber,
    o.orderDate,
    c.customerName,
    c.city
FROM
    customers c       -- Left Table
RIGHT JOIN
    orders o          -- Right Table (saare orders yahan se aayenge)
ON
    o.customerNumber = c.customerNumber;
    
    
-- Question 2: All Products and Any Associated Order Details (products & orderdetails tables)
-- Saare productCode, productName nikalen, aur agar woh product kisi order mein shamil hai toh us order ki orderNumber aur quantityOrdered 
-- bhi show karein. Yahan focus orderdetails table par hai.

select p.productCode, p.productName, od.orderNumber, od.quantityOrdered
FROM  products p right join orderdetails od
on  p.productCode = od.productCode;


-- Question 3: All Customers and Any Sales Representative Assigned (customers & employees tables)
-- Saare customerName, customerNumber, aur agar unhe koi employee (sales representative) assign hua hai toh us employee ka 
-- firstName aur lastName nikalen. Focus customers table par hai.

SELECT
    c.customerName,
    c.customerNumber,
    e.firstName,
    e.lastName
FROM
    employees e       -- Left Table
RIGHT JOIN
    customers c       -- Right Table (saare customers yahan se aayenge)
ON
    c.salesRepEmployeeNumber = e.employeeNumber;



-- Question 4: Identify Orders Without Any Product Details (orders & orderdetails tables)
-- Un orderNumber aur orderDate ko nikalen jinke liye koi orderdetails record available nahi hai. (Again, hypothetical for practice, 
-- as typically orders have details).
-- (Hint: RIGHT JOIN ka use karein aur phir WHERE clause mein IS NULL check karein, but be careful with which table is right/left.)

SELECT
    o.orderNumber,
    o.orderDate
FROM
    orderdetails od -- Left table (ab ye left ho gayi)
RIGHT JOIN
    orders o ON o.orderNumber = od.orderNumber -- Right table (sare orders chahiye)
WHERE
    od.orderNumber IS NULL; -- Jahan orderdetails (jo ab left table hai) mein match nahi mila