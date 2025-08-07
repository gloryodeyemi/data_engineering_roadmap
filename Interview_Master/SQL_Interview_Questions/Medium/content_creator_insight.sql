-- Pro Content Creator Mac Software Usage Insights

/*
As a Product Analyst on the Mac software team, you are tasked with understanding user engagement with multimedia tools. Your team aims to identify 
key usage patterns and determine how much time users spend on these tools. The end goal is to use these insights to enhance product features and 
improve user experience.

Question 1 of 3
As a Product Analyst on the Mac software team, you need to understand the engagement of professional content creators with multimedia tools. What 
is the number of distinct users on the last day in July 2024?
*/
SELECT COUNT(DISTINCT user_id) AS number_of_users
FROM fct_multimedia_usage
WHERE usage_date = '2024-07-31';

-- Question 2 of 3
-- As a Product Analyst on the Mac software team, you are assessing how much time professional content creators spend using multimedia tools. What 
-- is the average number of hours spent by users during August 2024? Round the result up to the nearest whole number.
SELECT CEIL(AVG(hours_spent)) AS avg_hours_spent
FROM fct_multimedia_usage
WHERE usage_date BETWEEN '2024-08-01' AND '2024-08-31';

-- Question 3:
-- As a Product Analyst on the Mac software team, you are investigating exceptional daily usage patterns in September 2024. For each day, 
-- determine the distinct user count and the total hours spent using multimedia tools. Which days have both metrics above the respective average 
-- daily values for September 2024?
WITH daily_usage AS (
    SELECT 
        usage_date,
        COUNT(DISTINCT user_id) AS user_count,
        SUM(hours_spent) AS total_hours
    FROM fct_multimedia_usage
    WHERE usage_date BETWEEN '2024-09-01' AND '2024-09-30'
    GROUP BY usage_date
),
averages AS (
    SELECT 
        AVG(user_count) AS avg_users,
        AVG(total_hours) AS avg_hours
    FROM daily_usage
)
SELECT 
    d.usage_date,
    d.user_count,
    d.total_hours
FROM daily_usage d
JOIN averages a
    ON d.user_count > a.avg_users
   AND d.total_hours > a.avg_hours
ORDER BY d.usage_date;