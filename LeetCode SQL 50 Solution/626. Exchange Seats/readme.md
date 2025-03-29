# **626. Exchange Seats**

## **Problem Statement**
You are given a table `Seat` that contains the seat IDs and names of students. The seat IDs are assigned consecutively starting from 1.

### **Seat Table**
```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
```
- `id` is the **primary key** (unique value).
- Each row represents a student and their assigned seat.
- The `id` sequence always starts from 1 and increments continuously.

### **Task:**
Swap the seat `id` of every two consecutive students.  
- If the number of students is odd, the `id` of the last student remains unchanged.
- Return the result table ordered by `id` in ascending order.

---

## **Example 1:**

### **Input:**
```
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
```

### **Output:**
```
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
```

### **Explanation:**
- Swap the seat assignments of every two consecutive students:
  - Seats 1 and 2: **Abbot** and **Doris** swap positions.
  - Seats 3 and 4: **Emerson** and **Green** swap positions.
  - Since the number of students is odd, **Jeames** (seat 5) remains in the same seat.

---

## **Solution Approaches**

### **SQL Solution**
```sql
SELECT 
    CASE 
        WHEN id % 2 != 0 AND id != counts THEN id + 1
        WHEN id % 2 != 0 AND id = counts THEN id
        ELSE id - 1
    END AS id, 
    student
FROM Seat, (SELECT COUNT(*) AS counts FROM Seat) AS seat_counts
ORDER BY id ASC;
```
**Explanation:**
- The subquery `(SELECT COUNT(*) AS counts FROM Seat)` computes the total number of students.
- The `CASE` statement swaps IDs:
  - For odd `id` (except the last one if the count is odd), we add 1.
  - For even `id`, we subtract 1.
  - For the last student in an odd-length list, we leave the `id` unchanged.
- The results are then ordered by the new `id` in ascending order.

---

### **Pandas Solution**
```python
import pandas as pd

def exchange_seats(seat: pd.DataFrame) -> pd.DataFrame:
    # Total number of students
    total = seat.shape[0]
    
    # Function to compute the new seat id
    def new_id(row):
        # For odd id values:
        if row['id'] % 2 != 0:
            # If it's the last row in an odd-length list, do not change the id.
            if row['id'] == total:
                return row['id']
            else:
                return row['id'] + 1
        # For even id values, swap with previous odd id
        else:
            return row['id'] - 1
    
    # Apply the new_id function to each row
    seat['new_id'] = seat.apply(new_id, axis=1)
    
    # Sort by the new seat id and select the desired columns
    result = seat.sort_values('new_id')[['new_id', 'student']].rename(columns={'new_id': 'id'})
    
    return result.reset_index(drop=True)

# Example usage:
# data = {'id': [1, 2, 3, 4, 5], 'student': ['Abbot', 'Doris', 'Emerson', 'Green', 'Jeames']}
# df = pd.DataFrame(data)
# print(exchange_seats(df))
```
**Explanation:**
- The solution calculates the total number of rows.
- A helper function `new_id` computes the new seat id:
  - For odd `id`s (except the last one), add 1.
  - For even `id`s, subtract 1.
  - Leave the last seat unchanged if the count is odd.
- The DataFrame is sorted by the new `id`, and the result is returned.

---

## **File Structure**
```
LeetCode626/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 626](https://leetcode.com/problems/exchange-seats/)
- [SQL CASE Statement Documentation](https://www.w3schools.com/sql/sql_case.asp)
- [Pandas apply() Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html)
- [Pandas DataFrame Sorting](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.sort_values.html)

