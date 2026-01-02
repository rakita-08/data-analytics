//STRING FUNCTIONS

--STRING FUNCTIONS : TRIM, LTRIM, RTRIM

SELECT TRIM(EmployeeID::TEXT) AS IDTRIM
FROM EmployeeErrors;

SELECT LTRIM(EmployeeID::TEXT) AS IDTRIM
FROM EmployeeErrors;

SELECT RTRIM(EmployeeID::TEXT) AS IDTRIM
FROM EmployeeErrors;

--REPLACE

SELECT REPLACE(Lastname,' - Fired','') AS LastnaeFixed
FROM EmployeeErrors;

--SUBSTRING

SELECT SUBSTRING(Firstname,1,3)
FROM EmployeeErrors;
--gives the string of length '3' starting from poition '1'


SELECT SUBSTRING(err.Firstname,1,3),SUBSTRING(dem.Firstname,1,3)
FROM EmployeeErrors err
JOIN EmployeeDemographics dem
ON SUBSTRING(err.Firstname,1,3) = SUBSTRING(dem.FirstName,1,3);
--for fuzzy matching 

--Lower

SELECT LOWER(Firstname)                
FROM EmployeeErrors;   

--Upper

SELECT UPPER(Firstname)
FROM EmployeeErrors;
