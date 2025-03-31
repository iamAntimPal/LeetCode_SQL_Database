# 🐦 Invalid Tweets - LeetCode 1683

## 📌 Problem Statement
You are given a table **Tweets** that contains tweet IDs and their content.

- A tweet is **invalid** if its content exceeds **15 characters**.
- Your task is to find and return the **IDs of all invalid tweets**.

---

## 📊 Table Structure

### **Tweets Table**
| Column Name | Type    |
| ----------- | ------- |
| tweet_id    | int     |
| content     | varchar |

- `tweet_id` is the **primary key**.
- `content` consists of **alphanumeric characters, '!', and spaces**.
- Tweets can have **a maximum of 15 characters** to be valid.

---

## 📊 Example 1:

### **Input:**
#### **Tweets Table**
| tweet_id | content                           |
| -------- | --------------------------------- |
| 1        | Let us Code                       |
| 2        | More than fifteen chars are here! |

### **Output:**
| tweet_id |
| -------- |
| 2        |

### **Explanation:**
- **Tweet 1** has **11 characters**, so it is **valid**.
- **Tweet 2** has **33 characters**, so it is **invalid**.

---

## 🖥 SQL Solution

### ✅ **Approach:**
1. Use the `LENGTH()` function to get the **character length** of the tweet.
2. Filter rows where **content length > 15**.
3. Return only the `tweet_id` of invalid tweets.

```sql
SELECT tweet_id
FROM Tweets
WHERE LENGTH(content) > 15;
```

---

## 📁 File Structure
```
📂 Invalid-Tweets
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/invalid-tweets/)
- 📝 [MySQL LENGTH Function](https://www.w3schools.com/sql/func_mysql_length.asp)
