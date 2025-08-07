-- One Touch Conversion Performance for Mobile Shoppers

/*
As a Product Analyst on the PayPal One Touch team, you are investigating mobile checkout conversion rates for the One Touch login feature. Your team wants to understand how different 
login methods impact transaction completion across mobile platforms. You will use transaction data to evaluate login method performance and user engagement.

Question 1 of 3
For our analysis of the PayPal One Touch feature, what is the total number of mobile transactions that used One Touch during July 2024? You might notice that the login_method doesn't have 
consistent capitalization, so make sure to account for this in your query!
*/
SELECT COUNT(*)
FROM fct_mobile_transactions
WHERE UPPER(login_method) = "ONE TOUCH"
  AND transaction_date BETWEEN '2024-07-01' AND '2024-07-31';

/*
Question 2
To determine user adoption of the One Touch feature, how many distinct users completed mobile transactions using One Touch during July 2024? Rename the column for user counts to 'Unique_Users'. 
This information will support our investigation of transaction engagement.
*/
SELECT COUNT(DISTINCT user_id) AS 'Unique_Users'
FROM fct_mobile_transactions
WHERE UPPER(login_method) = "ONE TOUCH"
  AND transaction_date BETWEEN '2024-07-01' AND '2024-07-31';

/*
Question 3
We want to understand the adoption of One Touch vs. Standard features. How many successful transactions were there in July 2024 respectively for One Touch and Standard? Recall that the data in 
login_method has inconsistent capitalization, so we want to handle for this!
*/
SELECT login_method, COUNT(*)
FROM fct_mobile_transactions
WHERE UPPER(login_method) IN ('ONE TOUCH', 'STANDARD')
  AND transaction_date BETWEEN '2024-07-01' AND '2024-07-31'
  AND transaction_status = 'Success'
GROUP BY UPPER(login_method);