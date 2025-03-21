CREATE DATABASE cfg_courses;
USE cfg_courses;

DROP TABLE Course;
DROP TABLE Instructor;

CREATE TABLE Course (
	course_id INT NOT NULL,
	course_name VARCHAR(100) NOT NULL,
	description VARCHAR(255) NULL
);

CREATE TABLE Instructor (
	instructor_id INT NOT NULL,
	instructor_name VARCHAR(100) NOT NULL,
	email VARCHAR(255) NOT NULL
);

INSERT INTO Course
VALUES 
(1, 'Introduction to SQL', 'An introductory course on SQL and data'),
(2, 'Introduction to Python', 'A beginner friendly course on Python');

INSERT INTO Instructor
VALUES 
(1, 'Alison Johnson', 'a.johnson@example.com'),
(2, 'Bob Smith', 'b.smith@example.com');