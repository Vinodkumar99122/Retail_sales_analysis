-- SQL Retail Sales Analysis - p1
CREATE DATABASE sql_project_p1;
use sql_project_p1;

-- Create Table
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales_2026
              (
                  transactions_id INT PRIMARY KEY,
                  sale_date DATE,
                  sale_time TIME,
                  customer_id INT,
                  gender VARCHAR(15),
                  age INT,
                  category VARCHAR(15),
                  quantiy INT,
                  price_per_unit FLOAT,
                  cogs FLOAT,
                  total_sale FLOAT
	          );
			 
--Data Cleaning
SELECT * FROM retail_sales_2026
WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL 
	OR 
	sale_date IS NULL 
	OR 
	customer_id IS NULL 
	OR 
	gender IS NULL
	OR 
	age IS NULL 
	OR 
	category IS NULL 
	OR 
	quantiy IS NULL  
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL 
	OR 
	total_sale IS NULL;

 DELETE  FROM retail_sales_2026
 WHERE 
    transactions_id IS NULL
	OR
	sale_date IS NULL 
	OR 
	sale_date IS NULL 
	OR 
	customer_id IS NULL 
	OR 
	gender IS NULL
	OR 
	age IS NULL 
	OR 
	category IS NULL 
	OR 
	quantiy IS NULL  
	OR 
	price_per_unit IS NULL 
	OR 
	cogs IS NULL 
	OR 
	total_sale IS NULL;

--Data Exploration
--How many sales we have?

SELECT COUNT(*) AS total_sale FROM retail_sales_2026

--How many unique customers we have?

SELECT COUNT(DISTINCT customer_id) AS total_sale FROM retail_sales_2026


SELECT DISTINCT category FROM retail_sales_2026

--Data Analysis & Business Key Problems & Answers 


--Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'.

SELECT * 
FROM retail_sales_2026
WHERE  sale_date = '2022-11-05'

--Q.2 Write a SQL query to retrieve all transactions where the category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022.

SELECT *
FROM retail_sales_2026
WHERE
		category = 'Clothing'
		AND 
		FORMAT(sale_date, 'YYYY-MM') = '2022-11'
		AND
		quantiy >= 4

--Q.3 Write a SQL query to calculate the total sales (total_sales) for each category.

SELECT  
	category,
	SUM(total_sale) AS net_sale,
	COUNT(*) AS total_orders
	FROM retail_sales_2026
	GROUP BY category;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
	AVG(age) AS avg_age 
	FROM retail_sales_2026
	WHERE category = 'beauty'

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT * FROM retail_sales_2026
	WHERE total_sale > 1000

--Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
	category,
	gender,
	COUNT(*) AS total_trans
	FROM retail_sales_2026
	GROUP BY category,gender
	ORDER BY 1

--Q.7 Write a SQL query to calculate the average sale for each month. find out best selling month in each year.

SELECT 
		YEAR,
		MONTH,
		avg_sale
FROM
(
SELECT
		YEAR(sale_date) AS YEAR,
		MONTH(sale_date) AS MONTH,
		AVG(total_sale) AS avg_sale,
		RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS rnk
FROM retail_sales_2026
GROUP BY sale_date
) AS t1
WHERE rnk = 1;

--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT TOP 5
	customer_id,
	SUM(total_sale) AS highest_sale
FROM retail_sales_2026
GROUP BY customer_id
ORDER BY 2 DESC;

--Q.9 Write a SQL query to find number of unique customers who purchased items from each category.

SELECT 
	category,
	COUNT(DISTINCT customer_id) AS cunt_unq_cus
FROM retail_sales_2026
GROUP BY category

--Q.10 Write a SQL query to find create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
WITH ShiftData AS (
	SELECT 
		CASE 
			WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
			WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17  THEN 'Afternoon'
			ELSE 'Evening'
		END AS shift
FROM retail_sales_2026
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM ShiftData 
GROUP BY shift 
ORDER BY total_orders;

--End of project
