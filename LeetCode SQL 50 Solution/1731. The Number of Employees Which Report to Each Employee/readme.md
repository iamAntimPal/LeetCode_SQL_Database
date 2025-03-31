# 👥 The Number of Employees Which Report to Each Employee - LeetCode 1731

## 📌 Problem Statement
You are given a table **Employees** that contains the following columns:
- `employee_id`: The unique ID of the employee.
- `name`: The name of the employee.
- `reports_to`: The `employee_id` of the manager the employee reports to (can be `NULL` if the employee does not report to anyone).
- `age`: The age of the employee.

A manager is defined as an employee who has **at least 1 direct report**.  
Your task is to report:
- The **IDs and names of all managers**.
- The **number of employees** who report **directly** to them.
- The **average age** of their direct reports, rounded to the nearest integer.

Return the result **ordered by `employee_id`** in ascending order.

---

## 📊 Table Structure

### **Employees Table**
| Column Name | Type    |
| ----------- | ------- |
| employee_id | int     |
| name        | varchar |
| reports_to  | int     |
| age         | int     |

- `employee_id` is the **primary key**.
- `reports_to` may be `NULL` for employees who do not report to anyone.

---

## 📊 Example 1:

### **Input:**
| employee_id | name    | reports_to | age |
| ----------- | ------- | ---------- | --- |
| 9           | Hercy   | NULL       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | NULL       | 37  |

### **Output:**
| employee_id | name  | reports_count | average_age |
| ----------- | ----- | ------------- | ----------- |
| 9           | Hercy | 2             | 39          |

### **Explanation:**
- **Hercy** (employee_id = 9) is a manager with two direct reports: **Alice** (age 41) and **Bob** (age 36).  
- The average age of these reports is (41 + 36) / 2 = 38.5, which is rounded to **39**.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. Use a **self-join** on the **Employees** table where the employee’s `reports_to` matches the manager’s `employee_id`.
2. Count the number of direct reports for each manager.
3. Compute the average age of the direct reports and round the result to the nearest integer.
4. Group by the manager’s `employee_id` and order the results by `employee_id`.

```sql
SELECT
  Manager.employee_id,
  Manager.name,
  COUNT(Employee.employee_id) AS reports_count,
  ROUND(AVG(Employee.age)) AS average_age
FROM Employees AS Manager
INNER JOIN Employees AS Employee
  ON Employee.reports_to = Manager.employee_id
GROUP BY Manager.employee_id
ORDER BY Manager.employee_id;
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. Filter the DataFrame to create a join between managers and their direct reports.
2. Group by the manager’s `employee_id` and compute:
   - The count of direct reports.
   - The average age of the reports, then round the average.
3. Merge the results with the original manager information.
4. Sort the result by `employee_id`.

```python
import pandas as pd

def employees_reporting(employees: pd.DataFrame) -> pd.DataFrame:
    # Merge the table with itself: one for managers and one for employees reporting to them.
    merged = employees.merge(
        employees, 
        left_on='employee_id', 
        right_on='reports_to', 
        suffixes=('_manager', '_report')
    )
    
    # Group by manager's employee_id and name, then compute the count and average age of reports.
    result = merged.groupby(['employee_id_manager', 'name_manager']).agg(
        reports_count=('employee_id_report', 'count'),
        average_age=('age_report', lambda x: round(x.mean()))
    ).reset_index()
    
    # Rename columns to match expected output.
    result.rename(columns={
        'employee_id_manager': 'employee_id',
        'name_manager': 'name'
    }, inplace=True)
    
    # Sort by employee_id in ascending order.
    result = result.sort_values('employee_id').reset_index(drop=True)
    return result
```

---

## 📁 File Structure
```
📂 Employees-Reporting
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/)
- 🔍 [MySQL GROUP BY Documentation](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
