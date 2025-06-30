/*
Reorder Patterns for Amazon Fresh

As a Data Analyst on the Amazon Fresh product team, you and your team are focused on enhancing the customer experience by streamlining the process for customers to reorder their favorite 
grocery items. Your goal is to identify the most frequently reordered product categories, understand customer preferences for these products, and calculate the average reorder frequency 
across categories. By analyzing these metrics, you aim to provide actionable insights that will inform strategies to improve customer satisfaction and retention.

Question 1 of 3
The product team wants to analyze the most frequently reordered product categories. Can you provide a list of the product category codes (using first 3 letters of product code) and their 
reorder counts for Q4 2024?
*/

SELECT 
  SUBSTR(product_code, 1, 3), 
  SUM(CASE WHEN reorder_flag = 1 THEN 1 ELSE 0 END) AS reorder_count
FROM fct_orders f
JOIN dim_products d
  ON f.product_id = d.product_id
WHERE order_date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY SUBSTR(product_code, 1, 3)
ORDER BY reorder_count DESC;

-- To better understand customer preferences, the team needs to know the details of customers who reorder specific products. Can you retrieve the customer information along with their 
-- reordered product code(s) for Q4 2024?
SELECT fp.customer_id, customer_name, product_code
FROM (
  SELECT customer_id, product_code
  FROM fct_orders f
  JOIN dim_products dp
    ON f.product_id = dp.product_id
  WHERE order_date BETWEEN '2024-10-01' AND '2024-12-31'
    AND reorder_flag = 1
) fp
JOIN dim_customers dc
  ON fp.customer_id = dc.customer_id;

-- When calculating the average reorder frequency, it's important to handle cases where reorder counts may be missing or zero. Can you compute the average reorder frequency across the 
-- product categories, ensuring that any missing or null values are appropriately managed for Q4 2024?
SELECT 
    dp.category,
    ROUND(
        SUM(CASE WHEN f.reorder_flag = 1 THEN 1 ELSE 0 END) * 1.0 /
        COUNT(f.order_id), 
        2
    ) AS avg_reorder_frequency
FROM fct_orders f
JOIN dim_products dp 
    ON f.product_id = dp.product_id
WHERE f.order_date BETWEEN '2024-10-01' AND '2024-12-31'
GROUP BY dp.category;