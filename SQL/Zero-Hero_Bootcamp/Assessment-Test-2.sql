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
SELECT * FROM cd.facilities
WHERE facid IN (1,5);

-- 7. How can you produce a list of members who joined after the start of September 2012? Return the memid, surname, 
-- firstname, and joindate of the members in question.
-- Expected Result is 10 rows
SELECT memid, surname, firstname, joindate
FROM cd.members
WHERE EXTRACT(YEAR FROM joindate) >= 2012
AND EXTRACT(MONTH FROM joindate) >= 9;

-- 8. How can you produce an ordered list of the first 10 surnames in the members table? The list must not contain 
-- duplicates.
-- Expected Result should be 10 rows if you include GUEST as a last name
SELECT DISTINCT surname
FROM cd.members
ORDER BY surname
LIMIT 10;

-- 9. You'd like to get the signup date of your last member. How can you retrieve this information?
-- Expected Result
-- 2012-09-26 18:08:45
SELECT MAX(joindate) AS last_member_joindate
FROM cd.members;

-- 10. Produce a count of the number of facilities that have a cost to guests of 10 or more.
-- Expected Result: 6
SELECT COUNT(*) 
FROM cd.facilities
WHERE guestcost > 10;

-- 11. Produce a list of the total number of slots booked per facility in the month of September 2012. 
-- Produce an output table consisting of facility id and slots, sorted by the number of slots.
-- Expected Result is 9 rows
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
WHERE EXTRACT(YEAR FROM starttime) = 2012
AND EXTRACT(MONTH FROM starttime) = 9
GROUP BY facid;

-- 12. Produce a list of facilities with more than 1000 slots booked. Produce an output table consisting of facility id 
-- and total slots, sorted by facility id.
-- Expected Result is 5 rows
SELECT facid, SUM(slots) AS total_slots
FROM cd.bookings
GROUP BY facid
HAVING SUM(slots) > 1000
ORDER BY facid;

-- 13. How can you produce a list of the start times for bookings for tennis courts, for the date '2012-09-21'? 
-- Return a list of start time and facility name pairings, ordered by the time.
-- Expected Result is 12 rows
SELECT starttime, name
FROM cd.bookings b
LEFT JOIN cd.facilities f
ON b.facid = f.facid
WHERE DATE(starttime) = '2012-09-21'
AND name LIKE '%Tennis Court%'
ORDER BY starttime;







