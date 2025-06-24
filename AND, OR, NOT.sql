SELECT * FROM customers;



SELECT 
    *
FROM
    customers
WHERE
    addressLine2 IS NULL AND state IS NULL
        AND country NOT IN ('France')
        OR postalCode = 44000;
        
        
        
	SELECT * FROM customers
    WHERE NOT (country =  'USA' OR country  = 'FRANce');
    
    
    #AND / OR / NOT – Practice Questions (10 Questions):
#Find customers who are from the USA and have a creditLimit greater than 100,000.
SELECT customerName, country, creditLimit FROM customers
WHERE country = "USA" AND creditLimit > 100000;

#List customer names where the state is NULL or the city is 'Paris'.
SELECT customerName, state,  city FROM customers
WHERE state IS NULL  or city = "Paris";

#Select all customers who do not have any value in addressLine2.
SELECT customerName  FROM  customers
WHERE addressLine2 IS NULL;

#Find customers who are either from France or have a postalCode of '10100'.
SELECT customerName, country, postalCode FROM customers
WHERE country = "France" or postalCode = 10100;

#List customers who are from Spain and their salesRepEmployeeNumber is not null.
SELECT customerName, country, salesRepEmployeeNumber FROM customers
WHERE country = "Spain" AND  salesRepEmployeeNumber is not null;

#Show customers where the country is not 'Germany' and creditLimit is less than 50000.
SELECT customerName,  country, creditlimit FROM customers
WHERE country NOT IN ("Germany") AND creditLimit < 50000;

#Get all customers who have a phone number listed and belong to a state called 'CA'.
SELECT customerName, phone, state FROM customers
WHERE phone IS  NOT NULL AND state  = "CA";

#Find customers whose city is not 'Madrid' or whose creditLimit is more than 75000.
SELECT customerName,  city, creditlimit FROM customers
WHERE city NOT IN ("Madrid") OR  creditLimit > 75000;

#List customers where addressLine1 is not null and postalCode starts with '75' (you’ll need LIKE in code).
SELECT customerName, addressLine1, postalCode FROM  customers
WHERE addressLine1  IS NOT NULL AND postalCode LIKE "75%";

#Select customer names who do not have any assigned salesRepEmployeeNumber and belong to the USA.
SELECT customerName, salesRepEmployeeNumber,  country FROM customers
WHERE salesRepEmployeeNumber IS NULL AND country = "USA";



# AND / OR / NOT – Tricky Logic Practice (Set 2)
#Q1.Find customers who: are not from Germany, AND their credit limit is not null, OR they live in a city called 'Madrid'.

SELECT customerName, country, creditLimit, city FROM customers
WHERE (country != "Germany" AND creditLimit IS NOT NULL) OR city = "Madrid";

#Q2.List customers who: live in the USA OR their state is not null  BUT their phone number must not be null.
SELECT customerName, country, state, phone FROM customers
WHERE phone IS NOT NULL AND (country = 'USA' OR state IS NOT NULL);


#Q3.Show customers who: do not have a salesRepEmployeeNumber AND their creditLimit is either more than 90000 OR exactly 50000.
SELECT customerName, salesRepEmployeeNumber,  creditLimit  FROM customers
WHERE salesRepEmployeeNumber IS NULL AND (creditLimit > 90000 OR creditLimit = 50000);

#Q4.Find all customers who: do have something in addressLine2 AND their country is neither 'USA' nor 'France'.
SELECT customerName, addressLine2, country FROM customers
WHERE addressLine2 IS NOT NULL AND country NOT IN ("USA" , "France");

#Q5.List customer names where: the postalCode starts with '10' OR ends with '00' AND the state is NULL.
SELECT customerName, postalCode, state
FROM customers
WHERE (postalCode LIKE "10%" AND state IS NULL)
   OR (postalCode LIKE "%00" AND state IS NULL);
