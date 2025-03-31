# 🏬 Customer Who Visited but Did Not Make Any Transactions - LeetCode 1581

## 📌 Problem Statement
You are given two tables, **Visits** and **Transactions**.

- The **Visits** table records the customers who visited the mall.
- The **Transactions** table records the **transactions made** during a visit.

Your task is to **find customers who visited but did not make any transactions**.  
Also, return the **number of times** these customers **visited without making any transactions**.

Return the result **in any order**.

---

## 📊 Table Structure

### **Visits Table**
| Column Name | Type |
| ----------- | ---- |
| visit_id    | int  |
| customer_id | int  |

- `visit_id` is the **unique identifier** for each visit.

### **Transactions Table**
| Column Name    | Type |
| -------------- | ---- |
| transaction_id | int  |
| visit_id       | int  |
| amount         | int  |

- `transaction_id` is the **unique identifier** for each transaction.
- `visit_id` represents the visit **associated with this transaction**.

---

## 📊 Example 1:

### **Input:**
#### **Visits Table**
| visit_id | customer_id |
| -------- | ----------- |
| 1        | 23          |
| 2        | 9           |
| 4        | 30          |
| 5        | 54          |
| 6        | 96          |
| 7        | 54          |
| 8        | 54          |

#### **Transactions Table**
| transaction_id | visit_id | amount |
| -------------- | -------- | ------ |
| 2              | 5        | 310    |
| 3              | 5        | 300    |
| 9              | 5        | 200    |
| 12             | 1        | 910    |
| 13             | 2        | 970    |

### **Output:**
| customer_id | count_no_trans |
| ----------- | -------------- |
| 54          | 2              |
| 30          | 1              |
| 96          | 1              |

### **Explanation:**
- ✅ **Customer 23:** Visited **once**, made **1 transaction** → ❌ Not included  
- ✅ **Customer 9:** Visited **once**, made **1 transaction** → ❌ Not included  
- ✅ **Customer 30:** Visited **once**, made **0 transactions** → ✅ Included (`count_no_trans = 1`)  
- ✅ **Customer 54:** Visited **3 times**, made **transactions in 1 visit**, **but 2 visits had no transactions** → ✅ Included (`count_no_trans = 2`)  
- ✅ **Customer 96:** Visited **once**, made **0 transactions** → ✅ Included (`count_no_trans = 1`)  

---

## 🖥 SQL Solution

### ✅ **Using `NOT IN` to Find Visits Without Transactions**
#### **Explanation:**
- First, **find all visit IDs** that **had at least one transaction** (`SELECT DISTINCT visit_id FROM Transactions`).
- Then, filter out these visit IDs from the **Visits** table.
- Finally, count the number of such visits **per customer**.

```sql
SELECT customer_id, COUNT(*) AS count_no_trans
FROM Visits
WHERE visit_id NOT IN (SELECT DISTINCT visit_id FROM Transactions)
GROUP BY customer_id;
```

---

## 📁 File Structure
```
📂 Customer-No-Transaction
│── 📜 README.md
│── 📜 solution.sql
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/customer-who-visited-but-did-not-make-any-transactions/)
- 🔍 [SQL NOT IN Operator](https://www.w3schools.com/sql/sql_in.asp)
- 📝 [MySQL Aggregate Functions](https://dev.mysql.com/doc/refman/8.0/en/group-by-functions.html)
