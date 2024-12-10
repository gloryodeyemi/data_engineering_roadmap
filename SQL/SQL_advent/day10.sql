-- Day 10 of SQL Advent Calendar

-- Today's Question:
-- You are tracking your friends' New Year’s resolution progress. Write a query to calculate the following for each friend: 
-- number of resolutions they made, number of resolutions they completed, and success percentage (% of resolutions completed) 
-- and a success category based on the success percentage:
-- - Green: If success percentage is greater than 75%.
-- - Yellow: If success percentage is between 50% and 75% (inclusive).
-- - Red: If success percentage is less than 50%.

-- Table name: resolutions
-- resolution_id	friend_name	resolution	is_completed
-- 1	Alice	Exercise daily	1
-- 2	Alice	Read 20 books	0
-- 3	Bob	Save money	0
-- 4	Bob	Eat healthier	1
-- 5	Charlie	Travel more	1
-- 6	Charlie	Learn a new skill	1
-- 7	Diana	Volunteer monthly	1
-- 8	Diana	Drink more water	0
-- 9	Diana	Sleep 8 hours	1

-- Solution
SELECT
    friend_name,
    no_of_resolution,
    no_completed,
    (1.0 * no_completed / no_of_resolution * 100) AS percentage_completed,
    CASE
        WHEN (1.0 * no_completed / no_of_resolution * 100) > 75 THEN 'Green'
        WHEN (1.0 * no_completed / no_of_resolution * 100) >= 50 THEN 'Yellow'
        ELSE 'Red'
    END AS success_category
FROM (
    SELECT 
        friend_name, 
        COUNT(resolution) AS no_of_resolution,
        SUM(CASE WHEN is_completed = 1 THEN 1 ELSE 0 END) AS no_completed
    FROM resolutions
    GROUP BY friend_name
);