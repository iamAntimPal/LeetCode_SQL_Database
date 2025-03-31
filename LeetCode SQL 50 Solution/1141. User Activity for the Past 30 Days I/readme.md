
# 📊 User Activity for the Past 30 Days I - LeetCode 1141

## 📌 Problem Statement
You are given the **Activity** table that records user activities on a social media website.

### Activity Table
| Column Name   | Type |
| ------------- | ---- |
| user_id       | int  |
| session_id    | int  |
| activity_date | date |
| activity_type | enum |

- The `activity_type` column is an ENUM of **('open_session', 'end_session', 'scroll_down', 'send_message')**.
- Each session belongs to exactly **one user**.
- The table **may have duplicate rows**.

### Task:
Find the **daily active user count** for a period of **30 days ending 2019-07-27 inclusively**.
- A user is considered **active on a given day** if they made at least **one activity**.
- Ignore days with **zero active users**.

---

## 📊 Example 1:
### Input:
**Activity Table**
| user_id | session_id | activity_date | activity_type |
| ------- | ---------- | ------------- | ------------- |
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |

### Output:
| day        | active_users |
| ---------- | ------------ |
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |

### Explanation:
- **2019-07-20**: Users **1 and 2** were active.
- **2019-07-21**: Users **2 and 3** were active.
- **Days with zero active users are ignored**.

---

## 🖥 SQL Solutions

### 1️⃣ Standard MySQL Solution
#### Explanation:
- **Filter records** for the last **30 days** (ending on `2019-07-27`).
- Use `COUNT(DISTINCT user_id)` to count **unique active users per day**.
- Ignore **days with zero active users**.

```sql
SELECT 
    activity_date AS day, 
    COUNT(DISTINCT user_id) AS active_users
FROM 
    Activity
WHERE 
    DATEDIFF('2019-07-27', activity_date) < 30 
    AND DATEDIFF('2019-07-27', activity_date) >= 0
GROUP BY activity_date;
```

---

### 2️⃣ Alternative Solution Using `BETWEEN`
#### Explanation:
- This solution filters the date range using `BETWEEN` instead of `DATEDIFF`.

```sql
SELECT 
    activity_date AS day, 
    COUNT(DISTINCT user_id) AS active_users
FROM 
    Activity
WHERE 
    activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;
```

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- Filter activity records for the **last 30 days**.
- **Group by `activity_date`** and count **unique `user_id`s**.
- **Ignore days with zero active users**.

```python
import pandas as pd

def daily_active_users(activity: pd.DataFrame) -> pd.DataFrame:
    # Filter data within the last 30 days (ending on '2019-07-27')
    filtered = activity[(activity["activity_date"] >= "2019-06-28") & (activity["activity_date"] <= "2019-07-27")]

    # Group by day and count unique users
    result = filtered.groupby("activity_date")["user_id"].nunique().reset_index()

    # Rename columns
    result.columns = ["day", "active_users"]
    return result
```

---

## 📁 File Structure
```
📂 User-Activity-Past-30-Days
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_between.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/user-activity-for-the-past-30-days-i/)
- 📚 [SQL Date Functions](https://www.w3schools.com/sql/sql_dates.asp)
- 🐍 [Pandas Documentation](https://pandas.pydata.org/docs/)

## Let me know if you need any changes! 🚀