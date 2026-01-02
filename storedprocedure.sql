//Stored Procedure

-- Create a function to return EmployeeDemographics table
CREATE OR REPLACE FUNCTION get_employee_demo()
RETURNS TABLE(
    EmployeeID INT,
    FirstName VARCHAR,
    LastName VARCHAR,
    Age INT,
    Gender VARCHAR
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY 
    SELECT * FROM EmployeeDemographics;
END;
$$;
-- Call the function to retrieve data
SELECT * FROM get_employee_demo();

-- Create a procedure to return updated age from EmployeeDemographics table
CREATE OR REPLACE PROCEDURE update_age(emp_id INT, add_years INT)
LANGUAGE plpgsql
AS $$
BEGIN 
UPDATE EmployeeDemographics
SET Age = Age + add_years
WHERE EmployeeID = emp_id;
END;
$$;
-- Call the procedure 
CALL update_age(1001,2);
-- View the updated data
SELECT EmployeeID, FirstName, LastName, Age
FROM EmployeeDemographics
WHERE EmployeeID = 1001;
