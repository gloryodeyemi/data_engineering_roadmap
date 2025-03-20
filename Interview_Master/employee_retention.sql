-- Employee Retention and Satisfaction

-- As a member of the Netflix HR team, you are tasked with addressing employee retention challenges by analyzing employee satisfaction data. Your goal is to identify the 
-- average satisfaction scores across different departments and job categories to pinpoint areas for improvement. By understanding these metrics, your team can develop 
-- targeted strategies to enhance employee engagement and reduce turnover.

-- Question 1 of 3
-- The HR team wants to understand the average satisfaction score of employees across different departments. Can you provide the average satisfaction score rounded down to the 
-- nearest whole number for each department?
SELECT department_id, FLOOR(AVG(satisfaction_score)) AS average_satisfaction_score
FROM employee_satisfaction
GROUP BY department_id;

-- Question 2
-- In addition to the previous analysis, the HR team is interested in knowing the average satisfaction score rounded up to the nearest whole number for each job category. 
-- Can you calculate this using the same data?
SELECT job_category_id, CEIL(AVG(satisfaction_score)) AS average_satisfaction_score
FROM employee_satisfaction
GROUP BY job_category_id;

-- Question 3
-- The HR team wants a consolidated report that includes both the rounded down and rounded up average satisfaction scores for each department and job category. Please rename the 
-- columns appropriately to 'Floor_Avg_Satisfaction' and 'Ceil_Avg_Satisfaction'.
SELECT 
    department_id, 
    job_category_id, 
    FLOOR(AVG(satisfaction_score)) AS Floor_Avg_Satisfaction, 
    CEIL(AVG(satisfaction_score)) AS Ceil_Avg_Satisfaction
FROM employee_satisfaction
GROUP BY department_id, job_category_id;