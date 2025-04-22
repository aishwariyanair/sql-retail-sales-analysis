
# SQL Retail Sales Analysis Project

## 📊 **Project Overview**

This project demonstrates the use of SQL to analyze a **retail sales dataset**. The objective is to answer key business questions such as customer purchasing behavior, total sales by category, top customers, and best-selling months in each year using **SQL queries**.

The project includes various SQL queries designed to extract useful insights and patterns from the data. The queries range from basic aggregation and filtering to more advanced SQL techniques like **window functions** and **CASE statements**.


## 📈 **Dataset Overview**

The dataset represents the sales records of a retail company. It contains information about transactions, customers, and product sales. The main table, `retail_sales`, has the following structure:

### **Table: `retail_sales`**

| Column Name      | Data Type     | Description                               |
|------------------|---------------|-------------------------------------------|
| `transactions_id` | INT           | Unique identifier for each transaction   |
| `sale_date`       | DATE          | Date of the sale                          |
| `sale_time`       | TIME          | Time of the sale                          |
| `customer_id`     | VARCHAR(20)   | Unique identifier for each customer      |
| `gender`          | VARCHAR(20)   | Gender of the customer                    |
| `age`             | INT           | Age of the customer                       |
| `category`        | VARCHAR(25)   | Category of the product sold              |
| `quantity`        | INT           | Quantity of items sold                    |
| `price_per_unit`  | FLOAT         | Price per unit of the product sold        |
| `cogs`            | FLOAT         | Cost of goods sold                        |
| `total_sale`      | FLOAT         | Total sale amount for the transaction     |

---

## 📝 **SQL Queries Answered**

The following SQL queries were executed to answer specific business questions:

### 1. 🛠️ Table Creation Script

```sql
CREATE DATABASE sql_project;
USE sql_project;

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
```

### 2.  Limit to first 15 records

 ```sql
SELECT *FROM RETAIL_SALES 
LIMIT 15

```

### 3.  Total number of transactions

```sql
SELECT 
COUNT(*) AS total_transactions
FROM RETAIL_SALES;
```

 ### 3.  Find and remove rows with NULL values

```sql
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
```

 ### 4.  Allow safe update off to enable deletes 
 ```sql
          SET SQL_SAFE_UPDATES=0;
```

 ### 5.  Total sales (records)  
  ```sql
         SELECT COUNT(*) AS TOTAL_SALE
FROM RETAIL_SALES;
```

### 6. Unique customers
 ```sql
SELECT COUNT(DISTINCT(CUSTOMER_ID)) 
FROM RETAIL_SALES;
 ```

### 7. Number of product categories
 ```sql
SELECT COUNT(DISTINCT(CATEGORY))
 FROM RETAIL_SALES;
 ```

### 8. Customers with purchases over $300
 ```sql
SELECT CUSTOMER_ID,CATEGORY,TOTAL_SALE
FROM RETAIL_SALES
 WHERE TOTAL_SALE>300;
 ```

### 9. Which customers made a single purchase worth more than $1000?
 ```sql
SELECT CUSTOMER_ID, MAX(TOTAL_SALE)AS SALE FROM RETAIL_SALES 
 GROUP BY CUSTOMER_ID
 HAVING MAX(TOTAL_SALE)>1000;
 ```
 
 
 ### 10. Write a sql query to retrieve all columns for sales made on '2022-11-06'
 ```sql
 SELECT * 
 FROM RETAIL_SALES
 WHERE SALE_DATE='2022-11-06';
 ```
 
### 11. Write a sql query to retrieve all transactions where the category is clothing and the quantity sold is more than 10 in the month of Nov-2022
 ```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantity > 10
  AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
 ```
  
### 12. Write a SQL query to calculate the total sales for each category 
```sql
Select category,
      sum(total_sale) as total
      from retail_sales
      group by category;
```
      
  ### 13. Write a SQL query to find the average age of customes who purchased items from the beauty category
```sql
  SELECT 
      Round(AVG(age),2) as avg_age
      from retail_sales 
      where category='Beauty'
```
 
### 14. Write a SQL query to find all transactions where the total_sale is greater than 1000
```sql
 SELECT  * FROM retail_sales
 where total_sale>1000
```
 
 ### 15. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
```sql
Select category,
		gender,
        count(*) AS total_trans
from retail_sales
group by category,gender
order by category
```

### 16.  Write a SQL query to calculate  the average sale for each month.Find out best selling month in each year
```sql
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
```

### 17. Write a SQL query to find top 5 customers based on the highest total sales
```sql
Select
    customer_id,
    SUM(total_sale) as grand_total
	from retail_sales
    group by customer_id
    order by grand_total DESC
    LIMIT 5
```
    
 ### 18. Write a SQL query to find the number of unique customers who purchased from each category
```sql
SELECT 
      category,
       COUNT(DISTINCT customer_id) as  unique_customers
FROM retail_sales
GROUP BY category;
```

### 19. Write a SQL query to create each shift and number of orders (Example Morning<=12, Afternoon Between 12 & 17, evening>17)
```sql
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
```

```sql
select * from retail_sales
```
  
 ### 20. Find the most popular category overall
```sql
SELECT category, COUNT(*) AS total_orders
FROM retail_sales
GROUP BY category
ORDER BY total_orders DESC
LIMIT 1;
```

### 21.  Average sale per gender
```sql
SELECT gender, ROUND(AVG(total_sale), 2) AS avg_sale
FROM retail_sales
GROUP BY gender;
```

### 12.  Most frequently purchasing customer
```sql
SELECT customer_id, COUNT(*) AS purchases
FROM retail_sales
GROUP BY customer_id
ORDER BY purchases DESC
LIMIT 1;
```

           --  End of the Project -- 


📊 Key Findings
Top-Selling Categories: Clothing and Beauty showed the highest sales volumes.

Customer Behavior: A small group of customers drove significant revenue, especially those making single high-value purchases.

Peak Sales Times: Afternoon (12:00 PM - 5:00 PM) had the highest sales volume.

Seasonal Trends: November had the best sales, particularly in Clothing.




📈 Insights & Conclusions
Targeted Marketing: High-value customers and peak sales times should be prioritized for promotions.

Seasonal Opportunities: Focus on high-demand months like November for special offers.

Improved Data Quality: Cleaning NULL values ensured accurate analysis.




✍️ Author
This project  created by Aishwarya Nair, a passionate data analyst with a focus on SQL and data-driven insights. Feel free to connect with me for collaboration, inquiries, or networking!

GitHub: https://github.com/aishwariyanair

LinkedIn: https://www.linkedin.com/in/aishwaryaajnair

Email: aishwaryanair020@gmail.com


         


