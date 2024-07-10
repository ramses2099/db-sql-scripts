-- Create a new database called 'testdb'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'testdb'
)
CREATE DATABASE testdb
GO
USE testdb;

-- Create a new table called '[Student]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Student]', 'U') IS NOT NULL
DROP TABLE [dbo].[Student]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Student]
(
    [Id] VARCHAR(10) NOT NULL PRIMARY KEY, -- Primary Key column
    [First] NVARCHAR(50) NOT NULL,
    [Last] NVARCHAR(50) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Student(ID,[First],[Last])VALUES('S103','Jhon','Smith'),
('S104','Mary','Jones'),
('S105','Jane','Brown'),
('S106','Mark','Jones'),
('S107','Jhon','Smith');

-- Create a new table called '[Course]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Course]', 'U') IS NOT NULL
DROP TABLE [dbo].[Course]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Course]
(
    [Code] VARCHAR(10) NOT NULL PRIMARY KEY, -- Primary Key column
    [Title] NVARCHAR(250) NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Course(Code, Title) VALUES('DBS','Database Systems'),
('PR1','Programming 1'),
('PR2','Programming 2'),
('IAI','Intro to AI');


-- Create a new table called '[Grade]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Grade]', 'U') IS NOT NULL
DROP TABLE [dbo].[Grade]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Grade]
(
    [Id] VARCHAR(10) NOT NULL, -- Primary Key column
    [Code] VARCHAR(10) NOT NULL,
    [Mark] INT NOT NULL
    -- Specify more columns here
);
GO

INSERT INTO Grade(Id,Code,Mark)VALUES('S103','DBS', 72),
('S103', 'IAI', 58),
('S104', 'PR1', 68),
('S104', 'IAI', 65),
('S106', 'PR2',43),
('S107', 'PR1', 76),
('S107', 'PR2', 60),
('S107', 'IAI', 35);


-- List all students in the database.   
SELECT * FROM Student; 
-- Find the titles of all courses offered.
SELECT Title FROM Course;     
-- Retrieve all details of the student with ID 'S103'.    
SELECT * FROM Student WHERE Id = 'S103'; 
-- Find all courses where the code is 'IAI'. 
SELECT * FROM Course WHERE Code = 'IAI';    
-- List all grades for the student with ID 'S104'.
SELECT Mark FROM Grade WHERE Id = 'S104';     
-- Find all students with the last name 'Jones'.
SELECT * FROM Student WHERE [Last] = 'Jones';     
-- Retrieve the names of students who have 'John' as their first name. 
SELECT * FROM Student WHERE [First] = 'John';    
-- Find all grades that are above 70.
SELECT * FROM Grade WHERE Mark > 70;     
-- List all courses taken by the student with ID 'S107'. 
SELECT * FROM Grade WHERE Id = 'S107'    
-- Find the grades for the 'Programming 1' course (Code: 'PR1').
SELECT * FROM Grade WHERE Code ='PR1';




