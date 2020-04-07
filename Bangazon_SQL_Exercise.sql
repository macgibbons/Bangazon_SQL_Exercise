---------- BANGAZON SQL EXERCISE ----------
			 -- Mac Gibbons --
			 -- 04/07/2020 --

-- 1: List each employee first name, last name and supervisor status along with their department name. Order by department name, then by employee last name, and finally by employee first name.
--COMMENT: use CASE WHEN to change the bit value (1 or 0) to display as TRUE or FALSE

SELECT  e.FirstName, e.LastName,  
CASE WHEN e.isSupervisor  = 1 THEN 'TRUE' ELSE 'FALSE' END as Supervisor, d.[Name] as Department
From Employee e
LEFT JOIN Department d
ON e.DepartmentId = d.Id
ORDER BY d.[Name], e.LastName, e.FirstName 


-- 2: List each department ordered by budget amount with the highest first.

SELECT [Name], Budget
FROM Department
ORDER BY Budget desc


-- 3: List each department name along with any employees (full name) in that department who are supervisors.
-- COMMENT: had to concact Employee first name and last name with a space to get the full name in one column 

SELECT d.[Name], e.FirstName + ' ' +  e.LastName as 'Supervisor'
FROM Department d
LEFT JOIN Employee e
ON d.Id = e.DepartmentId
WHERE e.IsSupervisor = 1

-- 4: List each department name along with a count of employees in each department.

SELECT d.[Name], COUNT(e.Id) as 'Total Employees'
FROM Department d
LEFT JOIN Employee e
ON d.Id = e.DepartmentId
GROUP BY d.[Name], e.DepartmentId

-- 5: Write a single update statement to increase each department's budget by 20%.

UPDATE Department set Budget = (Budget * 1.20)

-- 6: List the employee full names for employees who are not signed up for any training programs.
--COMMENT: has to be 'IS NULL' not = Null

SELECT  e.FirstName + ' ' +  e.LastName as 'Employees Not Training'
FROM Employee e
LEFT JOIN EmployeeTraining t
ON e.Id = t.EmployeeId
WHERE t.EmployeeId IS null

-- 7: List the employee full names for employees who are signed up for at least one training program and include the number of training programs they are signed up for.

SELECT  e.FirstName + ' ' +  e.LastName as 'Employees Not Training',  COUNT(t.EmployeeId) as 'Training Program Count'
FROM Employee e
LEFT JOIN EmployeeTraining t
ON e.Id = t.EmployeeId
WHERE t.EmployeeId IS NOT NULL
GROUP BY e.FirstName, e.LastName

-- 8: List all training programs along with the count employees who have signed up for each.

SELECT tp.[Name], COUNT(et.EmployeeId) as 'Attending'
FROM TrainingProgram tp
LEFT JOIN EmployeeTraining et
ON tp.Id = et.TrainingProgramId
GROUP BY tp.[Name]

-- 9: List all training programs who have no more seats available.

SELECT tp.[Name] as 'Training programs at max capacity'
FROM TrainingProgram tp
LEFT JOIN EmployeeTraining et
ON tp.Id = et.TrainingProgramId
WHERE tp.MaxAttendees <= et.EmployeeId


-- 10: List all future training programs ordered by start date with the earliest date first.

SELECT [Name] as Program, StartDate as 'Start Date'
FROM TrainingProgram
WHERE StartDate >=  GETDATE()
ORDER BY StartDate ASC


-- 11: Assign a few employees to training programs of your choice.

INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
VALUES(38, 2)

INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
VALUES(39, 2)

INSERT INTO EmployeeTraining (EmployeeId, TrainingProgramId)
VALUES(40, 2)

-- 12: List the top 3 most popular training programs. (For this question, consider each record in the training program table to be a UNIQUE training program).
 -- this is not correct taking a break

SELECT TOP 3  tp.[Name], COUNT(et.TrainingProgramId) as 'Amount attending'
FROM EmployeeTraining et
LEFT JOIN TrainingProgram tp
ON et.TrainingProgramId = tp.Id
GROUP BY et.TrainingProgramId, tp.[Name]
order by Count(et.employeeId) desc

-- 13: List the top 3 most popular training programs. (For this question consider training programs with the same name to be the SAME training program).


-- 14: List all employees who do not have computers.


-- 15: List all employees along with their current computer information make and manufacturer combined into a field entitled ComputerInfo. If they do not have a computer, this field should say "N/A".


-- 16: List all computers that were purchased before July 2019 that are have not been decommissioned.


-- 17: List all employees along with the total number of computers they have ever had.


-- 18: List the number of customers using each payment type


-- 19: List the 10 most expensive products and the names of the seller


-- 20: List the 10 most purchased products and the names of the seller


-- 21: Find the name of the customer who has made the most purchases


-- 22: List the amount of total sales by product type


-- 23: List the total amount made from all sellers