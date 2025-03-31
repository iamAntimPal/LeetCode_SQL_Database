# 🏥 Patients With a Condition - LeetCode 1527

## 📌 Problem Statement
You are given a **Patients** table that stores patient health records, including their medical conditions.

Each patient's **conditions** column contains **0 or more condition codes**, separated by spaces.

Your task is to **find all patients who have Type I Diabetes**.  
- Type I Diabetes is identified by a condition **starting with the prefix "DIAB1"**.

Return the result **in any order**.

---

## 📊 Table Structure

### **Patients Table**
| Column Name  | Type    |
| ------------ | ------- |
| patient_id   | int     |
| patient_name | varchar |
| conditions   | varchar |

- `patient_id` is the **primary key**.
- `conditions` contains **space-separated condition codes**.

---

## 📊 Example 1:

### **Input:**
#### **Patients Table**
| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 1          | Daniel       | YFEV COUGH   |
| 2          | Alice        |              |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |
| 5          | Alain        | DIAB201      |

### **Output:**
| patient_id | patient_name | conditions   |
| ---------- | ------------ | ------------ |
| 3          | Bob          | DIAB100 MYOP |
| 4          | George       | ACNE DIAB100 |

### **Explanation:**
- ✅ **Bob's condition:** `"DIAB100 MYOP"` → **Starts with `"DIAB1"`** → ✅ **Valid**
- ✅ **George's condition:** `"ACNE DIAB100"` → **Contains `"DIAB1"`** → ✅ **Valid**
- ❌ **Daniel's condition:** `"YFEV COUGH"` → **No `"DIAB1"`**
- ❌ **Alice's condition:** `""` (Empty)
- ❌ **Alain's condition:** `"DIAB201"` → Does **not** start with `"DIAB1"`

---

## 🖥 SQL Solution

### ✅ **Using `LIKE` with wildcards**
#### **Explanation:**
- We need to check if `"DIAB1"` appears **at the beginning** or **somewhere in the conditions column**.
- `LIKE 'DIAB1%'` → Matches if `"DIAB1"` is at the **start** of the column.
- `LIKE '% DIAB1%'` → Matches if `"DIAB1"` appears **after a space (as part of multiple conditions).**

```sql
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions LIKE 'DIAB1%' OR conditions LIKE '% DIAB1%';
```

---

## 📁 File Structure
```
📂 Patients-With-Condition
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/patients-with-a-condition/)
- 🔍 [SQL LIKE Operator](https://www.w3schools.com/sql/sql_like.asp)
- 📝 [MySQL String Functions](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html)
## Would you like any refinements? 🚀