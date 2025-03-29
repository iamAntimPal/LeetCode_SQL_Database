
# **610. Triangle Judgement**

## **Problem Statement**
You are given a table `Triangle` that contains three integer values representing the lengths of three line segments.

### **Triangle Table**
```
+-------------+------+
| Column Name | Type |
+-------------+------+
| x           | int  |
| y           | int  |
| z           | int  |
+-------------+------+
```
- **(x, y, z)** is the **primary key**.
- Each row represents the lengths of three line segments.

### **Task:**
Report for each row whether the three line segments can form a triangle. A triangle can be formed if and only if the sum of any two sides is greater than the third side.

---

## **Example 1:**

### **Input:**
#### **Triangle Table**
```
+----+----+----+
| x  | y  | z  |
+----+----+----+
| 13 | 15 | 30 |
| 10 | 20 | 15 |
+----+----+----+
```

### **Output:**
```
+----+----+----+----------+
| x  | y  | z  | triangle |
+----+----+----+----------+
| 13 | 15 | 30 | No       |
| 10 | 20 | 15 | Yes      |
+----+----+----+----------+
```

### **Explanation:**
- For the first row: `13 + 15` is not greater than `30`, so the segments cannot form a triangle.  
- For the second row: All conditions are met (`10+20 > 15`, `10+15 > 20`, `20+15 > 10`), so they form a triangle.

---

## **Solution Approaches**

### **SQL Solution**
```sql
SELECT
  x,
  y,
  z,
  IF(x + y > z AND x + z > y AND y + z > x, 'Yes', 'No') AS triangle
FROM Triangle;
```
**Explanation:**
- The query checks if the sum of any two sides is greater than the third side.
- If all conditions are true, it returns `'Yes'`; otherwise, it returns `'No'`.

---

### **Pandas Solution**
```python
import pandas as pd

def triangle_judgement(triangle: pd.DataFrame) -> pd.DataFrame:
    # Create a new column 'triangle' based on the triangle inequality conditions
    triangle['triangle'] = triangle.apply(
        lambda row: 'Yes' if (row['x'] + row['y'] > row['z'] and 
                              row['x'] + row['z'] > row['y'] and 
                              row['y'] + row['z'] > row['x']) else 'No',
        axis=1
    )
    return triangle

# Example usage:
# df = pd.DataFrame({'x': [13, 10], 'y': [15, 20], 'z': [30, 15]})
# print(triangle_judgement(df))
```
**Explanation:**
- The Pandas solution uses `apply()` with a lambda function to evaluate the triangle inequality for each row.
- It then creates a new column `triangle` with the result `'Yes'` or `'No'`.

---

## **File Structure**
```
LeetCode610/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 610](https://leetcode.com/problems/triangle-judgement/)
- [SQL IF Function](https://www.w3schools.com/sql/func_mysql_if.asp)
- [Pandas apply() Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html)
