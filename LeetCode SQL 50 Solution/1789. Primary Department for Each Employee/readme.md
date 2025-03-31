# 🏢 Primary Department for Each Employee - LeetCode 1789

## 📌 Problem Statement
You are given a table **Employee** that contains the following columns:

- **employee_id**: The ID of the employee.
- **department_id**: The ID of the department to which the employee belongs.
- **primary_flag**: An ENUM ('Y', 'N').  
  - If `primary_flag` is `'Y'`, then the department is the primary department for that employee.
  - If `primary_flag` is `'N'`, then the department is not primary.

**Note:**  
- An employee can belong to multiple departments. When an employee joins multiple departments, they decide which one is their primary (set to `'Y'`).
- If an employee belongs to only one department, then their `primary_flag` is `'N'`, but that department is still considered their primary department.

Your task is to **report all employees with their primary department**.  
For employees who belong to only one department, report that department.

Return the result table in **any order**.

---

## 📊 Table Structure

### **Employee Table**
| Column Name   | Type    |
| ------------- | ------- |
| employee_id   | int     |
| department_id | int     |
| primary_flag  | varchar |

- `(employee_id, department_id)` is the **primary key** for this table.

---

## 📊 Example 1:

### **Input:**
#### **Employee Table**
| employee_id | department_id | primary_flag |
| ----------- | ------------- | ------------ |
| 1           | 1             | N            |
| 2           | 1             | Y            |
| 2           | 2             | N            |
| 3           | 3             | N            |
| 4           | 2             | N            |
| 4           | 3             | Y            |
| 4           | 4             | N            |

### **Output:**
| employee_id | department_id |
| ----------- | ------------- |
| 1           | 1             |
| 2           | 1             |
| 3           | 3             |
| 4           | 3             |

### **Explanation:**
- **Employee 1** belongs to only one department (1), so department 1 is their primary.
- **Employee 2** belongs to departments 1 and 2. The row with `primary_flag = 'Y'` indicates that department 1 is their primary.
- **Employee 3** belongs only to department 3.
- **Employee 4** belongs to departments 2, 3, and 4. The row with `primary_flag = 'Y'` indicates that department 3 is their primary.

---

## 🖥 SQL Solution

### ✅ **Approach:**
- **Step 1:** For employees who have `primary_flag = 'Y'`, choose those rows.
- **Step 2:** For employees who belong to only one department, return that row.
- Combine the results using `UNION DISTINCT`.

```sql
SELECT employee_id, department_id
FROM Employee
WHERE primary_flag = 'Y'
UNION DISTINCT
SELECT employee_id, department_id
FROM Employee
GROUP BY employee_id
HAVING COUNT(*) = 1;
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. **Group** the DataFrame by `employee_id`.
2. For each group:
   - If any row has `primary_flag == 'Y'`, choose the first such row.
   - Otherwise (i.e., employee belongs to only one department), choose that row.
3. Return the resulting DataFrame with only `employee_id` and `department_id`.

```python
import pandas as pd

def primary_department(employees: pd.DataFrame) -> pd.DataFrame:
    def select_primary(group):
        # If there's any row with primary_flag 'Y', choose the first one
        if (group['primary_flag'] == 'Y').any():
            return group[group['primary_flag'] == 'Y'].iloc[0]
        else:
            # For employees with only one department
            return group.iloc[0]
    
    result = employees.groupby('employee_id').apply(select_primary).reset_index(drop=True)
    return result[['employee_id', 'department_id']]
```

---

## 📁 File Structure
```
📂 Primary-Department
│── README.md
│── solution.sql
│── solution_pandas.py
│── test_cases.sql
│── sample_data.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/primary-department-for-each-employee/)
- 🔍 [MySQL UNION Operator](https://www.w3schools.com/sql/sql_union.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
