-- CHECK constraints
CREATE TABLE employees (
	emp_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	birthdate DATE CHECK (birthdate > '1990-01-01'),
	hire_date DATE CHECK (hire_Date > birthdate),
	salary INTEGER CHECK (salary > 0)
);

INSERT INTO employees(
	first_name, 
	last_name, 
	birthdate, 
	hire_date, 
	salary
	)
VALUES
('Jose', 'Portilla', '1990-11-03', '2010-01-01', 100),
('Sammy', 'Smith', '1990-11-03', '2010-01-01', 1000);

SELECT * FROM employees;