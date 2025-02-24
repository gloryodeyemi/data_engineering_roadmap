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