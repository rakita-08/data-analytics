//JOIN, UNION, CASE STATEMENTS, HAVING

--JOIN

SELECT *                                                             
FROM EmployeeDemographics
Full Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT *                                                             
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT * 
FROM EmployeeDemographics
Left Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT * 
FROM EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 
--ERROR:  column reference "employeeid" is ambiguous

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeDemographics.EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Left Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeSalary.EmployeeID, FirstName, LastName, JobTitle, Salary 
FROM EmployeeDemographics
Right Outer Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID; 

SELECT EmployeeDemographics.EmployeeID, Firstname, LastName, Salary                
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID 
WHERE Firstname <> 'Michael' 
ORDER BY Salary DESC; 

SELECT JobTitle,Salary
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman';

SELECT JobTitle,AVG(Salary)
FROM EmployeeDemographics
Inner Join EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
WHERE JobTitle = 'Salesman'
            
--UNION 

SELECT * 
FROM EmployeeDemographics
UNION
SELECT * 
FROM WarehouseEmployeeeDemographics;

SELECT * 
FROM EmployeeDemographics
UNION ALL
SELECT * 
FROM WarehouseEmployeeeDemographics;

SELECT EmployeeID, Firstname, Age 
FROM EmployeeDemographics
UNION    
SELECT EmployeeID, Jobtitle, Salary 
FROM EmployeeSalary
ORDER BY EmployeeID;
 
SELECT FirstName, LastName, Age
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age;

--CASE

SELECT FirstName, LastName, Age,
CASE                           
  WHEN Age > 30 THEN 'Old'       
  ELSE 'Young'       
END                
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, Age,
CASE
  WHEN Age > 30 THEN 'Old' 
  WHEN Age BETWEEN 27 AND 30 THEN 'Adult'
  ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, Age,
CASE
  WHEN Age > 30 THEN 'Old' 
  WHEN Age = 38 THEN 'Stanley'
  ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age;
 
SELECT FirstName, LastName, Age,
CASE 
  WHEN Age = 31 THEN 'Stanley'
  WHEN Age > 30 THEN 'Old'   
  ELSE 'Young'
END
FROM EmployeeDemographics
WHERE Age is NOT NULL
ORDER BY Age;

SELECT FirstName, LastName, JobTitle, Salary,
CASE
  WHEN JobTitle = 'Salesman' THEN Salary + (Salary * .10)
  WHEN JobTitle = 'Accountant' THEN Salary + (Salary * .05)
  ELSE Salary + (Salary * .03)
END AS RaisedSalary
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID;

--HAVING

SELECT Jobtitle , COUNT(Jobtitle)
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING COUNT(JobTitle) > 1;

SELECT Jobtitle , AVG(Salary)
FROM EmployeeDemographics
JOIN EmployeeSalary
ON EmployeeDemographics.EmployeeID = EmployeeSalary.EmployeeID
GROUP BY JobTitle
HAVING AVG(Salary) > 50000
ORDER BY AVG(Salary);
