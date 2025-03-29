# **570. Managers with at Least 5 Direct Reports**

## **Problem Statement**
You are given a table `Employee` that holds all employee records, including their managers. Every employee has an `id`, a `name`, a `department`, and a `managerId`.

### **Employee Table**
```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
```
- `id` is the **primary key**.
- `managerId` is a **foreign key** that references the `id` of a manager in the same table.
- If `managerId` is `null`, then the employee does not have a manager.
- No employee will be the manager of themselves.

### **Task:**
Write a solution to find all managers (i.e., employees who appear as a managerId in the table) with **at least five direct reports**.

The result table should display the manager’s name in any order.

---

## **Example 1:**

### **Input:**
#### **Employee Table**
```
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
```

### **Output:**
```
+------+
| name |
+------+
| John |
+------+
```

### **Explanation:**
- **John** (id = 101) is the only manager who has **5 direct reports** (ids 102, 103, 104, 105, and 106).

---

## **Solution Approaches**

### **SQL Solution (Using Subquery)**
```sql
SELECT name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
);
```
**Explanation:**
- The subquery groups the `Employee` table by `managerId` and counts the number of direct reports.
- Only managers with a count of **5 or more** are selected.
- The outer query then retrieves the names of those managers.

---

### **SQL Solution (Using JOIN and Window Functions)**
```sql
SELECT name
FROM Employee
JOIN (
    SELECT managerId
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) AS managers
ON Employee.id = managers.managerId;
```
**Explanation:**
- The inner query identifies all `managerId`s with **at least five** direct reports.
- The outer query then joins on the `Employee` table to fetch the corresponding manager names.

---

### **Pandas Solution**
```python
import pandas as pd

def managers_with_five_reports(employee: pd.DataFrame) -> None:
    # Count direct reports for each manager
    report_counts = employee.groupby('managerId').size().reset_index(name='report_count')
    
    # Identify managerIds with at least five direct reports
    valid_managers = report_counts[report_counts['report_count'] >= 5]['managerId']
    
    # Filter the Employee table to get manager names
    # Note: Since managerId can be null, we ignore them during merge.
    result = employee[employee['id'].isin(valid_managers)][['name']]
    
    # Modify the original DataFrame in place if required.
    employee = result
    print(result)
```
**Explanation:**
- Group the table by `managerId` and count the number of direct reports.
- Filter out the managers having at least 5 direct reports.
- Finally, retrieve the names of these managers.

---

## **File Structure**
```
LeetCode570/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_subquery_solution.sql   # SQL solution using subquery.
├── sql_join_solution.sql       # SQL solution using JOIN.
├── pandas_solution.py          # Pandas solution for Python users.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 570](https://leetcode.com/problems/managers-with-at-least-5-direct-reports/)
- [SQL DELETE and JOIN Syntax](https://www.w3schools.com/sql/sql_join.asp)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

