-- SELF JOIN

UPDATE  employees SET REFFERED_BY_ID = 1 WHERE EMP_ID IN ("E1003", "E1006");






SELECT * FROM sales_data;

SELECT * FROM employees;

SELECT a.EMP_ID, a.F_NAME AS username, b.F_NAME AS reffered_by
FROM employees a 
INNER JOIN employees b
