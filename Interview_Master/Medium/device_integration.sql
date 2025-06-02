-- Device Integration with Amazon Services

/*
As a Data Analyst on the Amazon Devices team, you are tasked with evaluating the usage patterns of Amazon services on devices like Echo, Fire TV, 
and Kindle. Your goal is to categorize device usage, assess overall engagement levels, and analyze the contribution of Prime Video and Amazon Music 
to total usage. This analysis will inform strategies to optimize service offerings and improve customer satisfaction.

Question 1 of 3
The team wants to identify the total usage duration of the services for each device type by extracting the primary device category from the device 
name for the period from July 1, 2024 to September 30, 2024. The primary device category is derived from the first word of the device name.
*/
SELECT 
  substr(device_name, 1, instr(device_name, ' ') - 1) AS device_category,
  SUM(usage_duration_minutes) AS total_usage_duration
FROM dim_device d
LEFT JOIN fct_device_usage fdu
  ON d.device_id = fdu.device_id
  AND usage_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY substr(device_name, 1, instr(device_name, ' ') - 1);

/*
Question 2
The team also wants to label the usage of each device category into 'Low' or 'High' based on usage duration from July 1, 2024 to September 30, 
2024. If the total usage time was less than 300 minutes, we'll categorize it as 'Low'. Otherwise, we'll categorize it as 'High'.
*/
SELECT 
  substr(device_name, 1, instr(device_name, ' ') - 1) AS device_category,
  SUM(usage_duration_minutes) AS total_usage_duration,
  CASE
    WHEN SUM(usage_duration_minutes) < 300 THEN 'Low'
    ELSE 'High'
  END AS usage_category
FROM dim_device d
LEFT JOIN fct_device_usage fdu
  ON d.device_id = fdu.device_id
  AND usage_date BETWEEN '2024-07-01' AND '2024-09-30'
GROUP BY substr(device_name, 1, instr(device_name, ' ') - 1);

/*
Question 3
The team is considering bundling the Prime Video and Amazon Music subscription. They want to understand what percentage of total usage time comes 
from Prime Video and Amazon Music services respectively. Please use data from July 1, 2024 to September 30, 2024.
*/
SELECT 
  service_name,
  SUM(usage_duration_minutes) * 100.0 / 
  (
    SELECT SUM(usage_duration_minutes) 
    FROM fct_device_usage
    WHERE usage_date BETWEEN '2024-07-01' AND '2024-09-30'
  ) AS total_usage_percentage
FROM dim_service d
LEFT JOIN fct_device_usage fdu
  ON d.service_id = fdu.service_id
  AND usage_date BETWEEN '2024-07-01' AND '2024-09-30'
WHERE d.service_id IN (1, 2)
GROUP BY service_name;

-- Solution 2
WITH third_quarter AS (
  SELECT service_id, usage_duration_minutes
  FROM fct_device_usage
  WHERE usage_date BETWEEN '2024-07-01' AND '2024-09-30'
)
SELECT 
  service_name,
  SUM(usage_duration_minutes) * 100.0 / 
  (SELECT SUM(usage_duration_minutes) FROM third_quarter) AS total_usage_percentage
FROM dim_service d
LEFT JOIN third_quarter t
  ON d.service_id = t.service_id
WHERE d.service_id IN (1, 2)
GROUP BY service_name;