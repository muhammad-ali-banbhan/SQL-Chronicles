

SELECT * FROM sales_data;

DELETE FROM sales_data WHERE  Order_ID = 1117;

SET AUTOCOMMIT = 0;

ROLLBACK;

COMMIT;



CREATE TABLE users(
id INT AUTO_INCREMENT PRIMARY KEY,
name varchar(20),
email varchar(30) unique

);


SELECT * FROM users;


INSERT INTO  users (name, email)values

 ('Ali', 'ali43@gmail.com'),
( 'Hadi', 'hadi@gmail.com');
