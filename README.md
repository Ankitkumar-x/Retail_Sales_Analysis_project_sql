# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis    
**Database**: `sql_project`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project;

CREATE TABLE RETAIL_SALES
(
    transactions_id INT PRIMARY KEY,
    sale_date VARCHAR(10),	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(15),
    quantity INT,
    price_per_unit DECIMAL(5,2),	
    cogs DECIMAL(5,2),
    total_sale DECIMAL(6,2)
);
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) AS TOTAL_NUMBER_OF_SALES
FROM RETAIL_SALES;

SELECT COUNT(DISTINCT customer_id)AS TOTAL_NUMBER_OF_CUSTOMER
FROM RETAIL_SALES;

SELECT DISTINCT category FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM RETAIL_SALES
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Business key problems.

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *FROM RETAIL_SALES
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT * FROM RETAIL_SALES
WHERE category = 'Clothing'AND 
      quantiy >=4 AND
      DATE_FORMAT(sale_date,'%b-%Y') = 'Nov-2022';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT category ,
COUNT(category) AS No_OF_Trans,SUM(total_sale) AS total_sale
FROM RETAIL_SALES
GROUP BY category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT category, ROUND(AVG(age),2 ) AS Avg_Age
FROM RETAIL_SALES
GROUP BY category
HAVING category ='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT *
FROM RETAIL_SALES
where total_sale>1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category, gender, COUNT(*) AS Total_trans
FROM RETAIL_SALES
GROUP BY category ,gender
ORDER BY 1;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT DATE_FORMAT(sale_date,'%b') AS MONTHLY_DATA ,
		YEAR(sale_date) AS YEAR_DATA,
		AVG(total_sale) AS average_sale,
		RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS RANK_DATA
	FROM RETAIL_SALES
	GROUP BY 1,2
	ORDER BY 2,RANK_DATA
) AS T1 
WHERE RANK_DATA =1;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT customer_id, SUM(total_sale) AS Total_price
FROM RETAIL_SALES
GROUP BY customer_id
ORDER BY customer_id ASC
LIMIT 5 ;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as unique_cs
FROM RETAIL_SALES
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 2000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `Retail_Sales_Analysis_project.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Ankit Kumar

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles.

- **LinkedIn**: [Connect with me professionally](https://www.linkedin.com/in/ankit-kumar-153239360/)


Thank you for your support,

