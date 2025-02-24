-- Get information on all table names in the current database, while limiting your query to the 'public' table_schema.
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';

-- Now have a look at the columns in university_professors by selecting all entries in information_schema.columns that correspond to that table.
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'university_professors' AND table_schema = 'public';

-- Create a table professors with two text columns: firstname and lastname.
CREATE TABLE professors (
 firstname text,
 lastname text
);

-- Create a table universities with three text columns: university_shortname, university, and university_city.
CREATE TABLE universities (
    university_shortname text,
    university text,
    university_city text
);

-- Alter professors to add the text column university_shortname.
ALTER TABLE professors
ADD COLUMN university_shortname text;

-- Rename the organisation column to organization in affiliations.
ALTER TABLE affiliations
RENAME COLUMN organisation TO organization;

-- Delete the university_shortname column in affiliations.
ALTER TABLE affiliations
DROP COLUMN university_shortname;

-- Insert all DISTINCT professors from university_professors into professors.
-- Print all the rows in professors.
INSERT INTO professors 
SELECT DISTINCT firstname, lastname, university_shortname 
FROM university_professors;

SELECT * 
FROM professors;

-- Insert all DISTINCT affiliations into affiliations from university_professors.
INSERT INTO affiliations 
SELECT DISTINCT firstname, lastname, function, organization 
FROM university_professors;

-- Delete the university_professors table.
DROP TABLE university_professors;

-- Execute the given sample code.
-- As it doesn't work, add an integer type cast at the right place and execute it again.
SELECT transaction_date, amount + CAST(fee AS INTEGER) AS net_amount 
FROM transactions;

-- Specify a fixed-length character type with the correct length for university_shortname.
ALTER TABLE professors
ALTER COLUMN university_shortname
TYPE char(3);

-- Change the type of the firstname column to varchar(64).
ALTER TABLE professors
ALTER COLUMN firstname
TYPE VARCHAR(64);

-- Use SUBSTRING() to reduce firstname to 16 characters so its type can be altered to varchar(16).
ALTER TABLE professors 
ALTER COLUMN firstname 
TYPE varchar(16)
USING SUBSTRING(firstname FROM 1 FOR 16);

-- Add a not-null constraint for the firstname column.
ALTER TABLE professors 
ALTER COLUMN firstname SET NOT NULL;

-- Add a not-null constraint for the lastname column.
ALTER TABLE professors 
ALTER COLUMN lastname SET NOT NULL;

-- Add a unique constraint to the university_shortname column in universities. Give it the name university_shortname_unq.
ALTER TABLE universities
ADD CONSTRAINT university_shortname_unq UNIQUE(university_shortname);

-- Add a unique constraint to the organization column in organizations. Give it the name organization_unq.
ALTER TABLE organizations
ADD CONSTRAINT organization_unq UNIQUE(organization);

-- First, find out the number of rows in universities.
SELECT COUNT(*) 
FROM universities;

-- Then, find out how many unique values there are in the university_city column.
SELECT COUNT(DISTINCT(university_city)) 
FROM universities;

-- Identify the candidate key by trying out different combination of columns.
SELECT COUNT(DISTINCT(firstname, lastname)) 
FROM professors;

-- Rename the organization column to id in organizations.
-- Make id a primary key and name it organization_pk.
ALTER TABLE organizations
RENAME COLUMN organization TO id;

ALTER TABLE organizations
ADD CONSTRAINT organization_pk PRIMARY KEY (id);

-- Rename the university_shortname column to id in universities.
-- Make id a primary key and name it university_pk.
ALTER TABLE universities
RENAME COLUMN university_shortname TO id;

ALTER TABLE universities
ADD CONSTRAINT university_pk PRIMARY KEY (id);

-- Add a new column id with data type serial to the professors table.
ALTER TABLE professors 
ADD COLUMN id SERIAL;

-- Make id a primary key and name it professors_pkey.
ALTER TABLE professors 
ADD CONSTRAINT professors_pkey PRIMARY KEY (id);

-- Write a query that returns all the columns and 10 rows from professors.
SELECT *
FROM professors
LIMIT 10;

-- Count the number of distinct rows with a combination of the make and model columns.
SELECT COUNT(DISTINCT(make, model))
FROM cars;

-- Add a new column id with the data type varchar(128).
ALTER TABLE cars
ADD COLUMN id VARCHAR(128);

-- Concatenate make and model into id using an UPDATE table_name SET column_name = ... query and the CONCAT() function.
UPDATE cars
SET id = CONCAT(make, model);

-- Make id a primary key and name it id_pk.
ALTER TABLE cars
ADD CONSTRAINT id_pk PRIMARY KEY(id);

-- Let's think of an entity type "student". A student has:
-- a last name consisting of up to 128 characters (required),
-- a unique social security number, consisting only of integers, that should serve as a key,
-- a phone number of fixed length 12, consisting of numbers and characters (but some students don't have one).
-- Given the above description of a student entity, create a table students with the correct column types.
-- Add a PRIMARY KEY for the social security number ssn.
-- Note that there is no formal length requirement for the integer column. The application would have to make sure it's a correct SSN!
CREATE TABLE students (
  last_name VARCHAR(128) NOT NULL,
  ssn INTEGER PRIMARY KEY,
  phone_no CHAR(12)
);

-- Rename the university_shortname column to university_id in professors.
ALTER TABLE professors
RENAME COLUMN university_shortname TO university_id;

-- Add a foreign key on university_id column in professors that references the id column in universities.
-- Name this foreign key professors_fkey.
ALTER TABLE professors 
ADD CONSTRAINT professors_fkey FOREIGN KEY (university_id) REFERENCES universities (id);

-- JOIN professors with universities on professors.university_id = universities.id, i.e., retain all records where the foreign key of professors is equal to the 
-- primary key of universities.
-- Filter for university_city = 'Zurich'.
SELECT professors.lastname, universities.id, universities.university_city
FROM professors
JOIN universities
ON professors.university_id = universities.id
WHERE universities.university_city = 'Zurich';