
# 🏆 Project Employees I - LeetCode 1075

## 📌 Problem Statement
You are given two tables: **Project** and **Employee**.

### Project Table
| Column Name | Type |
| ----------- | ---- |
| project_id  | int  |
| employee_id | int  |

- `(project_id, employee_id)` is the primary key of this table.
- `employee_id` is a foreign key referencing the `Employee` table.

### Employee Table
| Column Name      | Type    |
| ---------------- | ------- |
| employee_id      | int     |
| name             | varchar |
| experience_years | int     |

- `employee_id` is the primary key.
- `experience_years` is guaranteed to be **NOT NULL**.

The task is to **return the average experience years of all employees for each project, rounded to 2 decimal places**.

---

## 📊 Example 1:
### Input:
**Project Table**
| project_id | employee_id |
| ---------- | ----------- |
| 1          | 1           |
| 1          | 2           |
| 1          | 3           |
| 2          | 1           |
| 2          | 4           |

**Employee Table**
| employee_id | name   | experience_years |
| ----------- | ------ | ---------------- |
| 1           | Khaled | 3                |
| 2           | Ali    | 2                |
| 3           | John   | 1                |
| 4           | Doe    | 2                |

### Output:
| project_id | average_years |
| ---------- | ------------- |
| 1          | 2.00          |
| 2          | 2.50          |

### Explanation:
- **Project 1:** `(3 + 2 + 1) / 3 = 2.00`
- **Project 2:** `(3 + 2) / 2 = 2.50`

---

## 🖥 SQL Solutions

### 1️⃣ Standard MySQL Solution
#### Explanation:
- We **JOIN** the `Project` and `Employee` tables using `employee_id`.
- We **calculate the average** of `experience_years` for each `project_id`.
- We **round** the result to **two decimal places**.

```sql
SELECT project_id, ROUND(AVG(experience_years), 2) AS average_years
FROM project AS p
LEFT JOIN employee AS e
ON p.employee_id = e.employee_id
GROUP BY project_id;
```

---

### 2️⃣ Window Function (SQL) Solution
#### Explanation:
- Using **window functions**, we calculate the `AVG(experience_years)` over a **partitioned** dataset.

```sql
SELECT DISTINCT project_id, 
       ROUND(AVG(experience_years) OVER (PARTITION BY project_id), 2) AS average_years
FROM project AS p
JOIN employee AS e 
ON p.employee_id = e.employee_id;
```

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- We read both tables into Pandas **DataFrames**.
- We merge the tables on `employee_id`.
- We group by `project_id` and compute the mean.
- We round the output to 2 decimal places.

```python
import pandas as pd

def project_average_experience(project: pd.DataFrame, employee: pd.DataFrame) -> pd.DataFrame:
    df = project.merge(employee, on="employee_id")
    result = df.groupby("project_id")["experience_years"].mean().round(2).reset_index()
    result.columns = ["project_id", "average_years"]
    return result
```

---

## 📁 File Structure
```
📂 Project-Employees-I
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_window.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/project-employees-i/)
- 📚 [SQL Joins Explanation](https://www.w3schools.com/sql/sql_join.asp)
- 🐍 [Pandas Documentation](https://pandas.pydata.org/docs/)

---

## Let me know if you need any modifications! 🚀