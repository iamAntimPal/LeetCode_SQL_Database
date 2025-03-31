# 📝 Fix Names in a Table - LeetCode 1667

## 📌 Problem Statement
You are given a table **Users** that contains user IDs and names.

- The **name column** contains names that are written in a **mixed-case format** (e.g., `aLice`, `bOB`).
- Your task is to **correct the formatting** so that:
  - The **first letter** of the name is **uppercase**.
  - The **remaining letters** are **lowercase**.
- The result should be **ordered by user_id**.

---

## 📊 Table Structure

### **Users Table**
| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| name        | varchar |

- `user_id` is the **primary key** for this table.
- `name` contains only **uppercase and lowercase** letters.

---

## 📊 Example 1:

### **Input:**
#### **Users Table**
| user_id | name  |
| ------- | ----- |
| 1       | aLice |
| 2       | bOB   |

### **Output:**
| user_id | name  |
| ------- | ----- |
| 1       | Alice |
| 2       | Bob   |

### **Explanation:**
- The first letter of each name is converted to **uppercase**.
- The remaining letters are converted to **lowercase**.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. Use the `UPPER()` function to **capitalize** the **first letter** of the name.
2. Use the `LOWER()` function to convert the **rest of the name** to **lowercase**.
3. Use `LEFT(name, 1)` to extract the **first character** of the name.
4. Use `SUBSTRING(name, 2)` to extract the **rest of the name**.
5. Use `CONCAT()` to combine the capitalized first letter and the lowercase remaining part.
6. **Sort the output** by `user_id`.

```sql
SELECT user_id, 
       CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2))) AS name 
FROM Users 
ORDER BY user_id;
```

---

## 📁 File Structure
```
📂 Fix-Names
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/fix-names-in-a-table/)
- 🔍 [SQL CONCAT Function](https://www.w3schools.com/sql/func_mysql_concat.asp)
- 📝 [MySQL String Functions](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html)
