CREATE DATABASE EmployeeManagement;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50) NOT NULL,
    location VARCHAR(50) NOT NULL
);

CREATE TABLE Jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(50) NOT NULL,
    min_salary DECIMAL(10,2),
    max_salary DECIMAL(10,2)
);

CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    job_id INT,
    dept_id INT,
    salary DECIMAL(10,2),
    FOREIGN KEY (job_id) REFERENCES Jobs(job_id),
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);


CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    emp_id INT,
    date DATE,
    status VARCHAR(10) NOT NULL CHECK (status IN ('Present', 'Absent', 'Leave')),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);


CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    emp_id INT,
    basic_salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    deductions DECIMAL(10,2),
    net_salary DECIMAL(10,2),
    FOREIGN KEY (emp_id) REFERENCES Employees(emp_id)
);


/*Insert into employee table*/
INSERT INTO Employees (emp_id, first_name, last_name, email, phone, hire_date, job_id, dept_id, salary) VALUES
(1,'Ali', 'Shah', 'ali.shah@example.com', '358401234567', '2021-01-10', 1, 1, 5000),
(2,'Sara', 'Khan', 'sara.khan@example.com', '358401234568', '2021-03-15', 2, 2, 6000),
(3,'Omar', 'Malik', 'omar.malik@example.com', '358401234569', '2022-07-20', 3, 2, 4200),
(4,'Aisha', 'Rauf', 'aisha.rauf@example.com', '358401234570', '2020-11-01', 4, 4, 3500),
(5,'Bilal', 'Ahmed', 'bilal.ahmed@example.com', '358401234571', '2019-05-30', 5, 5, 3000),
(6,'Fatima', 'Iqbal', 'fatima.iqbal@example.com', '358401234572', '2021-09-10', 2, 2, 5500),
(7,'Hassan', 'Ali', 'hassan.ali@example.com', '358401234573', '2022-02-18', 3, 3, 4500),
(8,'Zara', 'Sheikh', 'zara.sheikh@example.com', '358401234574', '2020-12-25', 4, 4, 3700),
(9,'Imran', 'Yousaf', 'imran.yousaf@example.com', '358401234575', '2021-04-14', 5, 5, 2800),
(10,'Nida', 'Hameed', 'nida.hameed@example.com', '358401234576', '2019-08-09', 1, 1, 5100),
(11,'Ahmed', 'Rashid', 'ahmed.rashid@example.com', '358401234577', '2021-06-22', 2, 2, 5800),
(12,'Mariam', 'Aslam', 'mariam.aslam@example.com', '358401234578', '2022-01-30', 3, 3, 4300),
(13,'Khalid', 'Javed', 'khalid.javed@example.com', '358401234579', '2020-10-11', 4, 4, 3400),
(14,'Sana', 'Nawaz', 'sana.nawaz@example.com', '358401234580', '2021-12-19', 5, 5, 3200),
(15,'Usman', 'Farooq', 'usman.farooq@example.com', '358401234581', '2019-04-05', 2, 2, 6200);

/*Employees queries*/
-- Select all employees
SELECT * FROM Employees;

-- Select specific columns
SELECT first_name, last_name, email, salary FROM Employees;

-- Select with condition (WHERE)
SELECT * FROM Employees WHERE salary > 5000;

-- Select using pattern matching (LIKE)
SELECT * FROM Employees WHERE first_name LIKE 'A%';

-- Select with ORDER BY
SELECT * FROM Employees ORDER BY salary DESC;  -- Highest salary first
SELECT * FROM Employees ORDER BY hire_date ASC; -- Earliest hire first

-- Update Records
-- Increase salary of Software Engineers by 500
UPDATE Employees
SET salary = salary + 500
WHERE job_id = 2;

-- Delete Records
-- Delete employee with emp_id = 9
DELETE FROM Employees
WHERE emp_id = 9;

-- Aggregate Functions
-- Count total employees
SELECT COUNT(*) AS TotalEmployees FROM Employees;

-- Find maximum salary
SELECT MAX(salary) AS MaxSalary FROM Employees;

-- Find minimum salary
SELECT MIN(salary) AS MinSalary FROM Employees;

-- Calculate average salary
SELECT AVG(salary) AS AvgSalary FROM Employees;

-- Group By
-- Count employees in each department
SELECT dept_id, COUNT(emp_id) AS EmployeeCount
FROM Employees
GROUP BY dept_id;

