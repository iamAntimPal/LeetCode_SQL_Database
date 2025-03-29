# Solution 1
# Write your MSSQL query statement below
select max(salary) as SecondHighestSalary from employee
where salary not in (select max(salary) from employee)



# Solution 2
# Write your MSSQL query statement below
# Write your MySQL query statement below
SELECT
    (
        SELECT DISTINCT salary
        FROM Employee
        ORDER BY salary DESC
        LIMIT 1, 1
    ) AS SecondHighestSalary;