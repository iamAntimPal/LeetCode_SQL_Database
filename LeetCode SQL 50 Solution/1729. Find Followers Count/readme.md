Here’s a well-structured `README.md` for **LeetCode 1729 - Find Followers Count**, formatted for a GitHub repository:

```md
# 📊 Find Followers Count - LeetCode 1729

## 📌 Problem Statement
You are given a table **Followers** that contains the following information:

- `user_id`: The ID of the user being followed.
- `follower_id`: The ID of the user who is following.

Your task is to return a list of users with their **follower count**, sorted in **ascending order of `user_id`**.

---

## 📊 Table Structure

### **Followers Table**
| Column Name | Type |
| ----------- | ---- |
| user_id     | int  |
| follower_id | int  |

- `(user_id, follower_id)` is the **primary key**.
- Each row represents a **follower relationship** between two users.

---

## 📊 Example 1:

### **Input:**
#### **Followers Table**
| user_id | follower_id |
| ------- | ----------- |
| 0       | 1           |
| 1       | 0           |
| 2       | 0           |
| 2       | 1           |

### **Output:**
| user_id | followers_count |
| ------- | --------------- |
| 0       | 1               |
| 1       | 1               |
| 2       | 2               |

### **Explanation:**
- **User 0** has **1 follower** `{1}`.
- **User 1** has **1 follower** `{0}`.
- **User 2** has **2 followers** `{0, 1}`.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. Use `COUNT(follower_id)` to count the number of followers for each `user_id`.
2. Use `GROUP BY user_id` to group the followers for each user.
3. Sort the result by `user_id` in **ascending order**.

```sql
SELECT user_id, COUNT(follower_id) AS followers_count
FROM Followers
GROUP BY user_id
ORDER BY user_id;
```

---

## 📁 File Structure
```
📂 Find-Followers-Count
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/find-followers-count/)
- 📝 [MySQL COUNT Function](https://www.w3schools.com/sql/sql_count.asp)
