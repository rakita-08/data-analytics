//BASICS OF SQL (CREATE,INSERT,WHERE,LIKE,NULL,NOT NULL,IN,AS,ORDER BY,GROUP BY)
CREATE database SQLdb;
CREATE TABLE EmployeeDemographics(
		EmployeeID int,
		FirstName varchar(50),
		LastName varchar(50),
		Age int,
		Gender varchar(50)
);

CREATE TABLE EmployeeSalary(
		EmployeeID int,
		JobTitle varchar(50),
		Salary int
);

select * from EmployeeSalary;

select * from EmployeeDemographics;

SELECT Firstname 
FROM EmployeeDemographics;

SELECT Firstname, Lastname 
FROM EmployeeDemographics;

SELECT *
FROM EmployeeDemographics
LIMIT 5;
 
SELECT DISTINCT (EmployeeID)
FROM EmployeeDemographics;
 
SELECT DISTINCT (Gender)
FROM EmployeeDemographics;

SELECT COUNT(Lastname)  
FROM EmployeeDemographics;

SELECT COUNT(Lastname) AS LastnameCount
FROM EmployeeDemographics;

select * from EmployeeSalary;                     

SELECT MAX(Salary)
FROM EmployeeSalary;

SELECT MIN(Salary)
FROM EmployeeSalary;

SELECT AVG(Salary)
FROM EmployeeSalary;

SELECT *
FROM EmployeeDemographics
WHERE FirstName = 'Jim';

SELECT *
FROM EmployeeDemographics
WHERE FirstName <> 'Jim';

SELECT *
FROM EmployeeDemographics
WHERE AGE > 30;

SELECT *
FROM EmployeeDemographics
WHERE AGE >= 30;

SELECT *
FROM EmployeeDemographics
WHERE AGE <= 32;

SELECT *
FROM EmployeeDemographics
WHERE AGE <= 32 AND Gender = 'Male';

SELECT *
FROM EmployeeDemographics
WHERE AGE <= 32 OR Gender = 'Male';

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%';

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S';

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE '%S%';

SELECT *
FROM EmployeeDemographics
WHERE LastName LIKE 'S%o%';

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NULL;

SELECT *
FROM EmployeeDemographics
WHERE FirstName is NOT NULL;

SELECT *
FROM EmployeeDemographics
WHERE FirstName IN ('Jim','Michael');

SELECT Gender
FROM EmployeeDemographics
GROUP BY Gender;

SELECT Gender, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender;

SELECT Gender,Age, COUNT(Gender)
FROM EmployeeDemographics
GROUP BY Gender,Age;
 
SELECT Gender,COUNT(Gender)
FROM EmployeeDemographics
WHERE Age > 31
GROUP BY Gender;

SELECT Gender,COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age < 30
GROUP BY Gender ORDER BY CountGender DESC;

SELECT Gender,COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age < 30
GROUP BY Gender ORDER BY Gender DESC;

SELECT Gender,COUNT(Gender) AS CountGender
FROM EmployeeDemographics
WHERE Age < 30
GROUP BY Gender 
ORDER BY Gender ASC;
 
SELECT *                             
FROM EmployeeDemographics
ORDER BY Age DESC;

SELECT *
FROM EmployeeDemographics
ORDER BY Age,Gender DESC;
 
SELECT *
FROM EmployeeDemographics
ORDER BY Age DESC ,Gender ASC;
 
SELECT *
FROM EmployeeDemographics
ORDER BY 4 desc, 5 desc;

