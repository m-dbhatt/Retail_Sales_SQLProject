CREATE DATABASE sql_project_1;

- Create TABLE
DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales
            (
                transactions_id INT PRIMARY KEY,	
                sale_date DATE,	 
                sale_time TIME,	
                customer_id	INT,
                gender	VARCHAR(15),
                age	INT,
                category VARCHAR(15),	
                quantiy	INT,
                price_per_unit FLOAT,	
                cogs	FLOAT,
                total_sale FLOAT
            );
SELECT * from RETAIL_SALES;


---Data Cleaning

SELECT COUNT (*)
FROM
retail_sales;

SELECT * from RETAIL_SALES
WHERE 
transactions_id is NULL
or
gender is NULL
OR
cogs is Null
OR
total_sale is NULL;

Delete from RETAIL_SALES
WHERE 
transactions_id is NULL
or
gender is NULL
OR
cogs is Null
OR
total_sale is NULL;

SELECT COUNT (*)
FROM
retail_sales;


---Data Exploration

 --How many sales we have?
 
 SELECT Count (*) as total_sale From retail_sales;
 
 --How many unique customers we have?

 Select COUNT (distinct customer_id) as total_customers From retail_sales;

 Select COUNT (distinct category) as total_category From retail_sales;

 -- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '05/11/2022'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

--1 Write a SQL query to retrieve all columns for sales made on '2022/11/05'

SELECT *
FROM
retail_sales
where sale_date = '2022/11/05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

ALTER TABLE retail_sales RENAME COLUMN quantiy TO quantity;
SELECT 
    category,
    transactions_id
FROM
    retail_sales
WHERE
    LOWER(category) = 'clothing'
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND quantity >= 4;
 
 SELECT 
  *
 FROM
    retail_sales
 WHERE
    LOWER(category) = 'clothing'
    AND TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND quantity >= 4;

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

Select
category,
sum (total_sale) as total_sales
From
retail_sales
group by
category;

--Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
   ROUND (AVG (age), 2) as average_age
 FROM
    retail_sales
 where
 category = 'Beauty';

--Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

Select
*
From
retail_sales
WHERE
TOTAL_SALE > 1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
    gender,
    category,
    COUNT(transactions_id) AS total_number_transactions
FROM
    retail_sales
GROUP BY
    gender,
    category
ORDER BY
    category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best-selling month in each year

SELECT
    year,
    month,
    avg_sales
FROM (
    SELECT
        EXTRACT(YEAR FROM sale_date) AS year,
        EXTRACT(MONTH FROM sale_date) AS month,
        AVG(total_sale) AS avg_sales,
        RANK() OVER (
            PARTITION BY EXTRACT(YEAR FROM sale_date)
            ORDER BY AVG(total_sale) DESC
        ) AS sales_rank
    FROM
        retail_sales
    GROUP BY
        EXTRACT(YEAR FROM sale_date),
        EXTRACT(MONTH FROM sale_date)
) AS ranked_months
WHERE sales_rank = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

Select
 customer_id,
 Sum (total_sale) as highest_sale

 From 
 retail_sales
 group by
 customer_id
 order by
 highest_sale Desc
 Limit 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
	
Select
 Count (distinct customer_id) as uni_customers,
 category
From 
 retail_sales
group by
 category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


With hourly_sale
AS
(
Select
*,
CASE
 when  Extract(hour from sale_time)< 12 Then 'Morning'
 when  Extract(hour from sale_time) Between 12 and 17 Then 'Afternoon'
 else 'Evening'
 End as shift
From
retail_sales
)
Select
 shift,
 count(*) as total_orders
 From
 hourly_sale
 group by shift;










