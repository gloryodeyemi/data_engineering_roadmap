-- Day 22 of SQL Advent Calendar

-- Today's Question:
-- We are hosting a gift party and need to ensure every guest receives a gift. Using the guests and guest_gifts tables, write 
-- a query to identify the guest(s) who have not been assigned a gift (i.e. they are not listed in the guest_gifts table).

-- Table name: guests
-- guest_id	guest_name
-- 1	Cindy Lou
-- 2	The Grinch
-- 3	Max the Dog
-- 4	Mayor May Who

-- Table name: guest_gifts
-- gift_id	guest_id	gift_name
-- 1	1	Toy Train
-- 2	1	Plush Bear
-- 3	2	Bag of Coal
-- 4	2	Sleigh Bell
-- 5	3	Dog Treats

-- Solution
SELECT guests.guest_id, guest_name
FROM guests
LEFT JOIN guest_gifts
ON guests.guest_id = guest_gifts.guest_id
GROUP BY guests.guest_id
HAVING guest_gifts.guest_id IS NULL;