-- Count employees in each job
SELECT job_id, COUNT(emp_id) AS EmployeeCount
FROM Employees
GROUP BY job_id;

-- Joins with Departments table
-- List employees with department name
SELECT e.first_name, e.last_name, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

-- Joins with Jobs table
-- List employees with job title
SELECT e.first_name, e.last_name, j.job_title
FROM Employees e
JOIN Jobs j ON e.job_id = j.job_id;

-- Subquery
-- Employees with salary above average
SELECT * FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);

-- Top N rows
-- Top 5 highest paid employees
SELECT TOP 5 * FROM Employees ORDER BY salary DESC;

-- Advanced: Window Function (if SQL Server 2012+)
-- Rank employees by salary
SELECT emp_id, first_name, last_name, salary,
       RANK() OVER (ORDER BY salary DESC) AS SalaryRank
FROM Employees;

-- Constraints Alter
-- Add a new column 'manager' with default value
ALTER TABLE Employees ADD manager VARCHAR(50) DEFAULT 'TBD';

-- Add UNIQUE constraint on phone
ALTER TABLE Employees ADD CONSTRAINT UQ_employee_phone UNIQUE(phone);

/*Jobs Data*/
INSERT INTO Jobs (job_id, job_title, min_salary, max_salary) VALUES
(1,'HR Manager', 3000, 6000),
(2,'Software Engineer', 3500, 7000),
(3,'Data Analyst', 3200, 6500),
(4,'Marketing Specialist', 2800, 5500),
(5,'Sales Executive', 2500, 5000);

/*JObs queries*/
-- Select all records
SELECT * FROM Jobs;

-- Select only job title and salary range
SELECT job_title, min_salary, max_salary FROM Jobs;

-- Select with condition (WHERE)
SELECT * FROM Jobs WHERE min_salary > 3000;

-- Select using pattern matching (LIKE)
SELECT * FROM Jobs WHERE job_title LIKE '%Engineer%';

-- Select with ORDER BY
SELECT * FROM Jobs ORDER BY job_title ASC;      -- Alphabetical order
SELECT * FROM Jobs ORDER BY min_salary DESC;    -- Salary descending

-- Update max salary of Software Engineer
UPDATE Jobs
SET max_salary = 7500
WHERE job_id = 2;

-- Delete the Sales Executive job
DELETE FROM Jobs
WHERE job_id = 5;

-- Count total jobs
SELECT COUNT(*) AS TotalJobs FROM Jobs;

-- Find maximum salary
SELECT MAX(max_salary) AS MaxSalary FROM Jobs;

-- Find minimum salary
SELECT MIN(min_salary) AS MinSalary FROM Jobs;

-- List all employees with their job title
SELECT e.first_name, e.last_name, j.job_title
FROM Employees e
JOIN Jobs j ON e.job_id = j.job_id;

-- Count employees in each job (GROUP BY)
SELECT j.job_title, COUNT(e.emp_id) AS EmployeeCount
FROM Jobs j
LEFT JOIN Employees e ON j.job_id = e.job_id
GROUP BY j.job_title;

-- Jobs with max_salary greater than average max_salary (Subquery)
SELECT * FROM Jobs
WHERE max_salary > (SELECT AVG(max_salary) FROM Jobs);

-- Top 3 highest paying jobs
SELECT TOP 3 * FROM Jobs ORDER BY max_salary DESC;

-- Add UNIQUE constraint to job_title
ALTER TABLE Jobs ADD CONSTRAINT UQ_job_title UNIQUE(job_title);


/*Departments*/

INSERT INTO Departments (dept_id,dept_name, location) VALUES
(1,'HR', 'Helsinki'),
(2,'IT', 'Espoo'),
(3,'Finance', 'Tampere'),
(4,'Marketing', 'Turku'),
(5,'Sales', 'Oulu');

/*Deparetments queries */

--Select all records
SELECT * FROM Departments;

--Select only department name and location
SELECT dept_name, location FROM Departments;

--Select with condition (WHERE)
SELECT * FROM Departments WHERE location = 'Espoo';

--Select using pattern matching (LIKE)
SELECT * FROM Departments WHERE dept_name LIKE 'M%';

--Select with ORDER BY
SELECT * FROM Departments ORDER BY dept_name ASC;
SELECT * FROM Departments ORDER BY dept_id DESC;



-- Update the location of IT department
UPDATE Departments
SET location = 'Vantaa'
WHERE dept_id = 2;

-- Delete the Sales department
DELETE FROM Departments
WHERE dept_id = 5;

