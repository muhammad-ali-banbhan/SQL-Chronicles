-- VIEWS


SELECT * FROM sales_data;


CREATE VIEW north_customers AS
SELECT * FROM sales_data 
WHERE Region = 'North';

SELECT * FROM north_customers;


SHOW INDEXES FROM sales_data;