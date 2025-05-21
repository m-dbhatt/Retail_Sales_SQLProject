# Retail_Sales_SQLProject
Level: Beginner
Database: sql_project_1

This project demonstrates foundational SQL skills used by data analysts to explore, clean, and analyze retail sales data. It includes setting up a retail sales database, performing exploratory data analysis (EDA), and answering key business questions using SQL queries.

# Objectives
Set up a retail sales database: Create and populate a retail sales database using the provided sales dataset.

Data Cleaning: Identify and remove records with missing or null values to ensure data quality.

Exploratory Data Analysis (EDA): Perform basic EDA to understand dataset patterns, distributions, and key metrics.

Business Analysis: Use SQL to answer specific business questions and generate actionable insights from the sales data.

# Project Structure
# 1. Database Setup
   
Database Creation: A database named p1_retail_db is created to store the sales information.

Table Creation: A table named retail_sales is created with the following columns:

transaction_id,
sale_date,
sale_time,
customer_id,
gender,
age,
product_category,
quantity_sold,
price_per_unit,
cost_of_goods_sold (COGS),
total_sale_amount.

'''sql

    CREATE DATABASE p1_retail_db;

    CREATE TABLE retail_sales

    (

    transactions_id INT PRIMARY KEY,
    
    sale_date DATE,	
    
    sale_time TIME,
    
    customer_id INT,	
    
    gender VARCHAR(10),
    
    age INT,
    
    category VARCHAR(35),
    
    quantity INT,
    
    price_per_unit FLOAT,	
    
    cogs FLOAT,
    
    total_sale FLOAT
    
    );
    '''
    
    

# 2. Data Exploration & Cleaning
   
Record Count: Determine the total number of records in the dataset.
Customer Count: Find out how many unique customers are in the dataset.
Category Count: Identify all unique product categories in the dataset.
Null Value Check: Check for any null values in the dataset and delete records with missing data.

SELECT COUNT(*) FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

SELECT * FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM retail_sales
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
    
# 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

## Sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';

## Clothing Sales in Nov-2022 with Quantity > 4

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
    
## Total Sales by Category

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

## Average Age for 'Beauty' Category Purchases and High-Value Transactions (>1000):

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
Write a SQL query to find all transactions where the total_sale is greater than 1000.:
SELECT * FROM retail_sales
WHERE total_sale > 1000

## Total Transactions by Gender & Category

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1

## Best-Selling Month Each Year (by Avg Sale)

SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1

## Top 5 Customers by Total Sales

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5

## Unique Customers per Category

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category

## Shift Analysis (Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift

# Reports

## Sales Summary

Total sales and transaction counts by category

High-value transactions over $1000

Summary of customer demographics (age and gender distribution)

## Trend Analysis

Monthly average sales and identification of peak sales months

Sales distribution by shift (Morning, Afternoon, Evening)

## Customer Insights

Top 5 customers by total sales

Number of unique customers per product category

# Findings
Customer Demographics: Sales are distributed across all age groups and genders.

High-Value Purchases: Multiple transactions exceed $1000 in sales.

Sales Trends: Clear monthly fluctuations in sales help identify peak sales periods.

Top Customers: High-revenue customers can be targeted for loyalty programs.

Category Engagement: Unique customer counts highlight popularity across product types.

# Conclusion
This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

# Acknowledgments

This project is based on an exercise from Narjir Hussain’s **SQL Data Analysis Project: https://youtu.be/ChIQjGBI3AM?si=I7aOMQAo1Ks63NTN




