# 📩 Confirmation Rate - LeetCode 1934

## 📌 Problem Statement
You are given two tables: **Signups** and **Confirmations**.

- The **Signups** table contains the signup time for each user.
- The **Confirmations** table records each confirmation request made by a user along with the outcome (either `'confirmed'` or `'timeout'`).

The **confirmation rate** for a user is defined as:
\[
\text{confirmation rate} = \frac{\text{Number of confirmed messages}}{\text{Total number of confirmation requests}}
\]
If a user did not request any confirmation messages, their confirmation rate is defined as 0.

Your task is to calculate the confirmation rate for each user and round it to two decimal places.

Return the result table in **any order**.

---

## 📊 Table Structure

### **Signups Table**
| Column Name | Type     |
| ----------- | -------- |
| user_id     | int      |
| time_stamp  | datetime |

- `user_id` is unique for each user.

### **Confirmations Table**
| Column Name | Type     |
| ----------- | -------- |
| user_id     | int      |
| time_stamp  | datetime |
| action      | ENUM     |

- `(user_id, time_stamp)` is the primary key.
- `action` is either `'confirmed'` or `'timeout'`.
- `user_id` in Confirmations is a foreign key to Signups.

---

## 📊 Example 1:

### **Input:**
#### **Signups Table**
| user_id | time_stamp          |
| ------- | ------------------- |
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |

#### **Confirmations Table**
| user_id | time_stamp          | action    |
| ------- | ------------------- | --------- |
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |

### **Output:**
| user_id | confirmation_rate |
| ------- | ----------------- |
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |

### **Explanation:**
- **User 6** did not request any confirmation messages, so the rate is **0.00**.
- **User 3** made 2 requests; both were timeouts, so the rate is **0.00**.
- **User 7** made 3 requests; all were confirmed, so the rate is **1.00**.
- **User 2** made 2 requests; 1 confirmed and 1 timeout, so the rate is **0.50**.

---

## 🖥 SQL Solutions

### ✅ **Solution 1: Using Shorthand Boolean Expressions**
#### **Explanation:**
- `SUM(action = 'confirmed')` counts the number of rows where the action is `'confirmed'` (in MySQL, boolean expressions return 1 if true, 0 if false).
- `COUNT(1)` counts all confirmation requests.
- We use a `LEFT JOIN` between **Signups** and **Confirmations** so that users without any confirmation requests are included (their rate becomes 0).
- `IFNULL` is used to handle cases where a user has no confirmation requests.

```sql
SELECT
    user_id,
    ROUND(IFNULL(SUM(action = 'confirmed') / COUNT(1), 0), 2) AS confirmation_rate
FROM Signups
LEFT JOIN Confirmations USING (user_id)
GROUP BY user_id;
```

### ✅ **Solution 2: Using a CASE Statement**
#### **Explanation:**
- The `CASE` statement explicitly counts 1 for `'confirmed'` actions and 0 otherwise.
- The rest of the query logic remains similar.

```sql
SELECT
    user_id,
    ROUND(IFNULL(SUM(CASE WHEN action = 'confirmed' THEN 1 ELSE 0 END) / COUNT(1), 0), 2) AS confirmation_rate
FROM Signups
LEFT JOIN Confirmations USING (user_id)
GROUP BY user_id;
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. **Merge** the **Signups** and **Confirmations** DataFrames on `user_id` using a left join, so that all users are included.
2. **Count** the total number of confirmation requests and the number of confirmed requests for each user.
3. **Calculate** the confirmation rate as the number of confirmed requests divided by the total requests.
4. **Handle** users with no confirmation requests by setting their rate to 0.
5. **Round** the confirmation rate to two decimal places.

```python
import pandas as pd

def confirmation_rate(signups: pd.DataFrame, confirmations: pd.DataFrame) -> pd.DataFrame:
    # Merge the dataframes to include all users from signups
    merged = pd.merge(signups, confirmations, on='user_id', how='left')
    
    # Group by user_id and calculate total requests and confirmed requests
    summary = merged.groupby('user_id').agg(
        total_requests=('action', 'count'),
        confirmed_requests=('action', lambda x: (x == 'confirmed').sum())
    ).reset_index()
    
    # Calculate confirmation rate; if total_requests is 0, rate is 0.
    summary['confirmation_rate'] = summary.apply(
        lambda row: round(row['confirmed_requests'] / row['total_requests'], 2) if row['total_requests'] > 0 else 0.00,
        axis=1
    )
    
    # Select the relevant columns
    result = summary[['user_id', 'confirmation_rate']]
    return result

# Example usage:
# signups_df = pd.read_csv("signups.csv")
# confirmations_df = pd.read_csv("confirmations.csv")
# print(confirmation_rate(signups_df, confirmations_df))
```

---

## 📁 File Structure
```
📂 Confirmation-Rate
│── README.md
│── solution.sql
│── solution_pandas.py
│── test_cases.sql
│── sample_signups.csv
│── sample_confirmations.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/confirmation-rate/)
- 📝 [MySQL IFNULL Function](https://www.w3schools.com/sql/func_mysql_ifnull.asp)
- 🔍 [MySQL ROUND Function](https://www.w3schools.com/sql/func_mysql_round.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
