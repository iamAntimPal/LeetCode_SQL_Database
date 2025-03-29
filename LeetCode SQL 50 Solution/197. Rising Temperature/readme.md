
# **197. Rising Temperature**

## **Problem Statement**
You are given a table called `Weather`, which contains daily temperature records.

### **Weather Table**
```
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| recordDate    | date    |
| temperature   | int     |
+---------------+---------+
```
- `id` is the **primary key**.
- Each row contains:
  - `recordDate`: The **date** of the temperature record.
  - `temperature`: The **temperature recorded** on that date.

### **Task:**
Find all `id`s where the **temperature** is **higher** than the **previous day's temperature**.

---

## **Example 1:**
### **Input:**
#### **Weather Table**
```
+----+------------+-------------+
| id | recordDate | temperature |
+----+------------+-------------+
| 1  | 2024-08-01 | 30          |
| 2  | 2024-08-02 | 32          |
| 3  | 2024-08-03 | 31          |
| 4  | 2024-08-04 | 35          |
| 5  | 2024-08-05 | 36          |
+----+------------+-------------+
```
### **Output:**
```
+----+
| id |
+----+
| 2  |
| 4  |
| 5  |
+----+
```
### **Explanation:**
- `id = 2`: `32 > 30` (08-02 > 08-01 ✅)
- `id = 3`: `31 < 32` (Skipped ❌)
- `id = 4`: `35 > 31` (08-04 > 08-03 ✅)
- `id = 5`: `36 > 35` (08-05 > 08-04 ✅)

---

## **Solution Approaches**

### **SQL Solution (Using `LAG()` Window Function)**
```sql
WITH PreviousWeatherData AS
(
    SELECT 
        id,
        recordDate,
        temperature, 
        LAG(temperature, 1) OVER (ORDER BY recordDate) AS PreviousTemperature,
        LAG(recordDate, 1) OVER (ORDER BY recordDate) AS PreviousRecordDate
    FROM 
        Weather
)
SELECT 
    id 
FROM 
    PreviousWeatherData
WHERE 
    temperature > PreviousTemperature
AND 
    recordDate = DATE_ADD(PreviousRecordDate, INTERVAL 1 DAY);
```
**Explanation:**
- We use `LAG()` to fetch:
  - The **previous day's temperature**.
  - The **previous day's date**.
- The `WHERE` clause filters rows where:
  - The **temperature is higher than the previous day**.
  - The **date difference is exactly 1 day**.

---

### **SQL Solution (Using Self Join)**
```sql
SELECT w1.id
FROM Weather w1
JOIN Weather w2
ON DATEDIFF(w1.recordDate, w2.recordDate) = 1
AND w1.temperature > w2.temperature;
```
**Explanation:**
- We **self-join** the `Weather` table.
- The condition `DATEDIFF(w1.recordDate, w2.recordDate) = 1` ensures:
  - We are comparing **consecutive days**.
- The condition `w1.temperature > w2.temperature` ensures:
  - We select days where the **temperature increased**.

---

### **Pandas Solution**
```python
import pandas as pd

def rising_temperature(weather: pd.DataFrame) -> pd.DataFrame:
    weather.sort_values(by="recordDate", inplace=True)
    weather["PreviousTemp"] = weather["temperature"].shift(1)
    weather["PreviousDate"] = weather["recordDate"].shift(1)
    
    result = weather[
        (weather["temperature"] > weather["PreviousTemp"]) &
        ((weather["recordDate"] - weather["PreviousDate"]).dt.days == 1)
    ]
    
    return result[["id"]]
```
**Explanation:**
- We **sort** by `recordDate`.
- We **shift** the temperature and date to get the previous day's values.
- We **filter** where:
  - Temperature **increased**.
  - Date difference is **1 day**.

---

## **File Structure**
```
📂 LeetCode197
│── 📜 problem_statement.md
│── 📜 sql_lag_solution.sql
│── 📜 sql_self_join_solution.sql
│── 📜 pandas_solution.py
│── 📜 README.md
```
- `problem_statement.md` → Contains the problem description.
- `sql_lag_solution.sql` → Contains the SQL solution using **LAG()**.
- `sql_self_join_solution.sql` → Contains the SQL solution using **Self Join**.
- `pandas_solution.py` → Contains the Pandas solution.
- `README.md` → Provides an overview of the problem and solutions.

---

## **Useful Links**
- [LeetCode Problem 197](https://leetcode.com/problems/rising-temperature/)
- [SQL LAG() Function](https://www.w3schools.com/sql/sql_ref_window_functions.asp)
- [SQL JOIN](https://www.w3schools.com/sql/sql_join.asp)
- [Pandas shift()](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.shift.html)