-- Count total departments
SELECT COUNT(*) AS TotalDepartments FROM Departments;

--Find maximum department ID
SELECT MAX(dept_id) AS MaxDeptID FROM Departments;

-- Find minimum department ID
SELECT MIN(dept_id) AS MinDeptID FROM Departments;

-- List all employees with their department name
SELECT e.first_name, e.last_name, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id;

--  Group By: Count employees in each department
SELECT d.dept_name, COUNT(e.emp_id) AS EmployeeCount
FROM Departments d
LEFT JOIN Employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- Subquery: Departments with ID greater than average
SELECT * FROM Departments
WHERE dept_id > (SELECT AVG(dept_id) FROM Departments);

--Top N Rows: Top 3 departments by ID
SELECT TOP 3 * FROM Departments ORDER BY dept_id DESC;

-- Add UNIQUE constraint to dept_name
ALTER TABLE Departments ADD CONSTRAINT UQ_dept_name UNIQUE(dept_name);

-- Add a new NOT NULL column 'manager' with default value
ALTER TABLE Departments ADD manager VARCHAR(50) NOT NULL DEFAULT 'TBD';


/*Attendance */

INSERT INTO Attendance ( attendance_id,emp_id, date, status) VALUES
(1,1, '2025-08-01', 'Present'),
(2,2, '2025-08-01', 'Present'),
(3,3, '2025-08-01', 'Absent'),
(4,4, '2025-08-01', 'Present'),
(5,5, '2025-08-01', 'Leave'),
(6,6, '2025-08-01', 'Present'),
(7,7, '2025-08-01', 'Present'),
(8,8, '2025-08-01', 'Absent'),
(9,9, '2025-08-01', 'Present'),
(10,10, '2025-08-01', 'Present'),
(11,11, '2025-08-01', 'Leave'),
(12,12, '2025-08-01', 'Present'),
(13,13, '2025-08-01', 'Present'),
(14,14, '2025-08-01', 'Absent'),
(15,15, '2025-08-01', 'Present');


/*Attendance queries*/
-- ==================================================
-- EMPLOYEE MANAGEMENT SYSTEM: ATTENDANCE TABLE
-- All possible SQL queries (Basic to Advanced)
-- ==================================================

-- Select Queries
-- Select all attendance records
SELECT * FROM Attendance;

-- Select specific columns
SELECT emp_id, date, status FROM Attendance;

-- Select with condition (WHERE)
SELECT * FROM Attendance WHERE status = 'Absent';

-- Select using pattern matching (LIKE)
SELECT * FROM Attendance WHERE status LIKE 'P%'; -- Status starting with 'P' (Present)

-- Select with ORDER BY
SELECT * FROM Attendance ORDER BY date ASC;  -- Oldest first
SELECT * FROM Attendance ORDER BY emp_id DESC; -- Highest emp_id first

-- Update Records
-- Mark employee 3 as Present on a specific date
UPDATE Attendance
SET status = 'Present'
WHERE emp_id = 3 AND date = '2025-08-01';

-- Delete Records
-- Delete attendance record for employee 5 on a specific date
DELETE FROM Attendance
WHERE emp_id = 5 AND date = '2025-08-01';

-- Aggregate Functions
-- Count total attendance records
SELECT COUNT(*) AS TotalRecords FROM Attendance;

-- Count how many days employees were Present
SELECT COUNT(*) AS TotalPresent FROM Attendance WHERE status = 'Present';

-- Count how many days employees were Absent
SELECT COUNT(*) AS TotalAbsent FROM Attendance WHERE status = 'Absent';

-- Count how many days employees were on Leave
SELECT COUNT(*) AS TotalLeave FROM Attendance WHERE status = 'Leave';

-- Group By
-- Count attendance by status
SELECT status, COUNT(*) AS CountByStatus
FROM Attendance
GROUP BY status;

-- Count attendance by employee
SELECT emp_id, COUNT(*) AS DaysRecorded
FROM Attendance
GROUP BY emp_id;

-- Joins
-- List employee name with their attendance status
SELECT e.first_name, e.last_name, a.date, a.status
FROM Attendance a
JOIN Employees e ON a.emp_id = e.emp_id;

-- Subquery
-- Employees who were Absent more than 2 times
SELECT emp_id FROM Attendance
WHERE status = 'Absent'
GROUP BY emp_id
HAVING COUNT(*) > 2;

