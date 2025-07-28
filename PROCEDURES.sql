
SELECT * FROM sales_data;

CREATE PROCEDURE west_customers_details()
SELECT * FROM sales_data WHERE Region = "West";

CALL west_customers_details();


CREATE PROCEDURE male_customers_from_north()
SELECT * FROM sales_data WHERE gender = 'Male' AND Region = "North";

CALL male_customers_from_north();


-- For Delete Procedure
DROP PROCEDURE IF EXISTS inserting_data;

 

-- Create Storing Data Procedure


DELIMITER $$
CREATE PROCEDURE inserting_data(

	IN id int,
    IN name varchar(50),
	IN email varchar(40),
    IN gender  varchar(20),
	IN salary INT
)

BEGIN 

INSERT INTO users (id, name, email, gender, salary)
VALUES(id, name, email, gender, salary);
SELECT * FROM users;
END $$
DELIMITER ;



CALL inserting_data(15,  "Jyoti", "jyoti1@gmail.com", "Female", 60000);



-- For Checking the Total Procedures in your Database:
 
SHOW PROCEDURE STATUS WHERE DB = "hr";