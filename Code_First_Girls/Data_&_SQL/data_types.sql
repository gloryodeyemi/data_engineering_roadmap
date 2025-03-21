CREATE TABLE Employee (
	employee_ID INT NOT NULL,
	name VARCHAR(50) NOT NULL,
	age INT,
	department VARCHAR(50),
	salary DECIMAL(6,2),
	birthday DATE,
	eligible_for_bonus BOOLEAN
);