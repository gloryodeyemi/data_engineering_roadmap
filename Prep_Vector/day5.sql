-- Post Completion Rate Analysis

/*
Consider the events table, which contains information about the phases of writing a new social media post.

The action column can have values post_enter, post_submit, or post_canceled for when a user starts to write (post_enter), 
ends up canceling their post (post_cancel), or posts it (post_submit). Write a query to get the post-success rate for each day 
in the month of January 2020.

Note: Post Success Rate is defined as the number of posts submitted (post_submit) divided by the number of posts entered 
(post_enter) for each day.
*/
CREATE TABLE events1 (
user_id INT,
created_at TIMESTAMP,
action VARCHAR(20)
);

INSERT INTO events1 VALUES
(1, '2020-01-01 10:00:00', 'post_enter'),
(1, '2020-01-01 10:05:00', 'post_submit'),
(2, '2020-01-01 11:00:00', 'post_enter'),
(2, '2020-01-01 11:10:00', 'post_canceled'),
(3, '2020-01-01 15:00:00', 'post_enter'),
(3, '2020-01-01 15:30:00', 'post_submit'),
(4, '2020-01-02 09:00:00', 'post_enter'),
(4, '2020-01-02 09:15:00', 'post_canceled'),
(5, '2020-01-02 10:00:00', 'post_enter'),
(5, '2020-01-02 10:10:00', 'post_canceled'),
(10, '2020-01-15 14:00:00', 'post_enter'),
(10, '2020-01-15 14:30:00', 'post_submit'),
(6, '2019-12-31 23:55:00', 'post_enter'),
(6, '2020-01-01 00:05:00', 'post_submit'),
(7, '2020-02-01 00:00:00', 'post_enter'),
(7, '2020-02-01 00:10:00', 'post_submit'),
(8, '2019-01-15 10:00:00', 'post_enter'),
(8, '2019-01-15 10:30:00', 'post_submit'),
(9, '2021-01-01 09:00:00', 'post_enter'),
(9, '2021-01-01 09:10:00', 'post_canceled');

-- Do not modify the schema or data definitions above

-- Implement your SQL query below, utilizing the provided schema
SELECT 
	DATE(created_at) AS date,
	COUNT(*) AS total_enters,
	SUM(CASE WHEN action = 'post_submit' THEN 1 ELSE 0 END) AS total_submits,
	ROUND(
		SUM(CASE WHEN action = 'post_submit' THEN 1.0 ELSE 0 END) /
		COUNT(*), 2
	) AS success_rate
FROM events
WHERE DATE(created_at) BETWEEN '2020-01-01' AND '2020-01-31'
GROUP BY DATE(created_at);

-- Solution 2
WITH total_posts_entered AS (
	SELECT 
		DATE(created_at) AS date,
		COUNT(*) AS total_enters
	FROM event
	GROUP BY DATE(created_at)
),
total_posts_submitted AS (
	SELECT 
		DATE(created_at) AS date,
		SUM(CASE WHEN action = 'post_submit' THEN 1.0 ELSE 0 END) AS total_submits
	FROM events
	GROUP BY DATE(created_at)
)

SELECT 
	p1.date,
	p1.total_enters,
	p2.total_submits,
	ROUND(p2.total_submits / p1.total_enters, 2) AS success_rate
FROM total_posts_entered p1
JOIN total_posts_submitted p2
	ON p1.date = p2.date
WHERE p1.date BETWEEN '2020-01-01' AND '2020-01-31';

