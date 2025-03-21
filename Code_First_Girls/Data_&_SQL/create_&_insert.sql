CREATE DATABASE cfg_courses;
USE cfg_courses;

CREATE TABLE Course (
	course_id INT,
	course_name VARCHAR(100),
	description VARCHAR(255)
);

CREATE TABLE Instructor (
	instructor_id INT,
	instructor_name VARCHAR(100),
	email VARCHAR(255)
);

INSERT INTO Course
VALUES 
(1, 'Introduction to SQL', 'An introductory course on SQL and data'),
(2, 'Introduction to Python', 'A beginner friendly course on Python');

INSERT INTO Instructor
VALUES 
(1, 'Alison Johnson', 'a.johnson@example.com'),
(2, 'Bob Smith', 'b.smith@example.com');