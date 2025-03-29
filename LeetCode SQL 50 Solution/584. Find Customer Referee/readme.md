# **584. Find Customer Referee**

## **Problem Statement**
You are given a table `Customer` that stores customer details along with the ID of the customer who referred them.

### **Customer Table**
```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| referee_id  | int     |
+-------------+---------+
```
- `id` is the **primary key**.
- Each row represents a customer with their `id`, `name`, and `referee_id`.
- `referee_id` indicates the customer who referred them. It can be **NULL** if no one referred the customer.

### **Task:**
Find the names of the customers who are **not referred** by the customer with `id = 2`.

---

## **Example 1:**

### **Input:**
#### **Customer Table**
```
+----+------+------------+
| id | name | referee_id |
+----+------+------------+
| 1  | Will | null       |
| 2  | Jane | null       |
| 3  | Alex | 2          |
| 4  | Bill | null       |
| 5  | Zack | 1          |
| 6  | Mark | 2          |
+----+------+------------+
```

### **Output:**
```
+------+
| name |
+------+
| Will |
| Jane |
| Bill |
| Zack |
+------+
```

### **Explanation:**
- **Alex** (id = 3) and **Mark** (id = 6) are referred by the customer with `id = 2` and are excluded.
- The remaining customers (**Will**, **Jane**, **Bill**, **Zack**) are not referred by the customer with `id = 2`.

---

## **Solution Approaches**

### **SQL Solution (Using WHERE Clause)**
```sql
SELECT name
FROM Customer
WHERE referee_id != 2 OR referee_id IS NULL;
```
**Explanation:**
- The query selects customer names where `referee_id` is either not equal to `2` or is `NULL`.
- This effectively filters out customers referred by the customer with `id = 2`.

---

### **Pandas Solution**
```python
import pandas as pd

def find_customer_referee(customer: pd.DataFrame) -> pd.DataFrame:
    # Filter rows where referee_id is not equal to 2 or is null
    result = customer[(customer['referee_id'] != 2) | (customer['referee_id'].isnull())][['name']]
    return result
```
**Explanation:**
- The Pandas solution filters the DataFrame for rows where `referee_id` is not 2 or is `NaN`.
- It then returns the `name` column containing the desired customer names.

---

## **File Structure**
```
LeetCode584/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and solutions.
```

---

## **Useful Links**
- [LeetCode Problem 584](https://leetcode.com/problems/find-customer-referee/)
- [SQL WHERE Clause Documentation](https://www.w3schools.com/sql/sql_where.asp)
- [Pandas Filtering DataFrames](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.html)

