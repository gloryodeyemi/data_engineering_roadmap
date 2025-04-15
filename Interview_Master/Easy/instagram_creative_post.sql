-- Instagram Creative Post Engagement and Sharing Patterns

/*
You are a Product Analyst on the Instagram Stories team focused on understanding user engagement with creative content sharing. Your team wants to identify highly engaged users and 
analyze sharing patterns to enhance features that promote content sharing. Your insights will guide product managers in improving user interaction and content distribution on the platform.

Question 1 of 3
How many Instagram users shared creative photos or videos (i.e. total sum of shares) more than 10 times in April 2024? This analysis will help determine which users are highly engaged in 
content sharing.
*/
SELECT COUNT(user_id)
FROM (
  SELECT user_id
  FROM agg_daily_creative_shares
  WHERE share_date BETWEEN '2024-04-01' AND '2024-04-30'
  GROUP BY user_id
    HAVING SUM(share_count) > 10
) as high_sharing_users;

-- Question 2
-- What is the average number of shares for creative content by Instagram users in May 2024, among users who shared at least once? We want to first get the aggregated shares per user in May 2024, 
-- and then calculate the average over all the users.
SELECT AVG(shares_per_user)
FROM (
  SELECT user_id, SUM(share_count) AS shares_per_user
  FROM agg_daily_creative_shares
  WHERE share_date BETWEEN '2024-05-01' AND '2024-05-31'
  GROUP BY user_id
    HAVING SUM(share_count) > 0
) as users_sharing_avg;

-- Question 3
-- For each Instagram user who shared creative content, what is the floor value of their average daily shares during the second quarter of 2024? Only include users with an average of at least 
-- 5 shares per day.
-- Note: The agg_daily_creative_shares table is at the grain of content type, user, and day. So make sure you're aggregating to the user-day level before calculating the average.
SELECT 
    user_id,
    FLOOR(AVG(daily_shares)) AS avg_daily_shares
FROM (
    SELECT 
        user_id,
        share_date,
        SUM(share_count) AS daily_shares
    FROM agg_daily_creative_shares
    WHERE share_date BETWEEN '2024-04-01' AND '2024-06-30'
    GROUP BY user_id, share_date
) AS user_daily_totals
GROUP BY user_id
HAVING FLOOR(AVG(daily_shares)) >= 5;