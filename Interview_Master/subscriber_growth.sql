-- Subscriber Growth in Emerging Markets

/*
As a Data Analyst on the Netflix Marketing Data Team, you are tasked with analyzing the efficiency of marketing spend in various emerging 
markets. Your analysis will focus on understanding the allocation of marketing budgets and the resulting subscriber acquisition. The end 
goal is to provide insights that will guide the team in optimizing marketing strategies and budget distribution across different countries.

Question 1 of 3
Retrieve the total marketing spend in each country for Q1 2024 to help inform budget distribution across regions.
*/
SELECT country_name, SUM(amount_spent) AS total_spend
FROM dimension_country
JOIN fact_marketing_spend
  ON dimension_country.country_id = fact_marketing_spend.country_id
  AND campaign_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY country_name;

-- Question 2
-- List the number of new subscribers acquired in each country (with name) during January 2024, renaming the subscriber count column to 
-- 'new_subscribers' for clearer reporting purposes.
SELECT country_name, SUM(num_new_subscribers) AS new_subscribers
FROM dimension_country
JOIN fact_daily_subscriptions
  ON dimension_country.country_id = fact_daily_subscriptions.country_id
  AND signup_date BETWEEN '2024-01-01' AND '2024-01-31'
GROUP BY country_name;

-- Question 3
-- Determine the average marketing spend per new subscriber for each country in Q1 2024 by rounding up to the nearest whole number to 
-- evaluate campaign efficiency.
SELECT 
    dc.country_name,
    CEIL(SUM(fms.amount_spent) / NULLIF(SUM(fds.num_new_subscribers), 0)) AS avg_spend_per_subscriber
FROM fact_marketing_spend fms
JOIN fact_daily_subscriptions fds 
    ON fms.country_id = fds.country_id
    AND fms.campaign_date = fds.signup_date
JOIN dimension_country dc 
    ON fms.country_id = dc.country_id
WHERE fms.campaign_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY dc.country_name;

