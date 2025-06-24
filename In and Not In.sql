select * from customers;

select * from customers 
where city not in ("NYC", "Melbourne", "Stavern");

select * from customers
where country in ("Poland","Sweden", "Spain");

select * from customers
where postalCode in (44000, 41101) and country not  in  ("USA", "Denmark");

select * from customers
where postalCode in (44000, 41101) or country not  in  ("USA", "Denmark");

select * from customers 
where city like "Nantes"  or country in ("USA",  "France");





-- IN / NOT IN Practice Questions Set

-- List all customers from either ‘France’, ‘USA’, or ‘Norway’.
select customerName, country from customers
where country in  ("USA", "Norway" ,"France");

-- Find customers whose city is NOT one of: ‘Madrid’, ‘Paris’, or ‘Boston’.
select customerName, city from customers
where city not in ("Madrid", "Paris" , "Boston");


-- Show customers where the postal code is either 10100, 44000, or 3000.
select customerName, postalCode from  customers
where postalCode IN (10100, 44000, 3000);

-- Find customers who are from countries other than ‘Germany’, ‘Italy’, or ‘Spain’.
select customerName, country from customers
where country NOT  IN ("Germany","Italy", "Spain");

-- List customers where the city is ‘San Francisco’ or the country is in (‘France’, ‘Canada’).
select customerName, city, country from customers
where city = "San Francisco" or country IN  ("France", "Canada");

-- Get customers whose salesRepEmployeeNumber is NOT in (1370, 1504, 1611).
select  customerName,  salesRepEmployeeNumber from customers
where  salesRepEmployeeNumber NOT IN (1370, 1504, 1611);

-- Find customers who live in a city NOT in (‘Melbourne’, ‘Oslo’, ‘Lille’) AND country is ‘USA’.
select customername, city, country from customers
where city NOT IN ("Melbourne", "Oslo","Lille")  AND country  = "USA";

-- List customer names where the postalCode is in (5023, 44000, 12209) OR the country is NOT in (‘France’, ‘Austria’).
select  customerName,postalCode, country  From customers
where (postalCode IN (5023, 44000, 12209)) OR (country NOT IN ("France", "Australia"));

-- Show customers who are from cities in this list: (‘Madrid’, ‘Nantes’, ‘Tokyo’) and have a creditLimit > 50,000.
select customerName, city, creditLimit  from customers
where city IN ("Madrid", "Nantes","Tokyo") AND creditLimit > 50000;

-- List all customers where either:  country is in (‘USA’, ‘Australia’) OR city is NOT in (‘Paris’, ‘Oslo’) AND salesRepEmployeeNumber is not null.
select customerName, country, city, salesRepEmployeeNumber from  customers
where (country IN ("USA","Australia")) OR city NOT IN ("Paris","Oslo") AND salesRepEmployeeNumber IS NOT NULL;