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

SELECT (
	SUM(CASE WHEN department = 'A' THEN 1 ELSE 0 END)/
	SUM(CASE WHEN department = 'B' THEN 1 ELSE 0 END)
) AS department_ratio
FROM depts;

DELETE FROM depts
WHERE department = 'B';