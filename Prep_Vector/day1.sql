-- Inactive Users Percentage

-- You’re given two tables: users and events. The events table holds values of all of the user events in the action column 
-- (‘like’, ‘comment’, or ‘post’).
-- Write a query to get the percentage of users that have never liked or commented, rounded to two decimal places.
SELECT 
	ROUND(
	SUM(CASE 
	    	WHEN u.user_id NOT IN (
				SELECT DISTINCT user_id FROM events WHERE action IN ('like', 'comment')
			) THEN 1 
			ELSE 0
		END) * 100.0 / COUNT(*), 2
	) AS percentage
FROM users u;