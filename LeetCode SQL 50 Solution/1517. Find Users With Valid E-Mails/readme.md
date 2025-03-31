# 📩 Find Users With Valid E-Mails - LeetCode 1517

## 📌 Problem Statement
You are given a table **Users** that contains user registration details, including their emails. Some of these emails may be **invalid**.

A valid email:
- Has a **prefix name** and a **domain**.
- The prefix:
  - **Must start with a letter** (uppercase or lowercase).
  - Can contain **letters**, **digits**, **underscore (`_`)**, **period (`.`)**, and/or **dash (`-`)**.
- The domain must be **"@leetcode.com"**.

Your task is to **find users with valid emails**.

---

## 📊 Table Structure

### **Users Table**
| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| name        | varchar |
| mail        | varchar |

- `user_id` is the **primary key**.

---

## 📊 Example 1:

### **Input:**
#### **Users Table**
| user_id | name      | mail                    |
| ------- | --------- | ----------------------- |
| 1       | Winston   | winston@leetcode.com    |
| 2       | Jonathan  | jonathanisgreat         |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |
| 5       | Marwan    | quarz#2020@leetcode.com |
| 6       | David     | david69@gmail.com       |
| 7       | Shapiro   | .shapo@leetcode.com     |

### **Output:**
| user_id | name      | mail                    |
| ------- | --------- | ----------------------- |
| 1       | Winston   | winston@leetcode.com    |
| 3       | Annabelle | bella-@leetcode.com     |
| 4       | Sally     | sally.come@leetcode.com |

### **Explanation:**
- ✅ **Valid emails:**
  - `winston@leetcode.com` ✅ (Starts with a letter, correct domain)
  - `bella-@leetcode.com` ✅ (Starts with a letter, correct domain)
  - `sally.come@leetcode.com` ✅ (Starts with a letter, correct domain)
- ❌ **Invalid emails:**
  - `jonathanisgreat` ❌ (No domain)
  - `quarz#2020@leetcode.com` ❌ (Contains `#`, which is not allowed)
  - `david69@gmail.com` ❌ (Wrong domain)
  - `.shapo@leetcode.com` ❌ (Starts with a period `.`)

---

## 🖥 SQL Solution

### ✅ **Using `REGEXP_LIKE` (MySQL)**
#### **Explanation:**
- Use `REGEXP_LIKE(mail, '^[A-Za-z]+[A-Za-z0-9_.-]*@leetcode\\.com$')`
  - `^` → Start of string.
  - `[A-Za-z]+` → First character **must** be a **letter**.
  - `[A-Za-z0-9_.-]*` → Rest can be **letters, numbers, `_`, `.`, or `-`**.
  - `@leetcode\\.com$` → Must end with `"@leetcode.com"`.

```sql
SELECT *
FROM Users
WHERE REGEXP_LIKE(mail, '^[A-Za-z]+[A-Za-z0-9_.-]*@leetcode\\.com$');
```

---

## 📁 File Structure
```
📂 Find-Users-With-Valid-Emails
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/find-users-with-valid-e-mails/)
- 🔍 [MySQL REGEXP_LIKE Documentation](https://dev.mysql.com/doc/refman/8.0/en/regexp.html)
- 📝 [SQL Regular Expressions Cheatsheet](https://www.w3schools.com/sql/sql_regex.asp)
her learning**  
## Would you like any modifications? 🚀