-- Engagement with Facebook Events

/*
As a Data Scientist on the Facebook Events Discovery team, you are tasked with analyzing user interaction with event recommendations to enhance 
the relevance of these suggestions. Your goal is to identify which event categories receive the most user clicks, determine if users are engaging 
with events in their preferred categories, and understand user engagement patterns by analyzing click data. This analysis will help optimize 
recommendation algorithms to increase user satisfaction and event attendance.

Question 1 of 3
How many times did users click on event recommendations for each event category in March 2024? Show the category name and the total clicks.
*/
SELECT category_name, COUNT(*)
FROM fct_event_clicks
JOIN dim_events
USING(event_id)
WHERE click_date BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY category_name;

/*
Question 2
For event clicks in March 2024, identify whether each user clicked on an event in their preferred category. Return the user ID, event category, 
and a label indicating if it was a preferred category ('Yes' or 'No').
*/
SELECT
  user_id, 
  category_name,
  CASE
    WHEN preferred_category = category_name THEN 'Yes' ELSE 'No'
  END AS label
FROM (
  SELECT 
    user_id, 
    category_name
  FROM fct_event_clicks
  JOIN dim_events
  USING(event_id)
  WHERE click_date BETWEEN '2024-03-01' AND '2024-03-31'
) clicks
JOIN dim_users
USING(user_id);

/*
Question 3
Generate a report that combines the user ID, their full name (first and last name), and the total clicks for events they interacted with in March 
2024. Sort the report by user ID in ascending order and the total clicks in descending order.
*/
SELECT 
  user_id, 
  first_name || ' ' || last_name AS full_name,
  COUNT(*) AS total_event_clicks
FROM dim_users
JOIN fct_event_clicks
USING(user_id)
WHERE click_date BETWEEN '2024-03-01' AND '2024-03-31'
GROUP BY user_id
ORDER BY user_id, total_event_clicks DESC;