-- Top N Rows
-- Top 5 employees with most Present days
SELECT TOP 5 emp_id, COUNT(*) AS PresentDays
FROM Attendance
WHERE status = 'Present'
GROUP BY emp_id
ORDER BY PresentDays DESC;

-- Advanced: Window Functions
-- Rank employees by number of Present days
SELECT emp_id, COUNT(*) AS PresentDays,
       RANK() OVER (ORDER BY COUNT(*) DESC) AS AttendanceRank
FROM Attendance
WHERE status = 'Present'
GROUP BY emp_id;

-- Constraints Alter
-- Add a new column 'remarks' to Attendance
ALTER TABLE Attendance ADD remarks VARCHAR(100) DEFAULT 'None';

/*Salary data*/
INSERT INTO Salaries (salary_id, emp_id, basic_salary, bonus, deductions, net_salary) VALUES
(1, 1, 5000, 500, 200, 5300),
(2, 2, 6000, 600, 300, 6300),
(3, 3, 4200, 400, 150, 4450),
(4, 4, 3500, 350, 100, 3750),
(5, 5, 3000, 300, 50, 3250),
(6, 6, 5500, 550, 250, 5800),
(7, 7, 4500, 450, 200, 4750),
(8, 8, 3700, 370, 120, 3950),
(9, 9, 2800, 280, 80, 3000),
(10, 10, 5100, 510, 200, 5410),
(11, 11, 5800, 580, 300, 6080),
(12, 12, 4300, 430, 150, 4580),
(13, 13, 3400, 340, 100, 3640),
(14, 14, 3200, 320, 100, 3420),
(15, 15, 6200, 620, 350, 6470);

/*Salary queries*/
-- ==================================================
-- EMPLOYEE MANAGEMENT SYSTEM: SALARIES TABLE
-- All possible SQL queries (Basic to Advanced)
-- ==================================================

-- Select Queries
-- Select all salary records
SELECT * FROM Salaries;

-- Select specific columns
SELECT emp_id, basic_salary, bonus, deductions, net_salary FROM Salaries;

-- Select with condition (WHERE)
-- Employees with net salary above 5000
SELECT * FROM Salaries WHERE net_salary > 5000;

-- Select using pattern matching (LIKE)
-- No direct pattern in numeric columns, example: emp_id starting with '1'
SELECT * FROM Salaries WHERE CAST(emp_id AS VARCHAR) LIKE '1%';

-- Select with ORDER BY
SELECT * FROM Salaries ORDER BY net_salary DESC; -- Highest net salary first
SELECT * FROM Salaries ORDER BY basic_salary ASC; -- Lowest basic salary first

-- Update Records
-- Increase bonus of employee 2 by 200
UPDATE Salaries
SET bonus = bonus + 200,
    net_salary = basic_salary + (bonus + 200) - deductions
WHERE emp_id = 2;

-- Delete Records
-- Delete salary record for employee 9
DELETE FROM Salaries
WHERE emp_id = 9;

-- Aggregate Functions
-- Count total salary records
SELECT COUNT(*) AS TotalRecords FROM Salaries;

-- Sum of all basic salaries
SELECT SUM(basic_salary) AS TotalBasicSalary FROM Salaries;

-- Average net salary
SELECT AVG(net_salary) AS AvgNetSalary FROM Salaries;

-- Maximum net salary
SELECT MAX(net_salary) AS MaxNetSalary FROM Salaries;

-- Minimum net salary
SELECT MIN(net_salary) AS MinNetSalary FROM Salaries;

-- Group By
-- Total net salary by employee
SELECT emp_id, SUM(net_salary) AS TotalNetSalary
FROM Salaries
GROUP BY emp_id;

-- Join with Employees table
-- List employee name with net salary
SELECT e.first_name, e.last_name, s.net_salary
FROM Salaries s
JOIN Employees e ON s.emp_id = e.emp_id;

-- Subquery
-- Employees whose net salary is above average
SELECT * FROM Salaries
WHERE net_salary > (SELECT AVG(net_salary) FROM Salaries);

-- Top N rows
-- Top 5 highest net salaries
SELECT TOP 5 * FROM Salaries ORDER BY net_salary DESC;

-- Advanced: Window Functions
-- Rank employees by net salary
SELECT emp_id, net_salary,
       RANK() OVER (ORDER BY net_salary DESC) AS SalaryRank
FROM Salaries;

-- Constraints Alter
-- Add a new column 'remarks' with default value
ALTER TABLE Salaries ADD remarks VARCHAR(100) DEFAULT 'None';