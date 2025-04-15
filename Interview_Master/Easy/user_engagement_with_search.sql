-- User Engagement with Search Quality

-- As a Data Analyst on the Google Search Quality team, you are tasked with understanding user engagement with search results. Your goal is to analyze how different user interactions, 
-- such as clicking on links and spending time on the results page, impact overall satisfaction. By leveraging query data, your team aims to identify areas for improving search result 
-- relevance and enhancing the user experience.

-- Question 1 of 3
-- How many search queries were made by users who either clicked on a link or spent more than 30 seconds on the search results page in October 2024?
SELECT COUNT(query_id)
FROM search_queries
WHERE query_date BETWEEN '2024-10-01' AND '2024-10-31'
  AND (clicks = 1 OR dwell_time_seconds > 30);

-- Question 2
-- Can you find out how many search queries in October 2024 were made by users who clicked on a link and spent more than 30 seconds on the search results page?
SELECT COUNT(query_id)
FROM search_queries
WHERE query_date BETWEEN '2024-10-01' AND '2024-10-31'
  AND clicks = 1 
  AND dwell_time_seconds > 30;

-- Question 3
-- For users who signed up in the first week of October 2024 (e.g. October 1 - 7), how many search queries did they make in total?
SELECT COUNT(search_queries.query_id)
FROM search_queries
JOIN users
USING(user_id)
WHERE users.signup_date BETWEEN '2024-10-01' AND '2024-10-07';