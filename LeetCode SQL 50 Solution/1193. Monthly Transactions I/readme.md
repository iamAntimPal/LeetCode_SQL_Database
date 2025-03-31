# 🏦 Monthly Transactions I - LeetCode 1193

## 📌 Problem Statement
You are given the **Transactions** table that records financial transactions.

### Transactions Table
| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| country     | varchar |
| state       | enum    |
| amount      | int     |
| trans_date  | date    |

- **id** is the **primary key**.
- The **state** column is an `ENUM` type with values **"approved"** and **"declined"**.
- Each row **records a transaction** with an amount and a transaction date.

### Task:
Find **monthly statistics** for each country:
- Total **number of transactions**.
- Total **amount of transactions**.
- Total **number of approved transactions**.
- Total **amount of approved transactions**.

The **month format should be `YYYY-MM`**.

---

## 📊 Example 1:
### Input:
**Transactions Table**
| id  | country | state    | amount | trans_date |
| --- | ------- | -------- | ------ | ---------- |
| 121 | US      | approved | 1000   | 2018-12-18 |
| 122 | US      | declined | 2000   | 2018-12-19 |
| 123 | US      | approved | 2000   | 2019-01-01 |
| 124 | DE      | approved | 2000   | 2019-01-07 |

### Output:
| month   | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
| ------- | ------- | ----------- | -------------- | ------------------ | --------------------- |
| 2018-12 | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01 | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01 | DE      | 1           | 1              | 2000               | 2000                  |

### Explanation:
- **December 2018 (US)**:
  - **2 transactions** (1000 + 2000).
  - **1 approved transaction** (1000).
- **January 2019 (US)**:
  - **1 transaction** (2000).
  - **1 approved transaction** (2000).
- **January 2019 (DE)**:
  - **1 transaction** (2000).
  - **1 approved transaction** (2000).

---

## 🖥 SQL Solution

### 1️⃣ Standard MySQL Solution
#### Explanation:
- **Extract the month** from `trans_date` using `DATE_FORMAT()`.
- **Count transactions** for each `month` and `country`.
- **Sum transaction amounts**.
- **Filter only approved transactions** separately using `CASE WHEN`.

```sql
SELECT 
    DATE_FORMAT(trans_date, '%Y-%m') AS month,
    country,
    COUNT(id) AS trans_count,
    SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount
FROM Transactions
GROUP BY month, country
ORDER BY month, country;
```

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- **Extract the month (`YYYY-MM`)** from `trans_date`.
- **Group by month and country**.
- **Compute counts and sums** using `.agg()`.

```python
import pandas as pd

def monthly_transactions(transactions: pd.DataFrame) -> pd.DataFrame:
    # Extract 'YYYY-MM' from the trans_date
    transactions['month'] = transactions['trans_date'].dt.strftime('%Y-%m')

    # Aggregate transaction counts and sums
    result = transactions.groupby(['month', 'country']).agg(
        trans_count=('id', 'count'),
        approved_count=('state', lambda x: (x == 'approved').sum()),
        trans_total_amount=('amount', 'sum'),
        approved_total_amount=('amount', lambda x: x[transactions['state'] == 'approved'].sum())
    ).reset_index()

    return result.sort_values(['month', 'country'])
```

---

## 📁 File Structure
```
📂 Monthly-Transactions
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/monthly-transactions-i/)
- 📚 [SQL `GROUP BY` Clause](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/groupby.html)

## Let me know if you need any modifications! 🚀