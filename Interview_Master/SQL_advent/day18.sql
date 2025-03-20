-- Day 18 of SQL Advent Calendar

-- Today's Question:
-- A travel agency is promoting activities for a "Summer Christmas" party. They want to identify the top 2 activities based 
-- on the average rating. Write a query to rank the activities by average rating.

-- Table name: activities
-- activity_id	activity_name
-- 1	Surfing Lessons
-- 2	Jet Skiing
-- 3	Sunset Yoga

-- Table name: activity_ratings
-- rating_id	activity_id	rating
-- 1	1	4.7
-- 2	1	4.8
-- 3	1	4.9
-- 4	2	4.6
-- 5	2	4.7
-- 6	2	4.8
-- 7	2	4.9
-- 8	3	4.8
-- 9	3	4.7
-- 10	3	4.9
-- 11	3	4.8
-- 12	3	4.9

-- Solution
SELECT 
    activities.activity_id,
    activity_name,
    AVG(rating) AS avg_rating
FROM activities
INNER JOIN activity_ratings
ON activities.activity_id = activity_ratings.activity_id
GROUP BY activities.activity_id
ORDER BY avg_rating DESC
LIMIT 2;