-- IN Operator: List all students with IDs 'S103', 'S105', and 'S107'.
SELECT * FROM Student
WHERE Id IN ('S103', 'S105', 'S107');
-- AND Operator: Retrieve all students with the first name 'John' and last name 'Smith'.
SELECT * FROM Student
WHERE First = 'Jhon' AND Last = 'Smith';
-- OR Operator: Find students with the first name 'John' or last name 'Jones'.
SELECT * FROM Student
WHERE First = 'Jhon' OR Last = 'Jones';
-- NOT Operator: List students who are not named 'John'.
SELECT * FROM Student
WHERE First != 'Jhon';
-- Subquery: Retrieve the names of students who have taken the course 'Database Systems' (Code: 'DBS').
SELECT First, Last
FROM Student
WHERE Id IN (
    SELECT Id
    FROM Grade
    WHERE Code = 'DBS'
);
-- BETWEEN Operator: Find courses with codes between 'PR1' and 'PR2'.
SELECT * FROM Course
WHERE Code BETWEEN 'PR1' AND 'PR2';
-- AND with NOT Operator: List students who are not named 'John' and are not enrolled in any course.
SELECT * FROM Student
WHERE First != 'Jhon'
AND Id NOT IN (
    SELECT DISTINCT Id
    FROM Grade
);
-- OR with Subquery: Retrieve students who are enrolled in either 'Programming 1' (Code: 'PR1') or 'Database Systems' (Code: 'DBS').
SELECT * FROM Student
WHERE Id IN (
    SELECT Id
    FROM Grade
    WHERE Code = 'PR1'
       OR Code = 'DBS'
);
-- AND with BETWEEN: Find students with IDs between 'S103' and 'S107' who are enrolled in any course.
SELECT DISTINCT Student.*
FROM Student
JOIN Grade ON Student.Id = Grade.Id
WHERE Student.Id BETWEEN 'S103' AND 'S107';
-- Subquery with AND and NOT: Retrieve students who are enrolled in 'Programming 1' (Code: 'PR1') but not in 'Intro to AI' (Code: 'IAI').
SELECT * FROM Student
WHERE Id IN (
    SELECT Id
    FROM Grade
    WHERE Code = 'PR1'
)
AND Id NOT IN (
    SELECT Id
    FROM Grade
    WHERE Code = 'IAI'
);


-- Find the student who has the highest mark in 'Database Systems' (Code: 'DBS').
WITH grade_cte AS(
SELECT Id, MAX(Mark)as MaxGrade FROM Grade WHERE Code ='DBS'
GROUP BY Id)
SELECT s.id, s.[First],[Last], gc.MaxGrade
 FROM grade_cte gc INNER JOIN Student s ON s.Id = gc.Id

-- List all students who have taken a course not yet taken by 'John Smith' (ID: 'S103').
SELECT DISTINCT Student.*
FROM Student
JOIN Grade ON Student.Id = Grade.Id
WHERE Grade.Code NOT IN (
    SELECT Code
    FROM Grade
    WHERE Id = 'S103'
);
-- Retrieve students who have never taken 'Programming 2' (Code: 'PR2').
SELECT * 
FROM Student
WHERE Id NOT IN (
    SELECT Id
    FROM Grade
    WHERE Code = 'PR2'
);
-- Find the courses taken by 'Jane Brown' (ID: 'S105') but not by 'John Brown' (ID: 'S107').
SELECT Course.*
FROM Course
WHERE Code IN (
    SELECT Code
    FROM Grade
    WHERE Id = 'S105'
)
AND Code NOT IN (
    SELECT Code
    FROM Grade
    WHERE Id = 'S107'
);
-- List students who have taken exactly one course.
SELECT Student.*
FROM Student
WHERE Id IN (
    SELECT Id
    FROM Grade
    GROUP BY Id
    HAVING COUNT(Code) = 1
);
-- Retrieve the names of students who have not taken any courses with a mark below 50.
SELECT Student.*
FROM Student
WHERE Id NOT IN (
    SELECT Id
    FROM Grade
    WHERE Mark < 50
);
-- Find the courses that 'Mary Jones' (ID: 'S104') has taken but received a mark lower than the average mark of 'John Smith' (ID: 'S103') in the same course.
SELECT Course.*
FROM Course
WHERE Code IN (
    SELECT Code
    FROM Grade AS g1
    WHERE g1.Id = 'S104'
    AND g1.Mark < (
        SELECT AVG(g2.Mark)
        FROM Grade AS g2
        WHERE g2.Code = g1.Code
        AND g2.Id = 'S103'
    )
);
-- List the students who have taken the most courses.
SELECT Student.*
FROM Student
WHERE Id IN (
    SELECT Id
    FROM Grade
    GROUP BY Id
    HAVING COUNT(Code) = (
        SELECT MAX(CourseCount)
        FROM (
            SELECT COUNT(Code) AS CourseCount
            FROM Grade
            GROUP BY Id
        ) AS Counts
    )
);
-- Retrieve the IDs of students who have taken all the courses offered.
SELECT Id
FROM Grade
GROUP BY Id
HAVING COUNT(DISTINCT Code) = (
    SELECT COUNT(DISTINCT Code)
    FROM Course
);
-- Find the average mark for each course and list the courses where 'John Smith' (ID: 'S103') has a mark below the course average.
SELECT Course.*, g1.Mark, AvgMarks.AvgMark
FROM Course
JOIN Grade AS g1 ON Course.Code = g1.Code
JOIN (
    SELECT Code, AVG(Mark) AS AvgMark
    FROM Grade
    GROUP BY Code
) AS AvgMarks ON Course.Code = AvgMarks.Code
WHERE g1.Id = 'S103'
AND g1.Mark < AvgMarks.AvgMark;


