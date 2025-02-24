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