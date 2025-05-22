USE walmart_db;
SELECT * FROM walmart;
DROP TABLE walmart;
SELECT count(*) FROM walmart;
SELECT DISTINCT payment_method FROM walmart;
select 
     payment_method,
     count(*)
from walmart
group by payment_method;

SELECT 
   count(DISTINCT branch)
   branch
from walmart;
SELECT MAX(quantity) FROM walmart;
SELECT MIN(quantity) FROM walmart;

-- Business Problems
-- Q1 Find different payment method and number of transactions, number of quantity sold

SELECT
     payment_method,
     count(*) as no_payments,
     SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method; 

-- Project Question 2
-- Identify the highest-rated category to each branch, displaying the branch, category
-- Avg Rating

SELECT * FROM walmart;


SELECT 
    branch, 
    category, 
    AVG(rating) AS avg_rating,
    RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rk
FROM walmart 
GROUP BY branch, category;

SELECT *
FROM
(  SELECT 
       branch, 
       category, 
       AVG(rating) AS avg_rating,
       RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS rk
   FROM walmart 
   GROUP BY branch, category 
) as rank_table
WHERE rk=1;

-- Question 3 Identify the busiest day for each branch based on the number of transactions
SELECT date from walmart;

SELECT 
    date,
    STR_TO_DATE(date, '%d/%m/%y') AS formatted_date
FROM walmart;


SELECT 
    date,
    DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%W') AS day_name
FROM walmart;

SELECT 
    branch,
    DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%W') AS day_name,
    COUNT(*) AS no_transactions
FROM walmart
GROUP BY branch,day_name
ORDER BY branch,no_transactions DESC;

SELECT *
FROM
    (SELECT 
         branch,
         DATE_FORMAT(STR_TO_DATE(date, '%d/%m/%y'), '%W') AS day_name,
         COUNT(*) AS no_transactions,
         RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rk
     FROM walmart
     GROUP BY branch,day_name
     )as ranked_days
WHERE rk=1;
-- Question 4 Calculate the total quantity of items sold per payment method.List payment_method and total_quantity.
SELECT
     payment_method,
     count(*) as no_payments,
     SUM(quantity) as no_qty_sold
FROM walmart
GROUP BY payment_method; 

-- Question 5 Determine the average, minimum, and maximum rating of category for each city.
-- List the city, average_rating, min_rating, and max_rating.
SELECT * FROM walmart;

SELECT
    city,
    category,
    MIN(rating) as min_rating,
    MAX(rating) as max_rating,
    AVG(rating) as avg_rating
FROM walmart
GROUP BY city, category;

-- Question 6 Calculate the total profit for each category by considering total_profit as
-- (unit_price * quantity * profit_margin). List category and total_profit, ordered from highest to lowest profile.
SELECT 
    category,
    SUM(total) as total_revenue,
    SUM(total * profit_margin) as profit
FROM walmart 
GROUP BY category
ORDER BY total_revenue,profit DESC;

-- Question 7 Determine the most common payment method for each Branch. Display Branch and the preferred_payment_method. 
SELECT * FROM walmart;

WITH cte
as
(SELECT
    branch,
    payment_method,
    COUNT(*) as total_trans,
    RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) as rk
FROM walmart
GROUP BY branch, payment_method
)
SELECT * FROM cte
where rk=1;

-- Question 8 Categorize sales into 3 groups MORNING, AFTERNOON, EVENING 
-- Find out which of the shift and number of invoices. 
select * from walmart;

SELECT *,
    TIME(time) AS only_time
FROM walmart;


SELECT 
*,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS only_time
FROM walmart;

SELECT 
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS only_time,
    COUNT(*) AS count
FROM walmart
GROUP BY only_time;

SELECT 
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS only_time,
    COUNT(*) AS count
FROM walmart
GROUP BY branch, only_time
ORDER BY branch, count;

-- Question 9 Identify 5 branch with highest decrese ratio in revenue compared to last year. (Current year 2023 and last year 2022). 
--  rdr== last_revenue - current_revenue/last_revenue*100

SELECT 
    branch,
    SUM(total) as revenue
FROM walmart 
GROUP BY branch;



-- Extracting the year from date
SELECT *,
       YEAR(STR_TO_DATE(date, '%d/%m/%y')) AS formatted_year
FROM walmart;

-- Comparing 2022 and 2023 Sales
WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
    GROUP BY branch
)
SELECT 
    r22.branch,
    r22.revenue AS last_year_revenue,
    r23.revenue AS cr_year_revenue
FROM revenue_2022 r22
JOIN revenue_2023 r23 ON r22.branch = r23.branch;

WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
    GROUP BY branch
)
SELECT 
    r22.branch,
    r22.revenue AS last_year_revenue,
    r23.revenue AS cr_year_revenue
FROM revenue_2022 r22
JOIN revenue_2023 r23 ON r22.branch = r23.branch
ORDER BY r22.branch ASC;

WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart 
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%y')) = 2023
    GROUP BY branch
)
SELECT 
    r22.branch,
    r22.revenue AS last_year_revenue,
    r23.revenue AS cr_year_revenue,
    ROUND(
        ((r22.revenue - r23.revenue) / CAST(r22.revenue AS DECIMAL(10, 2))) * 100,
        2
    ) AS rev_dec_ratio
FROM revenue_2022 r22
JOIN revenue_2023 r23 ON r22.branch = r23.branch
WHERE r22.revenue > r23.revenue
ORDER BY rev_dec_ratio DESC
LIMIT 5;



