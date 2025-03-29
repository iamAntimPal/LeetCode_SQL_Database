

# **585. Investments in 2016**

## **Problem Statement**
You are given a table `Insurance` that contains details about policy investments.

### **Insurance Table**
```
+-------------+-------+
| Column Name | Type  |
+-------------+-------+
| pid         | int   |
| tiv_2015    | float |
| tiv_2016    | float |
| lat         | float |
| lon         | float |
+-------------+-------+
```
- `pid` is the **primary key**.
- `tiv_2015` is the total investment value in **2015**.
- `tiv_2016` is the total investment value in **2016**.
- `lat` and `lon` represent the **latitude** and **longitude** of the policyholder's city. Both values are guaranteed not to be `NULL`.

### **Task:**
Report the **sum** of all `tiv_2016` values (rounded to two decimal places) for all policyholders who:
1. Have the **same `tiv_2015`** value as one or more other policyholders.
2. Are **not located** in the same city as any other policyholder (i.e., the `(lat, lon)` attribute pair is **unique**).

---

## **Example 1:**

### **Input:**
#### **Insurance Table**
```
+-----+----------+----------+-----+-----+
| pid | tiv_2015 | tiv_2016 | lat | lon |
+-----+----------+----------+-----+-----+
| 1   | 10       | 5        | 10  | 10  |
| 2   | 20       | 20       | 20  | 20  |
| 3   | 10       | 30       | 20  | 20  |
| 4   | 10       | 40       | 40  | 40  |
+-----+----------+----------+-----+-----+
```

### **Output:**
```
+----------+
| tiv_2016 |
+----------+
| 45.00    |
+----------+
```

### **Explanation:**
- The policyholders with `tiv_2015 = 10` appear in multiple rows.
- Among these, only the records with **unique locations** count.
- Policy `pid = 1` and `pid = 4` meet both criteria, so the result is the sum of their `tiv_2016`: **5 + 40 = 45.00**.

---

## **Solution Approaches**

### **SQL Solution (Using Window Functions)**
```sql
WITH InsuranceWithCounts AS (
    SELECT
        tiv_2016,
        COUNT(*) OVER(PARTITION BY tiv_2015) AS tiv_2015_count,
        COUNT(*) OVER(PARTITION BY lat, lon) AS city_count
    FROM Insurance
)
SELECT ROUND(SUM(tiv_2016), 2) AS tiv_2016
FROM InsuranceWithCounts
WHERE tiv_2015_count > 1
  AND city_count = 1;
```
**Explanation:**
- The CTE `InsuranceWithCounts` computes:
  - `tiv_2015_count`: Number of records with the same `tiv_2015`.
  - `city_count`: Number of records with the same `(lat, lon)` pair.
- The outer query filters rows where:
  - `tiv_2015_count > 1` (i.e., policyholders share their 2015 investment value with others).
  - `city_count = 1` (i.e., their location is unique).
- Finally, it sums `tiv_2016` and rounds the result to 2 decimal places.

---

### **Pandas Solution**
```python
import pandas as pd

def investments_in_2016(insurance: pd.DataFrame) -> pd.DataFrame:
    # Count the number of occurrences for each tiv_2015 value
    insurance['tiv_2015_count'] = insurance.groupby('tiv_2015')['tiv_2015'].transform('count')
    
    # Count the number of occurrences for each (lat, lon) pair
    insurance['city_count'] = insurance.groupby(['lat', 'lon'])['lat'].transform('count')
    
    # Filter rows that meet both criteria:
    # 1. tiv_2015 appears more than once.
    # 2. The location (lat, lon) is unique (appears only once).
    valid_rows = insurance[(insurance['tiv_2015_count'] > 1) & (insurance['city_count'] == 1)]
    
    # Calculate the sum of tiv_2016 and round to 2 decimal places
    total_tiv_2016 = round(valid_rows['tiv_2016'].sum(), 2)
    
    # Return result as a DataFrame
    return pd.DataFrame({'tiv_2016': [total_tiv_2016]})

# Example usage:
# df = pd.read_csv('insurance.csv')
# print(investments_in_2016(df))
```
**Explanation:**
- The code computes two new columns:
  - `tiv_2015_count` for the number of policyholders with the same 2015 investment.
  - `city_count` for the count of policyholders in each unique city (using `(lat, lon)`).
- Rows that meet the conditions are filtered.
- The `tiv_2016` values of the valid rows are summed and rounded to 2 decimal places.
- The result is returned as a DataFrame.

---

## **File Structure**
```
LeetCode585/
├── problem_statement.md        # Contains the problem description and constraints.
├── sql_solution.sql            # SQL solution using window functions.
├── pandas_solution.py          # Pandas solution for Python users.
├── README.md                   # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 585](https://leetcode.com/problems/investments-in-2016/)
- [SQL Window Functions](https://www.w3schools.com/sql/sql_window.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
- [Pandas Transform Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.transform.html)
