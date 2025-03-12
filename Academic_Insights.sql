--1. Create tables

CREATE TABLE Students (
	StudentId INT PRIMARY KEY,
	First_Name VARCHAR (10),
	Last_Name VARCHAR (10),
	DOB DATE,
	Major VARCHAR(20),
	GPA Decimal (2,2)
	);

INSERT INTO Students(StudentId, First_Name, Last_Name, DOB, Major, GPA)
VALUES
	(1,'Alex', 'Smith',1/1/2000,'Computer Science',3.5),
	(2,'Bella', 'Johnson',2/2/2000,'Business',3.6),
	(3,'Charlie', 'Brown',3/3/2000,'Physics',3.7),
	(4,'Diana', 'Davis',4/4/2000,'Mathematics',3.8),
	(5,'Ethan', 'Miller',5/5/2000,'Biology',3.9);


	
CREATE TABLE Courses(
	CourseID INT PRIMARY KEY,
	CourseName VARCHAR (20),
	Department VARCHAR (20)
	);

INSERT INTO Courses (CourseID, CourseName, Department)
VALUES
	(101,'Intro to CS', 'Computer Science'),
	(102,'Microeconomics', 'Economics'),
	(103,'General Physics', 'Physics'),
	(104,'Calculus I', 'Mathematics'),
	(105,'Biology 101', 'Biology');

	

CREATE TABLE Instructors(
	InstructorID INT PRIMARY KEY,
	InstructorName VARCHAR (10),
	Department VARCHAR (20)
	);

INSERT INTO Instructors (InstructorID, InstructorName, Department)
VALUES
	(201,'Dr. Adams', 'Computer Science'),
	(202,'Dr. Baker', 'Economics'),
	(203,'Dr. Clark', 'Physics'),
	(204,'Dr. Davis', 'Mathematics'),
	(205,'Dr, Evans', 'Biology');


CREATE TABLE Enrollments(
	EnrollmentID INT PRIMARY KEY,
	StudentId INT,
	CourseID INT,
	Semester VARCHAR (10),
	Grade VARCHAR (5)
	);



INSERT INTO Enrollments (EnrollmentID, StudentId, CourseID, Semester, Grade)
VALUES 
	(301,1,101,'Fall 2023','A'),
	(302,2,102,'Fall 2023','B'),
	(303,3,103,'Fall 2023','C'),
	(304,4,104,'Fall 2023','D'),
	(305,5,105,'Fall 2023','F');


CREATE VIEW CourseSummary AS
SELECT CourseID, COUNT(StudentId) AS Total_student_per_course
FROM Enrollments e
GROUP BY CourseID;


--2. Create a view InstructorSchedule

CREATE VIEW InstructorSchedule AS
SELECT InstructorName, CourseName, Department 
FROM Instructors i 
LEFT JOIN Courses c ON i.Department = c.Department;


--3. Modify CourseSummary 
--** Alter View did not work in DBeaver **

ALTER VIEW CourseSummary AS
SELECT DISTINCT Semester, CourseName, COUNT(StudentId) AS Total_student_enrollmt
FROM Enrollments e
INNER JOIN Courses c ON e.CourseID = c.CourseID
GROUP BY CourseName;


--4. Update InstructorSchedule

ALTER VIEW InstructorSchedule AS
SELECT CourseID, CourseName, Semester
FROM Enrollments e
INNER JOIN Courses c ON c.CourseID = e.CourseID
WHERE Semester = 'Fall 2023'
ORDER BY CourseID ASC;


--5. Create EligibleGraduates View

CREATE VIEW EligibleGraduates AS
SELECT StudentId, First_Name, Last_Name
FROM Students s 
WHERE GPA >= 3.7;


--6. Alter EligibleGraduates to include GPAs

ALTER VIEW EligibleGraduates AS
SELECT StudentId, First_Name, Last_Name, GPA
FROM Students s 
WHERE GPA >= 3.7;

--7. Rename CourseSummary
-- ** Rename function didn't work

RENAME TABLE CourseSummary TO 
CourseEnrollmentSummary;

--8. Drop EligibleGraduates

DROP VIEW EligibleGraduates;


--9. Create a CTE and Subquery

WITH SemesterCourses AS (
	SELECT
		CourseID, Semester AS Current_semester
		FROM Enrollments e
		WHERE Semester = 'Fall 2023' 
		ORDER BY CourseId ASC
		)
SELECT * FROM SemesterCourses;


--Show the average gpa of students in Mathematics and Biology majors


SELECT DISTINCT Major, StudentId, AVG(GPA) AS average_gpa
FROM Students
WHERE StudentId IN (
    SELECT StudentId 
    FROM students
    WHERE Major IN ('Mathematics','Biology')
    GROUP BY Major);
   










	

