-- Game Library Health for User Retention

/*
You are a Product Analyst on the EA Desktop team investigating user game library engagement patterns. Your team wants to understand how many games 
users have installed and actively play on the platform. The goal is to identify opportunities to improve user retention and platform stickiness.

Question 1 of 3
How many users have no games installed in their library during the third quarter of 2024? Use the dim_users table and filter for users where 
has_game_installed is 0 and the library_last_updated date is between July and September 2024. This helps identify users that can be targeted 
for increased engagement.
*/
SELECT count(*)
FROM dim_users
WHERE has_game_installed = 0
  AND library_last_updated BETWEEN '2024-07-01' AND '2024-09-30';

/*
Question 2
Which 5 games had the highest number of installs during the third quarter of 2024? This helps reveal the most popular games among users.
*/
SELECT game_id, count(*) AS no_of_installs
FROM fct_user_game_activity
WHERE install_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY game_id
ORDER BY no_of_installs DESC
LIMIT 5;

/*
Question 3
How many users, whose libraries were last updated between July and September 2024, have 3 or more games installed in their library?
*/
SELECT count(*)
FROM dim_users
WHERE installed_games_count >= 3
  AND library_last_updated BETWEEN '2024-07-01' AND '2024-09-30';