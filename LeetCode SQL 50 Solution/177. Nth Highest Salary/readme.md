# 177. Nth Highest Salary

## Problem Statement
Given a table `Employee`, write a SQL query to find the `nth` highest salary. If there is no `nth` highest salary, return `null`.

### Table Schema: `Employee`
| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| salary      | int  |

- `id` is the primary key (unique values for employees).
- `salary` column contains employee salary details.

### Example 1:
#### **Input:**
```sql
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
```
#### **Output:**
```sql
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
```

### Example 2:
#### **Input:**
```sql
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
```
#### **Output:**
```sql
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
```

---

## Approach
1. Use the `DENSE_RANK()` function to rank salaries in descending order.
2. Filter for the `nth` highest salary using a `WHERE` clause.
3. If there is no `nth` highest salary, return `NULL`.

---

## SQL Solution
```sql
CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT AS
BEGIN
  RETURN (
    SELECT DISTINCT salary FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET N-1
  );
END;
```

### Explanation:
- `ORDER BY salary DESC` sorts salaries in descending order.
- `LIMIT 1 OFFSET N-1` fetches the `nth` highest salary.
- If `N` is larger than the number of salaries, `NULL` is returned.

---

## Pandas Solution
```python
import pandas as pd

def getNthHighestSalary(employee: pd.DataFrame, N: int) -> pd.DataFrame:
    unique_salaries = employee['salary'].drop_duplicates().nlargest(N)
    if len(unique_salaries) < N:
        return pd.DataFrame({"getNthHighestSalary(N)": [None]})
    return pd.DataFrame({"getNthHighestSalary(N)": [unique_salaries.iloc[-1]]})
```

### Explanation:
- `drop_duplicates()` removes duplicate salaries.
- `nlargest(N)` gets the `N` highest salaries.
- If `N` is greater than available salaries, return `None`.

---

## File Structure
```
📂 nth_highest_salary
 ├── 📄 README.md       # Problem statement, approach, solution
 ├── 📄 nth_highest_salary.sql  # SQL Solution
 ├── 📄 nth_highest_salary.py   # Pandas Solution
 └── 📄 example_input_output.txt  # Sample input & expected output
```

---

## References
- [LeetCode Problem #177](https://leetcode.com/problems/nth-highest-salary/)
- [MySQL Documentation - LIMIT & OFFSET](https://dev.mysql.com/doc/refman/8.0/en/select.html)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

---

### Contributors
- **[Antim Pal]** 🚀

