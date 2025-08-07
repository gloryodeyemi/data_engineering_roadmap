-- Advertising Campaign Performance and ROI Impact

/*
As a Data Analyst on the Google Ads Performance Analytics team, you are tasked with evaluating the performance of recent ad campaigns to 
identify trends in conversions and revenue generation. Your team aims to uncover high-performing campaigns, recognize effective ad types, 
and pinpoint campaigns that failed to generate revenue. By leveraging these insights, you will guide strategic recommendations to enhance 
overall campaign performance.

Question 1 of 3
What are the top 5 ad campaign IDs with the highest number of conversions, that started in April 2024?
*/
SELECT campaign_id, SUM(conversions) AS num_of_conversions
FROM ad_campaigns
WHERE start_date BETWEEN '2024-04-01' AND '2024-04-30'
GROUP BY campaign_id
ORDER BY num_of_conversions DESC
LIMIT 5;

-- Question 2
-- Identify the distinct ad types with more than 100 conversions that started in May 2024.
SELECT ad_type, SUM(conversions) AS num_of_conversions
FROM ad_campaigns
WHERE start_date BETWEEN '2024-05-01' AND '2024-05-31'
GROUP BY ad_type
HAVING SUM(conversions) > 100;

-- Question 3
-- Of the campaigns that started in June 2024, find the ones that did not generate any revenue. Please list the campaign names and start dates.
SELECT campaign_name, start_date
FROM ad_campaigns
WHERE start_date BETWEEN '2024-06-01' AND '2024-06-30'
  AND revenue = 0;