-- Assessment Test 2

-- 1. How can you retrieve all the information from the cd.facilities table?
SELECT * FROM cd.facilities;

-- 2. You want to print out a list of all of the facilities and their cost to members. 
-- How would you retrieve a list of only facility names and costs?
SELECT name, membercost
FROM cd.facilities;

-- 3. How can you produce a list of facilities that charge a fee to members?
-- Expected Results should have just 5 rows:
SELECT *
FROM cd.facilities
WHERE membercost > 0;

-- 4. How can you produce a list of facilities that charge a fee to members, and that fee is less than 1/50th of 
-- the monthly maintenance cost? Return the facid, facility name, member cost, and monthly maintenance of the 
-- facilities in question.
-- Result is just two rows:
SELECT facid, name, membercost, monthlymaintenance
FROM cd.facilities
WHERE membercost > 0
AND membercost < monthlymaintenance/50;

-- 5. How can you produce a list of all facilities with the word 'Tennis' in their name?
-- Expected Result is 3 rows
SELECT * FROM cd.facilities
WHERE name LIKE '%Tennis%';

-- 6. How can you retrieve the details of facilities with ID 1 and 5? Try to do it without using the OR operator.
-- Expected Result is 2 rows


