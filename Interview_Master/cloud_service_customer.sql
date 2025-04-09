-- Cloud Service Customer Retention and Cost Efficiency

/*
As a Product Analyst on the Google Cloud team, you are working with your team to enhance customer retention and optimize cost structures for enterprise cloud services. 
The team is particularly focused on understanding how early adoption of premium service tiers affects customer behavior and spending patterns. Your goal is to analyze 
transaction data to guide strategic decisions on service tier offerings and pricing models to improve customer engagement and revenue.

Question 1 of 3
We want to evaluate early premium service adoption among enterprise customers. How many unique customers with service tier codes starting with ''PREM'' completed transactions 
from April 1st to April 30th, 2024?
*/
SELECT COUNT(DISTINCT customer_id)
FROM fct_transactions
WHERE transaction_date BETWEEN '2024-04-01' AND '2024-04-30'
  AND service_tier_code LIKE 'PREM%';

-- Question 2
-- We need to understand usage trends for different service tiers in order to refine our service packages. Which service tier codes were used most frequently by customers for 
-- transactions in May 2024, ranked from most to least frequent?
SELECT service_tier_code, COUNT(transaction_id)
FROM fct_transactions
WHERE transaction_date BETWEEN '2024-05-01' AND '2024-05-31'
GROUP BY service_tier_code
ORDER by COUNT(transaction_id) DESC;

-- Question 3
-- We want to pinpoint the most active service tiers to inform pricing adjustments for enterprise cloud offerings. For transactions between June 1st and June 30th, 2024, what are 
-- the top three service tier codes based on transaction volume and how many transactions were recorded for each?
SELECT service_tier_code, COUNT(transaction_id)
FROM fct_transactions
WHERE transaction_date BETWEEN '2024-06-01' AND '2024-06-30'
GROUP BY service_tier_code
ORDER by COUNT(transaction_id) DESC
LIMIT 3;