# 176. Second Highest Salary

## Problem Statement
You are given a table `Employee` containing the salaries of employees. The goal is to find the second highest distinct salary from this table. If there is no second highest salary, return `NULL` (or `None` in Pandas).

### Table: Employee

| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| salary      | int  |

- `id` is the primary key for this table.
- Each row contains salary information for an employee.

## Example 1:

### **Input:**

| id  | salary |
| --- | ------ |
| 1   | 100    |
| 2   | 200    |
| 3   | 300    |

### **Output:**

| SecondHighestSalary |
| ------------------- |
| 200                 |

## Example 2:

### **Input:**

| id  | salary |
| --- | ------ |
| 1   | 100    |

### **Output:**

| SecondHighestSalary |
| ------------------- |
| NULL                |

---
## **Approach**

### **SQL Approach**
1. **Use a Window Function:**
   - Apply `DENSE_RANK()` to rank salaries in descending order.
   - Assign rank `1` to the highest salary, `2` to the second highest, and so on.
2. **Filter by Rank:**
   - Select the salary where `rank = 2`.
   - If no second highest salary exists, return `NULL`.

---
## **Solution**

```sql
WITH RankedEmployees AS (
    SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS `rank`
    FROM Employee
)
SELECT MAX(salary) AS SecondHighestSalary
FROM RankedEmployees
WHERE `rank` = 2;
```

---
## **File Structure**
```
📂 SecondHighestSalary
├── 📄 README.md  # Problem statement, approach, and solution
├── 📄 solution.sql  # SQL query file
├── 📄 solution_pandas.py  # Pandas solution file
```

---
## **Alternative Pandas Approach**

```python
import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    unique_salaries = employee['salary'].drop_duplicates().nlargest(2)
    second_highest = unique_salaries.iloc[1] if len(unique_salaries) > 1 else None
    return pd.DataFrame({'SecondHighestSalary': [second_highest]})
```

---
## **Resources & References**
- [LeetCode Problem Link](https://leetcode.com/problems/second-highest-salary/)
- [SQL DENSE_RANK() Documentation](https://www.sqlservertutorial.net/sql-server-window-functions/sql-server-dense_rank-function/)

---
## **Contribute**
Feel free to contribute by submitting an issue or a pull request!

