-- Day 5 of SQL Advent Calendar

-- Today's Question:
-- This year, we're celebrating Christmas in the Southern Hemisphere! Which beaches are expected to have temperatures above 
-- 30°C on Christmas Day?

-- Table name: beach_temperature_predictions

-- beach_name	country	expected_temperature_c	date
-- Bondi Beach	Australia	32	2024-12-24
-- Copacabana Beach	Brazil	28	2024-12-24
-- Clifton Beach	South Africa	31	2024-12-25
-- Brighton Beach	New Zealand	25	2024-12-25

-- Solution
SELECT * FROM beach_temperature_predictions
WHERE expected_temperature_c > 30
AND date = '2024-12-25';