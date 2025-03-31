# 🏢 Employees Whose Manager Left the Company - LeetCode 1978

## 📌 Problem Statement
You are given a table **Employees** that contains information about employees, including their salary and the ID of the manager they report to.  
When a manager leaves the company, their row is deleted from the **Employees** table, but the `manager_id` in the records of their reports still remains.

Your task is to **find the IDs of employees** who:
- Have a salary **strictly less than $30000**.
- Have a **manager** (i.e., `manager_id` is not `NULL`) whose record is **missing** in the table (i.e., the manager left the company).

Return the result table **ordered by `employee_id`** in ascending order.

---

## 📊 Table Structure

### **Employees Table**
| Column Name | Type    |
| ----------- | ------- |
| employee_id | int     |
| name        | varchar |
| manager_id  | int     |
| salary      | int     |

- `employee_id` is the **primary key**.
- `manager_id` may be `NULL` if an employee does not have a manager.
- When a manager leaves, their row is deleted, but the `manager_id` remains in the reports' records.

---

## 📊 Example 1:

### **Input:**
#### **Employees Table**
| employee_id | name      | manager_id | salary |
| ----------- | --------- | ---------- | ------ |
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | NULL       | 31000  |
| 13          | Emery     | NULL       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | NULL       | 50937  |
| 11          | Joziah    | 6          | 28485  |

### **Output:**
| employee_id |
| ----------- |
| 11          |

### **Explanation:**
- **Employees with salary < $30000:**  
  - **Kalel (ID 1)** with salary 21241, whose manager is employee 11.
  - **Joziah (ID 11)** with salary 28485, whose manager is employee 6.
- **Kalel's manager (ID 11)** is still in the table.  
- **Joziah's manager (ID 6)** is missing from the table, meaning that manager left the company.  
Thus, only **employee 11 (Joziah)** meets the criteria.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. **Self-Join:**  
   - Use a `LEFT JOIN` on the **Employees** table with itself to check if an employee's manager exists.
   - Alias `e1` represents the employee, and alias `e2` represents the manager.
2. **Filter Conditions:**
   - The employee's `salary` must be strictly less than 30000.
   - The employee must have a manager (`e1.manager_id IS NOT NULL`).
   - The join should fail for the manager (`e2.employee_id IS NULL`), indicating the manager left.
3. **Order the Result:**  
   - Order the final result by `employee_id`.

### ✅ **SQL Query:**
```sql
SELECT e1.employee_id
FROM Employees AS e1
LEFT JOIN Employees AS e2 ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000
  AND e1.manager_id IS NOT NULL
  AND e2.employee_id IS NULL
ORDER BY e1.employee_id;
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. **Self-Merge:**  
   - Merge the **Employees** DataFrame with itself on `manager_id` (from the employee side) and `employee_id` (from the manager side) using a left join.
2. **Filter Rows:**  
   - Keep rows where:
     - `salary` is less than 30000.
     - `manager_id` is not null.
     - The merged manager information is missing (i.e., the manager left).
3. **Sort Result:**  
   - Sort the result by `employee_id`.

### ✅ **Pandas Code:**
```python
import pandas as pd

def employees_with_left_manager(employees: pd.DataFrame) -> pd.DataFrame:
    # Perform a left merge on the Employees table to find existing managers
    merged = employees.merge(
        employees[['employee_id']], 
        left_on='manager_id', 
        right_on='employee_id', 
        how='left', 
        suffixes=('', '_manager')
    )
    
    # Filter: salary < 30000, manager_id is not null, and manager does not exist (NaN in employee_id_manager)
    filtered = merged[
        (merged['salary'] < 30000) &
        (merged['manager_id'].notnull()) &
        (merged['employee_id_manager'].isna())
    ]
    
    # Select the required column and sort by employee_id
    result = filtered[['employee_id']].sort_values('employee_id')
    return result

# Example usage:
# employees_df = pd.read_csv("employees.csv")
# print(employees_with_left_manager(employees_df))
```

---

## 📁 File Structure
```
📂 Employees-Manager-Left
│── README.md
│── solution.sql
│── solution_pandas.py
│── test_cases.sql
│── sample_data.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/employees-whose-manager-left-the-company/)
- 🔍 [MySQL LEFT JOIN Documentation](https://www.w3schools.com/sql/sql_join_left.asp)
- 🐍 [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)
```

