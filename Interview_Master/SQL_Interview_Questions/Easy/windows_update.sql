-- Windows Update Adoption and Performance Metrics

/*
As a Data Analyst on the Windows Update team, you are tasked with analyzing user update behaviors to improve the update experience. 
Your team is focused on understanding the fastest installation times and the reliability of error-free installations among users. 
The insights you gather will directly inform strategies to enhance update performance and user satisfaction.

Question 1 of 3
In October 2024, what is the fastest installation time recorded for a Windows update? This metric will help us benchmark the best-case 
update performance for our deployment strategy.
*/
SELECT MIN(installation_time_minutes)
FROM fct_update_installations
WHERE installation_date BETWEEN '2024-10-01' AND '2024-10-31';

-- Question 2
-- In November 2024, how many unique users successfully installed a Windows update without encountering any installation errors? This figure 
-- will help us assess update reliability.
SELECT COUNT(DISTINCT user_id)
FROM fct_update_installations
WHERE installation_date BETWEEN '2024-11-01' AND '2024-11-30'
  AND installation_error = 0;

-- Question 3
-- In December 2024, what is the fastest installation time for Windows updates among users who did not experience any errors? This metric 
-- will directly inform our update communication and deployment strategy to increase adoption rates.
SELECT MIN(installation_time_minutes)
FROM fct_update_installations
WHERE installation_date BETWEEN '2024-12-01' AND '2024-12-31'
  AND installation_error = 0;