# 🎯 Percentage of Users Attended a Contest - LeetCode 1633

## 📌 Problem Statement
You are given two tables, **Users** and **Register**.

- The **Users** table contains the users who are registered on the platform.
- The **Register** table records which user registered for which contest.

Your task is to **calculate the percentage of users who attended each contest**.

- Round the percentage to **two decimal places**.
- **Sort the results** by the percentage in descending order. If the percentages are the same, sort them by **contest_id** in ascending order.

---

## 📊 Table Structure

### **Users Table**
| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| user_name   | varchar |

- `user_id` is the **primary key** for this table.

### **Register Table**
| Column Name | Type |
| ----------- | ---- |
| contest_id  | int  |
| user_id     | int  |

- `(contest_id, user_id)` is the **primary key** for this table.
- This table keeps track of which user has registered for which contest.

---

## 📊 Example 1:

### **Input:**
#### **Users Table**
| user_id | user_name |
| ------- | --------- |
| 6       | Alice     |
| 2       | Bob       |
| 7       | Alex      |

#### **Register Table**
| contest_id | user_id |
| ---------- | ------- |
| 215        | 6       |
| 209        | 2       |
| 208        | 2       |
| 210        | 6       |
| 208        | 6       |
| 209        | 7       |
| 209        | 6       |
| 215        | 7       |
| 208        | 7       |
| 210        | 2       |
| 207        | 2       |
| 210        | 7       |

### **Output:**
| contest_id | percentage |
| ---------- | ---------- |
| 208        | 100.00     |
| 209        | 100.00     |
| 210        | 100.00     |
| 215        | 66.67      |
| 207        | 33.33      |

### **Explanation:**
- For **contest 208, 209, and 210**, **100%** of users attended these contests.
- For **contest 215**, **66.67%** of users attended it (Alice and Alex).
- For **contest 207**, only **33.33%** of users attended it (Bob).

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. Calculate the total number of users in the **Users** table using `SELECT COUNT(*) FROM Users`.
2. For each contest, count how many users registered for that contest in the **Register** table.
3. Calculate the percentage of users who registered for each contest using the formula:

   \[
   \text{Percentage} = \left( \frac{\text{Registered Users}}{\text{Total Users}} \right) \times 100
   \]

4. Round the percentage to **two decimal places**.
5. Sort the results by **percentage** in descending order. If there’s a tie, sort by **contest_id** in ascending order.

```sql
SELECT contest_id, ROUND((COUNT(user_id) / (SELECT COUNT(*) FROM Users) * 100), 2) AS percentage
FROM Register
GROUP BY contest_id
ORDER BY percentage DESC, contest_id ASC;
```

---

## 📁 File Structure
```
📂 Contest-Percentage
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/percentage-of-users-attended-a-contest/)
- 📝 [MySQL Aggregate Functions](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html)
- 🔍 [SQL ROUND Function](https://www.w3schools.com/sql/func_mysql_round.asp)
