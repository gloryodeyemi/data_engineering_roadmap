-- App Download Conversion Rates by Category

/*
You are on the Google Play store's App Marketplace team. You and your team want to understand how different app categories convert from browsing 
to actual downloads. This analysis is critical in informing future product placement and marketing strategies for app developers and users.

Question 1 of 3
The marketplace team wants to identify high and low performing app categories. Provide the total downloads for the app categories for November 
2024. If there were no downloads for that category, return the value as 0.
*/
SELECT category, IFNULL(SUM(download_count), 0) AS total_downloads
FROM dim_app da
LEFT JOIN fct_app_downloads fap
  ON da.app_id = fap.app_id
  AND download_date BETWEEN '2024-11-01' AND '2024-11-30'
GROUP BY category;

/*
Question 2
Our team's goal is download conversion rate — defined as downloads per browse event. For each app category, calculate the download conversion rate 
in December, removing categories where browsing counts are zero.
*/
SELECT 
  category, 
  SUM(download_count) * 1.0 / SUM(browse_count) AS download_conversion_rate
FROM dim_app da
LEFT JOIN fct_app_browsing fab
  ON da.app_id = fab.app_id
  AND browse_date BETWEEN '2024-12-01' AND '2024-12-31'
LEFT JOIN fct_app_downloads fap
  ON da.app_id = fap.app_id
  AND download_date BETWEEN '2024-12-01' AND '2024-12-31'
GROUP BY category
HAVING SUM(browse_count) > 0;

-- Solution 2
WITH browse_sum AS (
  SELECT category, SUM(browse_count) AS b_sum
  FROM dim_app da
  LEFT JOIN fct_app_browsing fab
    ON da.app_id = fab.app_id
    AND browse_date BETWEEN '2024-12-01' AND '2024-12-31'
  GROUP BY category
  HAVING SUM(browse_count) > 0
),
download_sum AS (
  SELECT category, SUM(download_count) AS d_sum
  FROM dim_app da
  LEFT JOIN fct_app_downloads fap
    ON da.app_id = fap.app_id
    AND download_date BETWEEN '2024-12-01' AND '2024-12-31'
  GROUP BY category
)
SELECT 
  b.category, 
  d_sum * 1.0 / b_sum AS download_conversion_rate
FROM browse_sum b
JOIN download_sum d
  ON b.category = d.category
GROUP BY b.category;

/*
Question 3
The team wants to compare conversion rates between free and premium apps across all categories. Combine the conversion data for both app types to 
present a unified view for Q4 2024.
*/
WITH browse_sum AS (
  SELECT app_type, SUM(browse_count) AS b_sum
  FROM dim_app da
  LEFT JOIN fct_app_browsing fab
    ON da.app_id = fab.app_id
    AND browse_date BETWEEN '2024-10-01' AND '2024-12-31'
  GROUP BY app_type
  HAVING SUM(browse_count) > 0
),
download_sum AS (
  SELECT app_type, SUM(download_count) AS d_sum
  FROM dim_app da
  LEFT JOIN fct_app_downloads fap
    ON da.app_id = fap.app_id
    AND download_date BETWEEN '2024-10-01' AND '2024-12-31'
  GROUP BY app_type
)
SELECT 
  b.app_type, 
  d_sum * 1.0 / b_sum AS download_conversion_rate
FROM browse_sum b
JOIN download_sum d
  ON b.app_type = d.app_type
GROUP BY b.app_type;