# **619. Biggest Single Number**

## **Problem Statement**
You are given a table `MyNumbers` that contains integers, which may include duplicates.

### **MyNumbers Table**
```rb
+-------------+------+
| Column Name | Type |
+-------------+------+
| num         | int  |
+-------------+------+
```
- There is **no primary key** for this table.
- Each row contains an integer.

### **Task:**
A **single number** is a number that appears **only once** in the `MyNumbers` table.  
Find the **largest single number**. If there is no single number, report `null`.

---

## **Example 1:**

### **Input:**
```rb
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 3   |
| 3   |
| 1   |
| 4   |
| 5   |
| 6   |
+-----+
```

### **Output:**
```rb
+-----+
| num |
+-----+
| 6   |
+-----+
```

### **Explanation:**
- The single numbers (appear exactly once) are: **1, 4, 5, 6**.
- The largest among these is **6**.

---

## **Example 2:**

### **Input:**
```rb
MyNumbers table:
+-----+
| num |
+-----+
| 8   |
| 8   |
| 7   |
| 7   |
| 3   |
| 3   |
| 3   |
+-----+
```

### **Output:**
```
+------+
| num  |
+------+
| null |
+------+
```

### **Explanation:**
- There are no single numbers (all numbers appear more than once), so the result is `null`.

---

## **Solution Approaches**

### **SQL Solution**
```sql
SELECT MAX(num) AS num
FROM (
    SELECT num
    FROM MyNumbers
    GROUP BY num
    HAVING COUNT(num) = 1
) AS unique_numbers;
```
**Explanation:**
- The subquery groups by `num` and filters to include only those numbers that appear exactly once (`HAVING COUNT(num) = 1`).
- The outer query returns the maximum value from these unique numbers.
- If no unique number exists, `MAX(num)` returns `null`.

---

### **Pandas Solution**
```python
import pandas as pd

def biggest_single_number(my_numbers: pd.DataFrame) -> pd.DataFrame:
    # Group by 'num' and filter those numbers that appear exactly once
    unique_numbers = my_numbers.groupby('num').filter(lambda group: len(group) == 1)
    
    # Determine the largest single number, if any
    if unique_numbers.empty:
        result = None
    else:
        result = unique_numbers['num'].max()
    
    return pd.DataFrame({'num': [result]})

# Example usage:
# df = pd.DataFrame({'num': [8, 8, 3, 3, 1, 4, 5, 6]})
# print(biggest_single_number(df))
```
**Explanation:**
- The solution groups the DataFrame by `num` and filters groups where the number appears exactly once.
- It then calculates the maximum from the filtered DataFrame.
- If there are no unique numbers, it returns `None`.

---

## **File Structure**
```
LeetCode619/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution for Python users.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 619](https://leetcode.com/problems/biggest-single-number/)
- [SQL GROUP BY and HAVING Clause](https://www.w3schools.com/sql/sql_groupby.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
- [Pandas filter() Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.filter.html)

