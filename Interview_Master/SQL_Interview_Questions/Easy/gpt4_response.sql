-- GPT-4 Response Context Depth Analysis

-- You are a Data Analyst on the OpenAI GPT-4 team, focusing on evaluating the model's ability to retain context and handle complex inquiries 
-- across different domains. Your team is particularly interested in understanding the average and peak performance of GPT-4's context 
-- retention, as well as identifying which inquiry types may require further enhancements. By analyzing these metrics, you will provide 
-- insights to guide improvements in GPT-4's contextual processing capabilities.

-- Question 1 of 3
-- What is the average context retention score for GPT-4 responses in April 2024? This will help us determine a baseline measure of 
-- GPT-4's response complexity.
SELECT AVG(context_retention_score)
FROM fct_context_retention
WHERE model_name = 'GPT-4'
  AND response_date BETWEEN '2024-04-01' AND '2024-04-30';

-- Question 2
-- What is the highest context retention score recorded by GPT-4 for the 'legal' inquiry type in April 2024? This will highlight the peak 
-- performance in terms of contextual processing.
SELECT MAX(context_retention_score)
FROM fct_context_retention
WHERE model_name = 'GPT-4'
  AND inquiry_type = 'legal'
  AND response_date BETWEEN '2024-04-01' AND '2024-04-30';

-- Question 3
-- What is the average context retention score for each inquiry type for GPT-4 responses in April 2024, rounded to two decimal places? 
-- This breakdown will directly inform which inquiry domains may need enhancements in GPT-4's contextual understanding.
SELECT inquiry_type, ROUND(AVG(context_retention_score), 2)
FROM fct_context_retention
WHERE model_name = 'GPT-4'
  AND response_date BETWEEN '2024-04-01' AND '2024-04-30'
GROUP BY inquiry_type;