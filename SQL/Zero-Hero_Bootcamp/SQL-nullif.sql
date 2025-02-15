-- NULLIF
-- takes in 2 inputs and returns NULL if both are equal, otherwise it returns the first argument passed.
-- becomes useful in cases where a NULL value would cause an error or unwanted result.

CREATE TABLE depts(
	first_name VARCHAR(50),
	department VARCHAR(50)
);

INSERT INTO depts(first_name, department)
VALUES
('Vinton', 'A'),
('Lauren', 'A'),
('Claire', 'B');