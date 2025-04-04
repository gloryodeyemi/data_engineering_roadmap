-- Stays Host Communication Response Time Performance

-- As a Data Analyst on the Airbnb Stays team, you are tasked with evaluating host response times to guest inquiries. Your team is focused on understanding how quickly hosts 
-- are responding to improve the guest experience. By analyzing response times, you aim to identify trends and outliers in host responsiveness to inform potential improvements.

-- Question 1 of 3
-- What is the minimum host response time in hours for guest inquiries in January 2024? This metric will help identify if any hosts are setting an exceptionally quick response standard.
SELECT MIN(response_time_hours)
FROM fct_guest_inquiries
WHERE inquiry_date BETWEEN '2024-01-01' AND '2024-01-31';

-- Question 2
-- For guest inquiries made in January 2024, what is the average host response time rounded to the nearest hour? This average will provide insight into overall host responsiveness.
SELECT ROUND(AVG(response_time_hours))
FROM fct_guest_inquiries
WHERE inquiry_date BETWEEN '2024-01-01' AND '2024-01-31';

-- Question 3 of 3
-- List the inquiry_id and response_time_hours for guest inquiries made between January 16th and January 31st, 2024 that took longer than 2 hours to respond. This breakdown will help 
-- pinpoint hosts with slower response times.
SELECT inquiry_id, response_time_hours
FROM fct_guest_inquiries
WHERE inquiry_date BETWEEN '2024-01-16' AND '2024-01-31'
  AND response_time_hours > 2;