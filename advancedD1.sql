//CTEs, TEMP TABlES

--ctes

WITH CTE_Employee as 
(
SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) OVER (PARTITION BY Gender) as TotalGender, 
AVG(Salary) OVER (PARTITION BY Gender) as AvgSalary                            
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID WHERE Salary > '45000'
)
SELECT * 
FROM CTE_Employee;
 
--temp tables

CREATE TEMP TABLE IF NOT EXISTS temp_Employee1(
JobTitle varchar(50),
EmployeesPerJob int,
AvgAge int,
AvgSalary int);

INSERT INTO temp_Employee1 
SELECT JobTitle, COUNT(JobTitle), AVG(Age), AVG(Salary)
FROM EmployeeDemographics emp
JOIN EmployeeSalary sal
ON emp.EmployeeID = sal.EmployeeID
GROUP BY JobTitle;

SELECT *
FROM temp_Employee1;
