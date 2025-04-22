create database sql_project

USE  sql_project;

create table retail_sales(
           transactions_id INT PRIMARY KEY,
           sale_date DATE,
           sale_time TIME,
           customer_id VARCHAR(20),
           gender	VARCHAR(20),
           age INT,
           category VARCHAR(25),
           quantity INT,
           price_per_unit FLOAT,
           cogs  FLOAT,
           total_sale FLOAT
           );
           
SELECT * FROM RETAIL_SALES;


--  Limit to first 15 records--

SELECT *FROM RETAIL_SALES 
LIMIT 15

-- Total number of transactions

SELECT 
COUNT(*) AS total_transactions
 FROM RETAIL_SALES;
-- Find and remove rows with NULL values
 SELECT * 
 FROM RETAIL_SALES
 WHERE transactions_id IS NULL
        OR  sale_date IS NULL
        OR  sale_time IS NULL
	    OR  customer_id IS NULL
		OR  gender  IS NULL
        OR  age  IS NULL
        OR  category IS NULL
        OR  quantiTy  IS NULL	
		OR   price_per_unit IS NULL
		OR   cogs IS NULL
		OR  total_sale	IS NULL;
    
 -- Allow safe update off to enable deletes   
  SET SQL_SAFE_UPDATES=0;
  
 -- Delete null rows
 DELETE FROM RETAIL_SALES
 WHERE transactions_id IS NULL
        OR  sale_date IS NULL
        OR  sale_time IS NULL
	    OR  customer_id IS NULL
		OR  gender  IS NULL
        OR  age  IS NULL
        OR  category IS NULL
        OR  quantiTy  IS NULL	
		OR   price_per_unit IS NULL
		OR   cogs IS NULL
		OR   total_sale	 IS NULL;	
        
-- Turn safe updates back on 
	SET SQL_SAFE_UPDATES=1;
    
--  Total sales (records) 
SELECT COUNT(*) AS TOTAL_SALE
FROM RETAIL_SALES;

--  Unique customers
SELECT COUNT(DISTINCT(CUSTOMER_ID)) 
FROM RETAIL_SALES;

--  Number of product categories
SELECT COUNT(DISTINCT(CATEGORY))
 FROM RETAIL_SALES;

--  Customers with purchases over $300
SELECT CUSTOMER_ID,CATEGORY,TOTAL_SALE
FROM RETAIL_SALES
 WHERE TOTAL_SALE>300;

-- Which customers made a single purchase worth more than $1000?
SELECT CUSTOMER_ID, MAX(TOTAL_SALE)AS SALE FROM RETAIL_SALES 
 GROUP BY CUSTOMER_ID
 HAVING MAX(TOTAL_SALE)>1000;
 
 
 -- Write a sql query to retrieve all columns for sales made on '2022-11-06' */
 SELECT * 
 FROM RETAIL_SALES
 WHERE SALE_DATE='2022-11-06';
 
-- Write a sql query to retrieve all transactions where the category is clothing and the quantity sold is more than  10
in the month of Nov-2022

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
  
-- Write a SQL query to calculate the total sales for each category 
Select category,
      sum(total_sale) as total
      from retail_sales
      group by category;
      
  -- Write a SQL query to find the average age of customes who purchased items from the beauty category */
  SELECT 
      Round(AVG(age),2) as avg_age
      from retail_sales 
      where category='Beauty'
 
-- Write a SQL query to find all transactions where the total_sale is greater than 1000  */
 SELECT  * FROM retail_sales
 where total_sale>1000
 
 -- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
Select category,
		gender,
        count(*) AS total_trans
from retail_sales
group by category,gender
order by category

-- Write a SQL query to calculate  the average sale for each month.Find out best selling month in each year 
WITH monthly_avg AS (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS avg_sale
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
ranked_months AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY year
            ORDER BY avg_sale DESC
        ) AS row_num
    FROM monthly_avg
)
SELECT year, month, avg_sale
FROM ranked_months
WHERE row_num = 1;

-- Write a SQL query to find top 5 customers based on the highest total sales 
Select
    customer_id,
    SUM(total_sale) as grand_total
	from retail_sales
    group by customer_id
    order by grand_total DESC
    LIMIT 5
    
 -- Write a SQL query to find the number of unique customers who purchased from each category 
SELECT 
      category,
       COUNT(DISTINCT customer_id) as  unique_customers
FROM retail_sales
GROUP BY category;

-- Write a SQL query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, evening>17) 
SELECT
    CASE
        WHEN HOUR(sale_time) <= 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 13 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;
FROM retail_sales
GROUP BY shift;

select * from retail_sales
  
 -- Find the most popular category overall--
SELECT category, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_orders DESC
LIMIT 1; 

-- Average sale per gender
SELECT gender, ROUND(AVG(total_sale), 2) AS avg_sale
FROM retail_sales
GROUP BY gender;

-- Most frequently purchasing customer
SELECT customer_id, COUNT(*) AS purchases
FROM retail_sales
GROUP BY customer_id
ORDER BY purchases DESC
LIMIT 1;

           --  End of the Project -- 







 



           
           
           
           
	


