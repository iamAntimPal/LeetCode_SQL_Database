# 180. Consecutive Numbers

## Problem Statement
You are given a table `Logs` with the following structure:

```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
```
- `id` is the primary key and auto-increments starting from 1.
- Find all numbers that appear **at least three times consecutively**.
- Return the result table in **any order**.

## Example 1:

**Input:**

```
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
```

**Output:**

```
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+
```

---

## Solution Approaches

### **SQL Solution (Using Self Join)**
```sql
SELECT DISTINCT l1.num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1 AND l1.num = l2.num
JOIN Logs l3 ON l1.id = l3.id - 2 AND l1.num = l3.num;
```

### **SQL Solution (Using Window Functions)**
```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM (
    SELECT num, LAG(num,1) OVER (ORDER BY id) AS prev1,
                LAG(num,2) OVER (ORDER BY id) AS prev2
    FROM Logs
) temp
WHERE num = prev1 AND num = prev2;
```

### **Pandas Solution**
```python
import pandas as pd

def consecutive_numbers(logs: pd.DataFrame) -> pd.DataFrame:
    logs['prev1'] = logs['num'].shift(1)
    logs['prev2'] = logs['num'].shift(2)
    
    result = logs[(logs['num'] == logs['prev1']) & (logs['num'] == logs['prev2'])]
    return pd.DataFrame({'ConsecutiveNums': result['num'].unique()})
```

---


## File Structure
```
📂 Problem Name
 ├── 📄 README.md       # Problem statement, approach, solution
 ├── 📄 sql_solution.sql  # SQL Solution
 ├── 📄 pandas_solution.py   # Pandas Solution
 └── 📄 example_input_output.txt  # Sample input & expected output
```

## Useful Links
- [LeetCode Problem](https://leetcode.com/problems/consecutive-numbers/) 🚀
- [SQL `JOIN` Explained](https://www.w3schools.com/sql/sql_join.asp)
- [MySQL `LAG()` Window Function](https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html)

---

Feel free to contribute with optimized solutions! 💡