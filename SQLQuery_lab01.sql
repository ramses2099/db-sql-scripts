-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'Lab01'
)
CREATE DATABASE Lab01
GO

-- Create a new table called '[Professor]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Professor]', 'U') IS NOT NULL
DROP TABLE [dbo].[Professor]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Professor]
(
    [ProfessorID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] VARCHAR(50) NOT NULL,
    [LastName] VARCHAR(50) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [PhoneNo] VARCHAR(20) NULL    
);
GO


-- Create a new table called '[Course]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Course]', 'U') IS NOT NULL
DROP TABLE [dbo].[Course]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Course]
(
    [CourseID] INT IDENTITY(1,1) PRIMARY KEY,
    [CourseName] VARCHAR(100) NOT NULL,
    [CourseCode] VARCHAR(20) NOT NULL,
    [Credits] INT NOT NULL
);
GO


-- Create a new table called '[Schedule]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Schedule]', 'U') IS NOT NULL
DROP TABLE [dbo].[Schedule]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Schedule]
(
    [ScheduleID] INT IDENTITY(1,1) PRIMARY KEY,
    [CourseID] INT NOT NULL,
    [ProfessorID] INT NOT NULL,
    [Semester] VARCHAR(20) NOT NULL,
    [Year] INT NOT NULL,
    [Days] VARCHAR(20) NOT NULL,
    [Time] VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Schedule_Course FOREIGN KEY (CourseID)
    REFERENCES Course(CourseID), 
    CONSTRAINT FK_Schedule_Professor FOREIGN KEY (ProfessorID)
    REFERENCES Professor(ProfessorID)
);
GO

-- Create a new database called 'DatabaseName'
-- Connect to the 'master' database to run this snippet
USE master
GO
-- Create the new database if it does not exist already
IF NOT EXISTS (
    SELECT [name]
        FROM sys.databases
        WHERE [name] = N'Lab01'
)
CREATE DATABASE Lab01
GO

-- Create a new table called '[Professor]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Professor]', 'U') IS NOT NULL
DROP TABLE [dbo].[Professor]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Professor]
(
    [ProfessorID] INT IDENTITY(1,1) PRIMARY KEY,
    [FirstName] VARCHAR(50) NOT NULL,
    [LastName] VARCHAR(50) NOT NULL,
    [Email] VARCHAR(100) NOT NULL,
    [PhoneNo] VARCHAR(20) NULL    
);
GO


-- Create a new table called '[Course]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Course]', 'U') IS NOT NULL
DROP TABLE [dbo].[Course]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Course]
(
    [CourseID] INT IDENTITY(1,1) PRIMARY KEY,
    [CourseName] VARCHAR(100) NOT NULL,
    [CourseCode] VARCHAR(20) NOT NULL,
    [Credits] INT NOT NULL
);
GO


-- Create a new table called '[Schedule]' in schema '[dbo]'
-- Drop the table if it already exists
IF OBJECT_ID('[dbo].[Schedule]', 'U') IS NOT NULL
DROP TABLE [dbo].[Schedule]
GO
-- Create the table in the specified schema
CREATE TABLE [dbo].[Schedule]
(
    [ScheduleID] INT IDENTITY(1,1) PRIMARY KEY,
    [CourseID] INT NOT NULL,
    [ProfessorID] INT NOT NULL,
    [Semester] VARCHAR(20) NOT NULL,
    [Year] INT NOT NULL,
    [Days] VARCHAR(20) NOT NULL,
    [Time] VARCHAR(20) NOT NULL,
    CONSTRAINT FK_Schedule_Course FOREIGN KEY (CourseID)
    REFERENCES Course(CourseID), 
    CONSTRAINT FK_Schedule_Professor FOREIGN KEY (ProfessorID)
    REFERENCES Professor(ProfessorID)
);
GO

--INSERT INTO Professor TABLE
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Sanson', 'Levinge', 'slevinge0@edublogs.org', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Emmery', 'Wilman', 'ewilman1@unblog.fr', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Reta', 'Vickery', 'rvickery2@ask.com', 'Female');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Ariel', 'Wyldbore', 'awyldbore3@weibo.com', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Jermain', 'Long', 'jlong4@goo.ne.jp', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Yvor', 'Olyunin', 'yolyunin5@51.la', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Gary', 'Giraldon', 'ggiraldon6@whitehouse.gov', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Bowie', 'Lorne', 'blorne7@shutterfly.com', 'Male');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Berti', 'Neilus', 'bneilus8@sciencedaily.com', 'Female');
INSERT INTO Professor (FirstName, LastName, Email, PhoneNo) VALUES ('Klaus', 'Ulster', 'kulster9@123-reg.co.uk', 'Male');

GO
--INSERT INTO Course TABLE
INSERT INTO Course (CourseName, CourseCode, Credits) VALUES ('NoSQL Database Implementation', 'PROG8411', 1);
INSERT INTO Course (CourseName, CourseCode, Credits) VALUES ('Web Analytics and Business Intelligence Tools', 'PROG8461', 4);
INSERT INTO Course (CourseName, CourseCode, Credits) VALUES ('Software Quality', 'PROG8441', 3);
INSERT INTO Course (CourseName, CourseCode, Credits) VALUES ('Relational Database Design', 'PROG8401', 2);
INSERT INTO Course (CourseName, CourseCode, Credits) VALUES ('Programming for Big Data', 'PROG8421', 5);

GO
--INSERT INTO Schedule TABLE
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (1, 6, 'Winter', '2024-02-14');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (3, 6, 'Summer', '2024-01-10');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (5, 10, 'Winter', '2024-02-12');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (2, 4, 'Summer', '2023-11-27');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (2, 1, 'Spring', '2023-10-13');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (3, 8, 'Winter', '2023-11-22');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (4, 7, 'Spring', '2023-10-08');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (1, 5, 'Winter', '2024-05-22');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (5, 2, 'Fall', '2023-12-24');
INSERT INTO Schedule (CourseID, ProfessorID, Semester, Created) VALUES (2, 5, 'Fall', '2024-01-16');