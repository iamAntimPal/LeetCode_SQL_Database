# **185. Department Top Three Salaries**

## **Problem Statement**
You are given two tables: `Employee` and `Department`.

### **Employee Table**
```rb
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
```
- `id` is the primary key.
- `departmentId` is a foreign key referencing `id` in the `Department` table.
- Each row represents an employee with their `id`, `name`, `salary`, and `departmentId`.

### **Department Table**
```rb
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
```
- `id` is the primary key.
- Each row represents a department with its `id` and `name`.

### **Task:**
Find employees who have a salary in the **top three unique salaries** in their respective departments.

## **Example 1:**
### **Input:**
#### **Employee Table**
```
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
+----+-------+--------+--------------+
```
#### **Department Table**
```rb
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
```
### **Output:**
```rb
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
```

---

## **Solution Approaches**

### **SQL Solution (Using Self Join)**
```sql
SELECT d.Name as Department,
       e.Name as Employee,
       e.Salary as Salary
FROM Department d, Employee e
WHERE (
    SELECT COUNT(DISTINCT Salary)
    FROM Employee
    WHERE Salary > e.Salary AND DepartmentId = d.Id
) < 3 AND e.DepartmentId = d.Id
ORDER BY d.Id, e.Salary DESC;
```
**Explanation:**
- For each employee, we count how many distinct salaries are greater than theirs.
- If fewer than 3 salaries are greater, the employee is in the **top three**.
- We filter results by department and order by salary in descending order.

---

### **SQL Solution (Using Window Functions)**
```sql
WITH RankedSalaries AS (
    SELECT e.name AS Employee, 
           e.salary AS Salary, 
           d.name AS Department,
           DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS rnk
    FROM Employee e
    JOIN Department d ON e.departmentId = d.id
)
SELECT Department, Employee, Salary
FROM RankedSalaries
WHERE rnk <= 3;
```
**Explanation:**
- We use `DENSE_RANK()` to assign a rank to salaries within each department.
- `PARTITION BY departmentId` ensures ranking is specific to each department.
- Employees with `rnk <= 3` are returned.

---

### **Pandas Solution**
```python
import pandas as pd

def department_top_three_salaries(employee: pd.DataFrame, department: pd.DataFrame) -> pd.DataFrame:
    # Merge employee and department tables
    employee = employee.merge(department, left_on='departmentId', right_on='id', suffixes=('', '_dept'))
    
    # Rank employees' salaries within each department
    employee['rank'] = employee.groupby('departmentId')['salary'].rank(method='dense', ascending=False)
    
    # Filter top 3 salaries in each department
    result = employee[employee['rank'] <= 3][['name_dept', 'name', 'salary']]
    
    # Rename columns to match the expected output
    result.columns = ['Department', 'Employee', 'Salary']
    
    return result
```
**Explanation:**
- Merge the `Employee` and `Department` tables.
- Rank salaries within each department using `.rank()`.
- Filter the top 3 ranked salaries per department.

---

## **File Structure**
```
📂 LeetCode185
│── 📜 problem_statement.md
│── 📜 sql_self_join_solution.sql
│── 📜 sql_window_function_solution.sql
│── 📜 pandas_solution.py
│── 📜 README.md
```
- `problem_statement.md` → Contains the problem description and constraints.
- `sql_self_join_solution.sql` → Contains the SQL solution using self-join.
- `sql_window_function_solution.sql` → Contains the SQL solution using `DENSE_RANK()`.
- `pandas_solution.py` → Contains the Pandas solution for Python users.
- `README.md` → Provides an overview of the problem and solutions.

---

## **Useful Links**
- [LeetCode Problem 185](https://leetcode.com/problems/department-top-three-salaries/)
- [SQL DENSE_RANK() Function](https://www.w3schools.com/sql/sql_functions.asp)
- [Pandas Rank Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.rank.html)

---

