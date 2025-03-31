# 🍽️ Restaurant Growth - LeetCode 321

## 📌 Problem Statement
You are given a table **Customer**, which records daily customer transactions in a restaurant.  
The restaurant owner wants to analyze a **7-day moving average** of customer spending.  

### 📊 Customer Table
| Column Name | Type    |
| ----------- | ------- |
| customer_id | int     |
| name        | varchar |
| visited_on  | date    |
| amount      | int     |
- **(customer_id, visited_on) is the primary key**.
- `visited_on` represents the date a customer visited the restaurant.
- `amount` represents the total amount paid by a customer on that day.

---

## 🔢 Goal:
Compute the **7-day moving average** of customer spending.  
- The window consists of **current day + 6 days before**.
- `average_amount` should be **rounded to 2 decimal places**.
- The result should be **ordered by `visited_on` in ascending order**.

---

## 📊 Example 1:
### **Input:**
#### **Customer Table**
| customer_id | name    | visited_on | amount |
| ----------- | ------- | ---------- | ------ |
| 1           | Jhon    | 2019-01-01 | 100    |
| 2           | Daniel  | 2019-01-02 | 110    |
| 3           | Jade    | 2019-01-03 | 120    |
| 4           | Khaled  | 2019-01-04 | 130    |
| 5           | Winston | 2019-01-05 | 110    |
| 6           | Elvis   | 2019-01-06 | 140    |
| 7           | Anna    | 2019-01-07 | 150    |
| 8           | Maria   | 2019-01-08 | 80     |
| 9           | Jaze    | 2019-01-09 | 110    |
| 1           | Jhon    | 2019-01-10 | 130    |
| 3           | Jade    | 2019-01-10 | 150    |

### **Output:**
| visited_on | amount | average_amount |
| ---------- | ------ | -------------- |
| 2019-01-07 | 860    | 122.86         |
| 2019-01-08 | 840    | 120            |
| 2019-01-09 | 840    | 120            |
| 2019-01-10 | 1000   | 142.86         |

### **Explanation:**
1. **First moving average (2019-01-01 to 2019-01-07)**  
   \[
   (100 + 110 + 120 + 130 + 110 + 140 + 150) / 7 = 122.86
   \]
2. **Second moving average (2019-01-02 to 2019-01-08)**  
   \[
   (110 + 120 + 130 + 110 + 140 + 150 + 80) / 7 = 120
   \]
3. **Third moving average (2019-01-03 to 2019-01-09)**  
   \[
   (120 + 130 + 110 + 140 + 150 + 80 + 110) / 7 = 120
   \]
4. **Fourth moving average (2019-01-04 to 2019-01-10)**  
   \[
   (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150) / 7 = 142.86
   \]

---

## 🖥 SQL Solutions

### 1️⃣ **Using `WINDOW FUNCTION` (`SUM() OVER` + `RANK() OVER`)**
#### **Explanation:**
- First, **group transactions per day** using `SUM(amount)`.
- Then, use `SUM() OVER (ROWS 6 PRECEDING)` to calculate **moving sum** over 7 days.
- Use `RANK()` to track row numbers and filter rows with `rk > 6`.
- Finally, compute `ROUND(amount / 7, 2)`.

```sql
WITH t AS (
    SELECT 
        visited_on, 
        SUM(amount) OVER (
            ORDER BY visited_on 
            ROWS 6 PRECEDING
        ) AS amount,
        RANK() OVER (
            ORDER BY visited_on 
            ROWS 6 PRECEDING
        ) AS rk
    FROM (
        SELECT visited_on, SUM(amount) AS amount
        FROM Customer
        GROUP BY visited_on
    ) AS tt
)
SELECT visited_on, amount, ROUND(amount / 7, 2) AS average_amount
FROM t
WHERE rk > 6;
```

---

### 2️⃣ **Using `JOIN` + `DATEDIFF()`**
#### **Explanation:**
- Use a **self-join** to find transactions **within a 7-day range**.
- Sum the `amount` for each window and calculate the moving average.
- Use `DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6` to filter records.
- Ensure only complete 7-day windows are included.

```sql
SELECT 
    a.visited_on,
    SUM(b.amount) AS amount,
    ROUND(SUM(b.amount) / 7, 2) AS average_amount
FROM 
    (SELECT DISTINCT visited_on FROM customer) AS a
    JOIN customer AS b 
    ON DATEDIFF(a.visited_on, b.visited_on) BETWEEN 0 AND 6
WHERE 
    a.visited_on >= (SELECT MIN(visited_on) FROM customer) + 6
GROUP BY a.visited_on
ORDER BY a.visited_on;
```

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
- **Group by `visited_on`** and sum `amount` per day.
- **Use `.rolling(7).sum()`** to compute the moving sum over 7 days.
- **Drop NaN values** to exclude incomplete windows.
- **Round the average to 2 decimal places**.

```python
import pandas as pd

def restaurant_growth(customers: pd.DataFrame) -> pd.DataFrame:
    # Aggregate daily amounts
    daily_amount = customers.groupby("visited_on")["amount"].sum().reset_index()

    # Compute rolling 7-day sum and moving average
    daily_amount["amount"] = daily_amount["amount"].rolling(7).sum()
    daily_amount["average_amount"] = (daily_amount["amount"] / 7).round(2)

    # Drop incomplete windows
    daily_amount = daily_amount.dropna().reset_index(drop=True)

    return daily_amount
```

---

## 📁 File Structure
```
📂 Restaurant-Growth
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/restaurant-growth/)
- 📚 [SQL `WINDOW FUNCTIONS` Documentation](https://www.w3schools.com/sql/sql_window.asp)
- 🐍 [Pandas Rolling Window](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.rolling.html)
