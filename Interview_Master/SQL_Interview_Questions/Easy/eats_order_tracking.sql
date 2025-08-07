-- Eats Order Tracking Partner Performance Evaluation

/*
You are a Product Analyst on the Uber Eats team investigating delivery partner performance. The team wants to understand how accurately delivery partners are meeting expected delivery times. 
Your goal is to evaluate current tracking precision and identify potential improvements.

Question 1 of 3
What is the percentage of orders delivered on time in January 2024? Consider an order on time if its actual_delivery_time is less than or equal to its expected_delivery_time. 
This will help us assess overall tracking precision.
*/
SELECT 
  COUNT(*) * 100 / 
  (
    SELECT COUNT(*) FROM fct_orders
    WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
  ) AS percent_orders
FROM fct_orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
  AND actual_delivery_time <= expected_delivery_time;

-- Question 2
-- List the top 5 delivery partners in January 2024 ranked by the highest percentage of on-time deliveries. Use the delivery_partner_name field from the records. This will help us identify 
-- which partners perform best.
SELECT 
  delivery_partner_name,
  COUNT(CASE WHEN actual_delivery_time <= expected_delivery_time THEN 1 END) * 100.0 / COUNT(*) AS on_time_percentage
FROM fct_orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY delivery_partner_name
ORDER BY on_time_percentage DESC
LIMIT 5;

-- Question 3
-- Identify the delivery partner(s) in January 2024 whose on-time delivery percentage is below 50%. Return their partner names in uppercase. We need to work with these delivery partners to 
-- improve their on-time delivery rates.
SELECT 
  UPPER(delivery_partner_name),
  COUNT(CASE WHEN actual_delivery_time <= expected_delivery_time THEN 1 END) * 100.0 / COUNT(*) AS on_time_percentage
FROM fct_orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY delivery_partner_name
  HAVING COUNT(CASE WHEN actual_delivery_time <= expected_delivery_time THEN 1 END) * 100.0 / COUNT(*) < 50.0;