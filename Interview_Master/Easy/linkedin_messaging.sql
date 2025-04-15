-- LinkedIn Messaging: User Engagement Insights

-- You are a Product Analyst on the LinkedIn Messaging team focused on understanding user engagement with messaging features. Your team is 
-- interested in analyzing messaging patterns to identify key metrics that reflect user interaction and engagement levels. The aim is to 
-- leverage these insights to enhance the professional communication experience on the platform.

-- Question 1 of 3
-- What is the total number of messages sent during April 2024? This information will help us quantify overall engagement as a baseline for 
-- targeted product enhancements.
SELECT COUNT(*) AS total_messages
FROM fct_messages
WHERE message_sent_date BETWEEN '2024-04-01' AND '2024-04-30';

-- Question 2
-- What is the average number of messages sent per user during April 2024? Round your result to the nearest whole number. This metric 
-- provides insight into individual engagement levels for refining our communication features.
SELECT  
  ROUND(COUNT(*) / COUNT(DISTINCT user_id)) AS avg_message_per_user
FROM fct_messages
WHERE message_sent_date BETWEEN '2024-04-01' AND '2024-04-30';

-- Question 3
-- What percentage of users sent more than 50 messages during April 2024? This calculation will help identify highly engaged users and 
-- support recommendations for enhancing messaging interactions.
WITH more_than_50 AS (
  SELECT user_id
  FROM fct_messages
  WHERE message_sent_date BETWEEN '2024-04-01' AND '2024-04-30'
  GROUP BY user_id
  HAVING COUNT(message_id) > 50
)
  
SELECT 
  100.0 * (SELECT COUNT(*) from more_than_50) / 
  COUNT(DISTINCT user_id) AS user_percentage 
FROM fct_messages
WHERE message_sent_date BETWEEN '2024-04-01' AND '2024-04-30';