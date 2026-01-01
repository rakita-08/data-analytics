//UPDATING, DELETING, ALIASING, PARTITION BY

-- Update

UPDATE EmployeeDemographics
SET EmployeeID = 1010
WHERE FirstName = 'Haary' AND LastName = 'Watson';

UPDATE EmployeeDemographics
SET Age = 31, Gender = 'Female'
WHERE FirstName = 'Haary' AND LastName = 'Watson';
UPDATE 1

--delete

DELETE FROM EmployeeDemographics
WHERE EmployeeID = 1006;

--aliasing

SELECT FirstName Fname
FROM EmployeeDemographics;

SELECT FirstName || ' ' || Lastname AS FullName
FROM EmployeeDemographics;

OPTION 2

SELECT CONCAT(FirstName,' ', Lastname) AS FullName
FROM EmployeeDemographics;

SELECT Demo.EmployeeID
FROM EmployeeDemographics 
AS Demo;

SELECT Demo.EmployeeID, Sal.Salary    
FROM EmployeeDemographics 
AS Demo
JOIN EmployeeSalary AS Sal
ON Demo.EmployeeID = Sal.EmployeeID;

SELECT Demo.EmployeeID, Demo.FirstName, Demo.LastName, Sal.Salary, Sal.JobTitle, Ware.Age
FROM EmployeeDemographics Demo 
LEFT JOIN EmployeeSalary Sal
ON Demo.EmployeeID = Sal.EmployeeID
LEFT JOIN WareHouseEmployeeDemographics Ware
ON Demo.EmployeeID = Ware.EmployeeID;

--partition by

SELECT FirstName, LastName, Gender, Salary,
COUNT(Gender) 
OVER (PARTITION BY Gender) as TotalGender
FROM EmployeeDemographics dem
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID;

SELECT Gender, COUNT(Gender) 
FROM EmployeeDemographics dem            
JOIN EmployeeSalary sal
ON dem.EmployeeID = sal.EmployeeID
GROUP BY Gender;
