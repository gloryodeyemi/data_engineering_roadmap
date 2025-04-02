-- Marketing Segment Strategy Cross-Brand Alignment

/*
As a Data Analyst, you and your team are tasked with evaluating brand consistency across Amazon's diverse business segments, including retail, AWS, and entertainment. The focus is on 
analyzing key messaging and brand perception metrics to ensure strategic alignment across these segments. Your goal is to identify opportunities for more unified brand communication by 
examining brand scores and key messages in these areas.

Question 1 of 3
The Marketing team wants to start their evaluation of brand messaging for Q4 2024. Could you provide a list of the key messaging and brand score details recorded between October 1, 2024 
and December 31, 2024?
*/
SELECT key_message, brand_score
FROM brand_score_metrics
WHERE metric_date BETWEEN '2024-10-01' AND '2024-12-31';

-- Question 2
-- For a more focused analysis, the Marketing team needs the key messaging and brand score details for the AWS segment (represented by segment_id = 2) in Q4 2024, but only for records where 
-- the brand score is at or above 90. Could you retrieve these details?
SELECT key_message, brand_score
FROM brand_score_metrics
WHERE metric_date BETWEEN '2024-10-01' AND '2024-12-31'
  AND segment_id = 2
  AND brand_score >= 90;

-- Question 3
-- To quickly review a snapshot of the findings, the Marketing team would like to see a sample of the key messaging and brand score details for the Entertainment segment 
-- (represented by segment_id = 3) with a brand score above 80. Could you provide the 5 most recent records that meet these criteria?
SELECT key_message, brand_score
FROM brand_score_metrics
WHERE segment_id = 3
  AND brand_score > 80
ORDER BY metric_date DESC
LIMIT 5;