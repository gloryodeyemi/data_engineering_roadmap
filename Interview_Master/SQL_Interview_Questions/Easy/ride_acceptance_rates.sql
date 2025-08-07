-- Ride Acceptance Rates Across Geographic Zones

/*
You are a Product Analyst working to understand driver ride selection challenges across different geographic zones. The team wants to identify areas where drivers are less likely to 
accept ride requests. Your analysis will help optimize driver matching and improve ride acceptance strategies.

Question 1 of 3
For each geographic zone, what is the minimum acceptance rate observed during Quarter 2 2024? This information will help assess the worst-case driver acceptance performance by zone.
*/
SELECT zone_name, MIN(acceptance_rate)
FROM fct_zone_daily_rides
WHERE ride_date BETWEEN '2024-04-01' and '2024-06-30'
GROUP BY zone_name;

-- Question 2
-- List the distinct geographic zones that had at least one day in Quarter 2 2024 with an acceptance rate below 50%. This list will be used to identify zones where drivers are generally 
-- more reluctant to accept rides.
SELECT DISTINCT zone_name
FROM fct_zone_daily_rides
WHERE ride_date BETWEEN '2024-04-01' and '2024-06-30'
  AND acceptance_rate < 0.50;

/*
Question 3
Which geographic zone had the lowest ride acceptance rate on a single day in Q2 2024, while also having at least 10 declined ride requests on that same day? Recall that each row in the 
table represents data for a single day in a single geographic region.

This helps us identify specific zone-day combinations where acceptance was especially poor, to guide targeted improvements.
*/
SELECT zone_name
FROM fct_zone_daily_rides
WHERE ride_date BETWEEN '2024-04-01' and '2024-06-30'
  AND declined_requests >= 10
ORDER BY acceptance_rate
LIMIT 1;