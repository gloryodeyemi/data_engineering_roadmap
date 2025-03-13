-- Ad Segment Performance Analysis

-- As a Data Analyst on the Marketing Performance team, you are tasked with evaluating the effectiveness of our custom audience segments and lookalike audiences in driving user 
-- acquisition and conversions. Your team aims to optimize advertising strategies by analyzing key performance metrics such as ad impressions, total conversions, and cost per 
-- conversion across different audience segments. By leveraging this data, you will provide actionable insights to enhance campaign efficiency and improve overall marketing performance.

-- Question 1 of 3
-- How many total ad impressions did we receive from custom audience segments in October 2024?
SELECT SUM(impressions) AS total_ad_impressions
FROM ad_performance
JOIN audience_segments
USING(audience_segment_id)
WHERE segment_name LIKE 'Custom Audience%'
AND date BETWEEN '2024-10-01' AND '2024-10-31';

-- Question 2
-- What is the total number of conversions we achieved from each custom audience segment in October 2024?
SELECT segment_name, SUM(conversions) AS total_conversions
FROM ad_performance
JOIN audience_segments
USING(audience_segment_id)
WHERE segment_name LIKE 'Custom Audience%'
AND date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY segment_name;

-- Question 3
-- For each custom audience or lookalike segment, calculate the cost per conversion. Only return this for segments that had non-zero spend and non-zero conversions.
-- Cost per conversion = Total ad spend / Total number of conversions
SELECT segment_name, SUM(ad_spend) / SUM(conversions) AS cost_per_conversion
FROM ad_performance
JOIN audience_segments
USING(audience_segment_id)
WHERE (segment_name LIKE 'Custom Audience%' OR segment_name LIKE 'Lookalike Audience%')
  AND ad_spend > 0
  AND conversions > 0
GROUP BY segment_name;