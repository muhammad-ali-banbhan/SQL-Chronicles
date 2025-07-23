CREATE TABLE Sales_Data (
    Order_ID INT,  -- NO PRIMARY KEY, to allow duplicates
    
    Dates DATE NOT NULL,
    Ship_Date DATE NOT NULL,
    Ship_Mode VARCHAR(50) NOT NULL,
    
    Customer_ID VARCHAR(20) NOT NULL,
    Customer_Name VARCHAR(100) NOT NULL,
    
    Segment VARCHAR(50) 
        CHECK (Segment IN ('Consumer', 'Corporate', 'Home Office')),
    
    Product VARCHAR(100) NOT NULL,
    Product_ID VARCHAR(20) NOT NULL,
    
    Salesman VARCHAR(100) NOT NULL,
    Designation VARCHAR(50),
    Region VARCHAR(50),
    
    No_Customers INT DEFAULT 1 
        CHECK (No_Customers >= 0),
    
    Net_Sales DECIMAL(10,2) NOT NULL 
        CHECK (Net_Sales >= 0),
    
    Profit_Loss DECIMAL(10,2)
);


SET GLOBAL LOCAL_INFILE = ON;

LOAD DATA LOCAL INFILE 'D:/MY SQL CWH/Sales Data.csv'
INTO TABLE sales_data
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(Dates, Order_ID, Ship_Date, Ship_Mode, Customer_ID, Customer_Name, Segment, Product, Product_ID, Salesman, Designation, Region, No_Customers, Net_Sales, Profit_Loss);



select * from sales_data;

alter table sales_data RENAME column order_date to Order_date;