# 🏢 Replace Employee ID With The Unique Identifier - LeetCode 1378

## 📌 Problem Statement
You are given two tables: **Employees** and **EmployeeUNI**.

Your task is to return a table with:
- Each employee's **unique ID** if it exists.
- If an employee **does not** have a unique ID, return `NULL`.

The result can be returned in **any order**.

---

## 📊 Table Structure

### **Employees Table**
| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| name        | varchar |

- `id` is the **primary key** (unique for each employee).
- `name` is the **employee's name**.

---

### **EmployeeUNI Table**
| Column Name | Type |
| ----------- | ---- |
| id          | int  |
| unique_id   | int  |

- `(id, unique_id)` is the **primary key** (ensuring unique mapping of employee IDs to unique IDs).
- Each employee **may or may not** have a corresponding **unique ID**.

---

## 📊 Example 1:
### **Input:**
#### **Employees Table**
| id  | name     |
| --- | -------- |
| 1   | Alice    |
| 7   | Bob      |
| 11  | Meir     |
| 90  | Winston  |
| 3   | Jonathan |

#### **EmployeeUNI Table**
| id  | unique_id |
| --- | --------- |
| 3   | 1         |
| 11  | 2         |
| 90  | 3         |

### **Output:**
| unique_id | name     |
| --------- | -------- |
| null      | Alice    |
| null      | Bob      |
| 2         | Meir     |
| 3         | Winston  |
| 1         | Jonathan |

### **Explanation:**
- `Alice` and `Bob` **do not have** a unique ID, so we return `NULL`.
- The **unique ID** of `Meir` is **2**.
- The **unique ID** of `Winston` is **3**.
- The **unique ID** of `Jonathan` is **1**.

---

## 🖥 SQL Solution

### ✅ **Using `LEFT JOIN`**
#### **Explanation:**
- Use a **LEFT JOIN** to **include all employees**.
- If an employee **does not have** a matching `unique_id`, return `NULL`.

```sql
SELECT eu.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu
ON e.id = eu.id;
```

### ✅ **Using `USING(id)`**
#### **Explanation:**
- `USING(id)` is a cleaner alternative when both tables share a column.

```sql
SELECT unique_id, name
FROM Employees
LEFT JOIN EmployeeUNI
USING (id);
```

### ✅ **Sorting by `id` (Optional)**
#### **Explanation:**
- If you want to return the result **sorted by `id`**, add `ORDER BY e.id`:

```sql
SELECT eu.unique_id, e.name
FROM Employees e
LEFT JOIN EmployeeUNI eu
ON e.id = eu.id
ORDER BY e.id;
```

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
- Merge `Employees` with `EmployeeUNI` **using `left` join** on `id`.
- Fill missing values (`NaN`) with `None`.

```python
import pandas as pd

def replace_employee_id(employees: pd.DataFrame, employee_uni: pd.DataFrame) -> pd.DataFrame:
    merged_df = employees.merge(employee_uni, on="id", how="left")
    return merged_df[["unique_id", "name"]]
```

---

## 📁 File Structure
```
📂 Replace-Employee-ID
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/replace-employee-id-with-the-unique-identifier/)
- 📚 [SQL `LEFT JOIN`](https://www.w3schools.com/sql/sql_join_left.asp)
- 🐍 [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)

## Would you like any modifications? 🚀