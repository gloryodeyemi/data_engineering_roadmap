-- Content Recommendation Algorithm Performance

/*
You are a Data Analyst on the Content Discovery Team at Netflix, tasked with evaluating the impact of the recommendation algorithm on user 
engagement. Your team is focused on assessing how recommendations affect total watch time and categorizing user watch sessions to identify 
engagement patterns. The end goal is to refine the recommendation engine to enhance user satisfaction and drive more diverse content exploration.

Question 1 of 3
What is the total watch time for content after it was recommended to users? To correctly attribute watch time to the recommendation, it is 
critical to only include watch time after the recommendation was made to the user.
*/
SELECT SUM(watch_time_minutes) AS total_watch_time
FROM fct_watch_history fwh
INNER JOIN fct_recommendations fr
  ON fwh.content_id = fr.content_id
  AND fwh.user_id = fr.user_id
  AND fwh.watch_date >= fr.recommended_date;

/* 
Question 2
The team wants to know the total watch time for each genre in first quarter of 2024, split by whether or not the content was recommended vs. 
non-recommended to a user.

Watch time should be bucketed into 'Recommended' by joining on both user and content, regardless of when they watched it vs. when they received 
the recommendation.
*/
WITH recommendation_stat AS (
  SELECT 
    dc.content_id, 
    genre, 
    user_id,
    recommendation_id,
    CASE 
      WHEN recommendation_id IS NOT NULL THEN 'Recommended' ELSE 'Non-Recommended' 
    END AS recommendation
  FROM dim_content dc
  LEFT JOIN fct_recommendations fr
  USING(content_id)
)
SELECT genre, recommendation, SUM(watch_time_minutes)
FROM fct_watch_history fwh
INNER JOIN recommendation_stat rs
  ON fwh.content_id = rs.content_id
  AND fwh.user_id = rs.user_id
WHERE watch_date BETWEEN '2024-01-01' AND '2024-03-31'
GROUP BY genre, recommendation;

/*
Question 3
The team aims to categorize user watch sessions into 'Short', 'Medium', or 'Long' based on watch time for recommended content to identify 
engagement patterns.

'Short' for less than 60 minutes,
'Medium' for 60 to 120 minutes,
'Long' for more than 120 minutes.

Can you classify and count the sessions in Q1 2024 accordingly?
*/
WITH watch_categories AS (
  SELECT 
    fwh.content_id,
    watch_time_minutes,
    watch_date,
    CASE
      WHEN watch_time_minutes < 60 THEN 'Short'
      WHEN watch_time_minutes BETWEEN 60 AND 120 THEN 'Medium'
      WHEN watch_time_minutes > 120 THEN 'Long'
    END AS watch_category
  FROM fct_watch_history fwh
  INNER JOIN fct_recommendations fr
    ON fwh.content_id = fr.content_id
    AND fwh.user_id = fr.user_id
  WHERE watch_date BETWEEN '2024-01-01' AND '2024-03-31'
)
SELECT watch_category, COUNT(content_id)
FROM watch_categories
GROUP BY watch_category;