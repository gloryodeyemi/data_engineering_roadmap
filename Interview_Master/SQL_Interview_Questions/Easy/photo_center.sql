-- Photo Center: Personalized Gift Performance Analysis

/*
As a Data Analyst for the Walmart Photo Center team, you are tasked with evaluating the performance of personalized photo gifts. Your team 
aims to enhance customer satisfaction and refine product offerings by analyzing customer engagement and product popularity. The objective is 
to identify key purchasing behaviors and trends to inform inventory and marketing strategies.

Question 1 of 3
For each personalized photo gift product, what is the total quantity purchased in April 2024? This result will provide a clear measure of 
product performance for our inventory strategies.
*/
SELECT product_id, SUM(quantity)
FROM fct_photo_gift_sales
WHERE purchase_date BETWEEN '2024-04-01' AND '2024-04-30'
GROUP BY product_id;

-- Question 2 of 3
-- What is the maximum number of personalized photo gifts purchased in a single transaction during April 2024? This information will 
-- highlight peak purchasing behavior for individual transactions.
SELECT quantity
FROM fct_photo_gift_sales
WHERE purchase_date BETWEEN '2024-04-01' AND '2024-04-30'
ORDER BY quantity DESC
LIMIT 1;

-- Question 3 of 3
-- What is the overall average number of personalized photo gifts purchased per customer during April 2024? That is, for each customer, 
-- calculate the total number of personalized photo gifts they purchased in April 2024 — then return the average of those values across all 
-- customers.
SELECT AVG(no_of_gifts) AS avg_gifts_purchased
FROM (
  SELECT customer_id, SUM(quantity) AS no_of_gifts
  FROM fct_photo_gift_sales
  WHERE purchase_date BETWEEN '2024-04-01' AND '2024-04-30'
  GROUP BY customer_id
) AS gifts_purchased