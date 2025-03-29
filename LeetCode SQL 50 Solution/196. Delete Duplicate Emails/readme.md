
# **196. Delete Duplicate Emails**

## **Problem Statement**
You are given a table called `Person`, which stores email addresses.

### **Person Table**
```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| email       | varchar |
+-------------+---------+
```
- `id` is the **primary key**.
- Each row contains an **email address**.
- All emails are in **lowercase**.

### **Task:**
Delete all **duplicate emails**, keeping only **one unique email** with the **smallest id**.

---

## **Example 1:**
### **Input:**
#### **Person Table**
```
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
| 3  | john@example.com |
+----+------------------+
```
### **Output:**
```
+----+------------------+
| id | email            |
+----+------------------+
| 1  | john@example.com |
| 2  | bob@example.com  |
+----+------------------+
```
### **Explanation:**
- `john@example.com` appears **twice**.
- We keep the row with the **smallest `id`** (`id = 1`).
- The duplicate (`id = 3`) is **deleted**.

---

## **Solution Approaches**

### **SQL Solution (Using Self Join)**
```sql
DELETE p2 FROM Person p1 
JOIN Person p2 
ON p1.email = p2.email AND p1.id < p2.id;
```
**Explanation:**
- `p1` and `p2` refer to the **same table** (`Person`).
- We **join** them on `email` to find duplicates.
- If `p1.id < p2.id`, we delete `p2`, keeping the row with the **smallest id**.

---

### **SQL Solution (Using Subquery)**
```sql
DELETE FROM Person
WHERE id NOT IN (
    SELECT MIN(id) FROM Person GROUP BY email
);
```
**Explanation:**
- We **group** by `email` and **select the smallest `id`** for each email.
- The `DELETE` statement removes rows **not in** this list.

---

### **Pandas Solution**
```python
import pandas as pd

def delete_duplicate_emails(person: pd.DataFrame) -> None:
    # Keep only the first occurrence of each email (smallest id)
    person.drop_duplicates(subset=['email'], keep='first', inplace=True)
```
**Explanation:**
- `drop_duplicates(subset=['email'], keep='first', inplace=True)`:
  - Keeps only **the first occurrence** of each email.
  - Ensures **modification happens in place**.

---

## **File Structure**
```
📂 LeetCode196
│── 📜 problem_statement.md
│── 📜 sql_self_join_solution.sql
│── 📜 sql_subquery_solution.sql
│── 📜 pandas_solution.py
│── 📜 README.md
```
- `problem_statement.md` → Contains the problem description.
- `sql_self_join_solution.sql` → Contains the SQL solution using **JOIN**.
- `sql_subquery_solution.sql` → Contains the SQL solution using **Subquery**.
- `pandas_solution.py` → Contains the Pandas solution for Python users.
- `README.md` → Provides an overview of the problem and solutions.

---

## **Useful Links**
- [LeetCode Problem 196](https://leetcode.com/problems/delete-duplicate-emails/)
- [SQL DELETE Statement](https://www.w3schools.com/sql/sql_delete.asp)
- [Pandas drop_duplicates()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.drop_duplicates.html)

---
