570. Managers with at Least 5 Direct Reports
/**
The Employee table holds all employees including their managers. Every employee has an Id, and there is also a column for the manager Id.
SQL Schema
Pandas Schema
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+

Explanation: 
John is the only manager who has at least 5 direct reports.

Example 2:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
 | 101 | John  | A          | null      |
| 102 | Dan   | A          | 101       |
 | 103 | James | A          | 101       |
 | 104 | Amy   | A          | 101       |

+-----+-------+------------+-----------+
Output:
+-----------+

*/

# Write your MySQL query statement below

-- Solution 2: Using subquery for counting direct reports and join for filtering managers with at least 5 direct reports
SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);

-- Solution 3: Using window function for counting direct reports and filtering managers with at least 5 direct reports

SELECT name
FROM Employee
    JOIN (
        SELECT managerId
        FROM Employee
        GROUP BY managerId
        HAVING COUNT(*) >= 5
    ) AS managers
    ON Employee.id = managers.managerId

    GROUP BY name
    HAVING COUNT(*) >= 5;
