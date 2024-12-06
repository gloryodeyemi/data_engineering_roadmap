-- TIME - contains only time
-- DATE - contains only date
-- TIMESTAMP - contains date and time
-- TIMESTAMPTZ - contains date, time, and timezone information.
-- Note, you can always remove historical information, but you can't add it.

-- Functions
-- TIMEZONE, NOW, TIMEOFDAY, CURRENT_TIME, CURRENT_DATE

SHOW TIMEZONE;

SELECT NOW();

SELECT TIMEOFDAY();

SELECT CURRENT_TIME;

SELECT CURRENT_DATE;