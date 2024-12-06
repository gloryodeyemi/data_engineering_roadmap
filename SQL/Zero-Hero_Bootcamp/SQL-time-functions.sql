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

-- EXTRACT()
-- allows you to extract or obtain a sub-component of a date value.
-- YEAR, MONTH, DAY, WEEK, QUARTER.
SELECT EXTRACT(YEAR FROM payment_date) AS payyear
FROM payment;

SELECT EXTRACT(MONTH FROM payment_date) AS paymonth
FROM payment;

SELECT EXTRACT(QUARTER FROM payment_date) AS payquarter
FROM payment;


-- AGE()
-- calculates and returns the current age given a timestamp.
SELECT AGE(payment_date)
FROM payment;

-- TO_CHAR()
-- general function to convert data types to text. It is useful for timestamp 
-- formatting.
SELECT TO_CHAR(payment_date, 'MONTH-YYYY')
FROM payment;

SELECT TO_CHAR(payment_date, 'mon/dd/yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'mm/dd/yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'mm-dd-yyyy')
FROM payment;

SELECT TO_CHAR(payment_date, 'dd-mm-yyyy')
FROM payment;
