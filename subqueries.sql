//Subqueries

-- in select
Select EmployeeID, Salary, (Select AVG(Salary) From EmployeeSalary) as AllAvgSalary 
From EmployeeSalary;

-- partition by
Select EmployeeID, Salary, AVG(Salary) over () as AllAvgSalary
From EmployeeSalary;

--doesn't work using group by
Select EmployeeID, Salary, AVG(Salary) as AllAvgSalary
From EmployeeSalary
Group By EmployeeID, Salary
order by EmployeeID;
 
-- in where
Select EmployeeID, JobTitle, Salary
From EmployeeSalary
where EmployeeID in 
 (      Select EmployeeID 
        From EmployeeDemographics
        where Age > 30
 );