-- Few queries to write for Join operation.

-- Find all students with their last name and the average mark they got in all courses:
SELECT S.Last, S.First, AVG(G.Mark) AS AverageMark
FROM Student S
JOIN Grade G ON S.Id = G.Id
GROUP BY S.Last, S.First;

-- Find all courses with the number of students enrolled in each course:
SELECT C.Title, COUNT(G.Id) AS StudentCount
FROM Course C
LEFT JOIN Grade G ON C.Code = G.Code
GROUP BY C.Title;

-- Find all students who scored higher than the average mark in any course:
SELECT DISTINCT S.First, S.Last
FROM Student S
JOIN Grade G ON S.Id = G.Id
JOIN (SELECT Code, AVG(Mark) AS AvgMark FROM Grade GROUP BY Code) A ON G.Code = A.Code
WHERE G.Mark > A.AvgMark;

-- Find all students who took both Programming courses (PR1 and PR2):
SELECT S.First, S.Last
FROM Student S
WHERE S.Id IN (
    SELECT G1.Id
    FROM Grade G1
    JOIN Grade G2 ON G1.Id = G2.Id
    WHERE G1.Code = 'PR1' AND G2.Code = 'PR2'
);
-- Find all courses that have no students enrolled:
SELECT C.Title
FROM Course C
LEFT JOIN Grade G ON C.Code = G.Code
WHERE G.Code IS NULL;

-- List all courses and the names of the students who got the highest mark in each course:
SELECT C.Title, S.First, S.Last, G.Mark
FROM Course C
JOIN Grade G ON C.Code = G.Code
JOIN Student S ON G.Id = S.Id
WHERE (C.Code, G.Mark) IN (
    SELECT Code, MAX(Mark)
    FROM Grade
    GROUP BY Code
);

-- Find the total number of students enrolled in each course and the average mark for those students:
SELECT C.Title, COUNT(G.Id) AS StudentCount, AVG(G.Mark) AS AverageMark
FROM Course C
LEFT JOIN Grade G ON C.Code = G.Code
GROUP BY C.Title;
-- List all students and the courses they haven't taken yet:
SELECT S.First, S.Last, C.Title
FROM Student S, Course C
WHERE NOT EXISTS (
    SELECT 1
    FROM Grade G
    WHERE G.Id = S.Id AND G.Code = C.Code
);
-- Find all courses with an average mark below a specific threshold (e.g., 60):
SELECT C.Title, AVG(G.Mark) AS AverageMark
FROM Course C
JOIN Grade G ON C.Code = G.Code
GROUP BY C.Title
HAVING AVG(G.Mark) < 60;
-- Find all students who scored within 10 points of the average mark in any course they took:
SELECT S.First, S.Last, G.Code, G.Mark, A.AvgMark
FROM Student S
JOIN Grade G ON S.Id = G.Id
JOIN (SELECT Code, AVG(Mark) AS AvgMark FROM Grade GROUP BY Code) A ON G.Code = A.Code
WHERE ABS(G.Mark - A.AvgMark) <= 10;