-- Prime Video Content Performance by Category

/*
As a Product Analyst on the Prime Video team, you are tasked with evaluating content engagement across various movie and show categories. 
Your team aims to identify which genres are most engaging to viewers to prioritize content acquisition and enhance recommendation strategies. 
The end goal is to optimize content investments and improve viewer satisfaction by focusing on high-performing categories.

Question 1 of 3
What is the aggregated view events across each content category in August 2024? This information will help the Prime Video team understand 
which content genres are engaging users during that month.
*/
SELECT category, AVG(views)
FROM content_views_daily_agg
WHERE view_date BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY category;

/*
Question 2
Which content categories accumulated over 100,000 total views during the third quarter of 2024? This analysis will help identify the genres 
that are attracting a high volume of viewer engagement.
*/
SELECT category, SUM(views)
FROM content_views_daily_agg
WHERE view_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY category
  HAVING SUM(views) > 100000; 

/*
Question 3
In September 2024, for content categories that received more than 500,000 aggregated views, what is the total views for the month and 
the average number of views per day?
Note that the table provided is a daily aggregation table, so each row represents the total views per day per category.
*/
SELECT 
  category, 
  SUM(views) AS total_month_views,
  AVG(views) AS avg_daily_views
FROM content_views_daily_agg
WHERE view_date BETWEEN '2024-09-01' AND '2024-09-30'
GROUP BY category
  HAVING SUM(views) > 500000;