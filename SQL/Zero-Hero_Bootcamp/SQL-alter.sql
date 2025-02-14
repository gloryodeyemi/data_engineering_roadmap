CREATE TABLE information (
	info_id SERIAL PRIMARY KEY,
	title VARCHAR(500) NOT NULL,
	person VARCHAR(50) NOT NULL UNIQUE
);

-- change table name
ALTER TABLE information
RENAME TO new_info;

SELECT * FROM new_info;

-- rename column
ALTER TABLE new_info
RENAME COLUMN person TO people;

-- remove constraint
ALTER TABLE new_info
ALTER COLUMN people DROP NOT NULL;

-- insert into new info table
INSERT INTO new_info(title)
VALUES
('some new title');