-- Spark Augmented Reality (AR) Filter Engagement Metrics

/*
As a member of the Marketing Analytics team at Meta, you are tasked with evaluating the performance of branded AR filters. Your goal is to 
identify which filters are driving the highest user interactions and shares to inform future campaign strategies for brands using the Spark 
AR platform. By analyzing engagement data, your team aims to provide actionable insights that will enhance campaign effectiveness and 
audience targeting.

Question 1 of 3
Which AR filters have generated user interactions in July 2024? List the filters by name.
Would you like to talk through your approach, or are you ready to start coding?
*/
SELECT DISTINCT filter_name
FROM ar_filters a1
JOIN ar_filter_engagements a2
  ON a1.filter_id = a2.filter_id
  AND engagement_date BETWEEN '2024-07-01' AND '2024-07-31';

-- Question 2
-- How many total interactions did each AR filter receive in August 2024? Return only filter names that received over 1000 interactions, 
-- and their respective interaction counts.
SELECT filter_name, SUM(interaction_count) AS total_interactions
FROM ar_filters a1
JOIN ar_filter_engagements a2
  ON a1.filter_id = a2.filter_id
  AND engagement_date BETWEEN '2024-08-01' AND '2024-08-31'
GROUP BY filter_name
  HAVING SUM(interaction_count) > 1000;

-- Question 3
-- What are the top 3 AR filters with the highest number of interactions in September 2024, and how many interactions did each receive?
SELECT filter_name, SUM(interaction_count) AS total_interactions
FROM ar_filters a1
JOIN ar_filter_engagements a2
  ON a1.filter_id = a2.filter_id
  AND engagement_date BETWEEN '2024-09-01' AND '2024-09-30'
GROUP BY filter_name
ORDER BY total_interactions DESC
LIMIT 3;