-- [Retail Sales Analysis]

CREATE DATABASE sql_project;
-- [We are useing that Database]
USE sql_project;


-- [CREATE RETAIL_SALES TABLE]
CREATE TABLE RETAIL_SALES (transactions_id INT PRIMARY KEY,
				   sale_date VARCHAR(20),
                   sale_time TIME,
                   customer_id INT ,
                   gender VARCHAR(7) ,
                   age int ,
                   category varchar(15),
                   quantiy int,
                   price_per_unit decimal(5,2),
                   cogs	decimal(5,2),
                   total_sale decimal(6,2) );
                   
                   
-- [CHECKING FOR TOTAL NUMBER OF ROWS]
SELECT COUNT(*) AS TOTAL_NUMBER_OF_SALES
FROM RETAIL_SALES;


-- [CHECKING FOR NULL VALUES IF EXIST THEN WE ARE DELETEING THOSE ROW]
DELETE FROM RETAIL_SALES
where sale_date is null
      or sale_time is null
      or customer_id is null
      or gender is null
      or age is null
      or category is null
      or quantiy is null
      or price_per_unit is null
      or cogs is null
      or total_sale is null 
	  or transactions_id is null;

-- [DATA EXPLORATION ........]

-- [CHECK HOW MANY TUPLES WE HAVE ]
SELECT COUNT(*) AS TOTAL_NUMBER_OF_SALES
FROM RETAIL_SALES;

-- [HOW MANY UNOQUE CUSTOMER WE HAVE] .
SELECT  COUNT(DISTINCT customer_id) AS TOTAL_NUMBER_OF_CUSTOMER
FROM RETAIL_SALES;

-- [HOW MANY CATEGORY WE HAVE]
SELECT  DISTINCT category AS TOTAL_NUMBER_OF_CATEGORY_TYPE
FROM RETAIL_SALES;


-- [DATA ANALYSIS AND BUSINESS KEY PROBLEMS.....]

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05:
SELECT * FROM RETAIL_SALES
WHERE sale_date ='2022-11-05'; 


-- 2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM RETAIL_SALES
WHERE category ='Clothing' AND 
	  quantiy >=4 AND
      DATE_FORMAT(sale_date,'%b-%Y') = 'Nov-2022'; 
      

-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category , COUNT(category) AS NU_OF_Trans,SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY category;


-- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
SELECT category, ROUND(AVG(age),2 ) AS Avg_Age
FROM RETAIL_SALES
GROUP BY category
HAVING category ='Beauty';


-- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * 
FROM RETAIL_SALES
where total_sale>1000;


-- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
SELECT category, gender, COUNT(transactions_id) AS Total_trans
FROM RETAIL_SALES
GROUP BY category ,gender
ORDER BY 1;


-- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
SELECT * FROM
(
SELECT DATE_FORMAT(sale_date,'%b') AS MONTHLY_DATA ,
		YEAR(sale_date) AS YEAR_DATA,
		AVG(total_sale) AS average_sale,
		RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS RANK_DATA
	FROM RETAIL_SALES
	GROUP BY 1,2
	ORDER BY 2,RANK_DATA
) AS T1 
WHERE RANK_DATA =1;    


-- 8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT customer_id, SUM(total_sale) AS Total_price
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY customer_id ASC
LIMIT 5 ;


-- 9. Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT COUNT(DISTINCT customer_id), category
FROM RETAIL_SALES
GROUP BY category;


-- 10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
SELECT 
   CASE
       WHEN HOUR(sale_time) < 12 THEN 'Morning' 
	   WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon' 
       ELSE  'Evening'
       END AS shift,
       COUNT(*) AS NUMBER_OF_ORDER
FROM RETAIL_SALES
GROUP BY shift
ORDER BY 
	    CASE 
        WHEN shift = 'Morning' THEN 1
        WHEN shift = 'Afternoon' THEN 2
        WHEN shift = 'Evening' THEN 3
    END;
    
--------      [END OF THE PROJECT] ---------    
    
