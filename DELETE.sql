

SELECT *  FROM  employees;

delete from employees WHERE JOB_ID = 234;

SELECT * FROM job_history;

DELETE FROM job_history WHERE EMPL_ID = 'null' AND EMPL_ID= 'E1001';


-- Delete multiple rows using EMP_ID list (simple method):

DELETE FROM employees
WHERE EMP_ID IN ('E1001', 'E1003', 'E1005');



-- Delete using different conditions (columns):

DELETE FROM employees
WHERE 
  EMP_ID = 'E1002' OR 
  F_NAME = 'Zara' OR 
  SALARY < 70000;




-- Delete rows using subquery

DELETE FROM employees
WHERE EMP_ID IN (SELECT EMP_ID FROM terminated_employees);
