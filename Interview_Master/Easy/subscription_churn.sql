-- Subscription Churn Impact on Recurring Revenue

/*
As a Product Analyst on the Billing team, you are tasked with investigating customer retention patterns across different subscription tiers. Your team is particularly interested in 
understanding which tiers are experiencing the highest customer dropout rates. Your goal is to develop insights that can inform strategies to reduce subscription cancellations and 
stabilize recurring revenue.

Question 1 of 3
Identify the first 3 subscription tiers in alphabetical order. Don't forget to remove duplicate values. This query will help us understand what values are in the tier_name column.
*/
SELECT DISTINCT tier_name
FROM fct_subscriptions
ORDER BY tier_name
LIMIT 3;

-- Question 2 of 3
-- Determine how many customers canceled their subscriptions in August 2024 for tiers labeled 'Basic' or 'Premium'. This query is used to evaluate cancellation trends for these specific 
-- subscription levels.
SELECT COUNT(customer_id)
FROM fct_subscriptions
WHERE end_date BETWEEN '2024-08-01' AND '2024-08-31'
  AND tier_name IN ('Basic', 'Premium');

-- Question 3 of 3
-- Find the subscription tier with the highest number of cancellations during Quarter 3 2024 (July 2024 through September 2024). This query will guide retention strategies by identifying 
-- the tier with the most significant dropout case.
SELECT tier_name, COUNT(customer_id) AS no_of_cancellations
FROM fct_subscriptions
WHERE end_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY tier_name
ORDER BY no_of_cancellations DESC
LIMIT 1;