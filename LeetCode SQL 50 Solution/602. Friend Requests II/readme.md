# **602. Friend Requests II: Who Has the Most Friends**

## **Problem Statement**
You are given a table `RequestAccepted` that records friend request acceptances between users.

### **RequestAccepted Table**
```
+--------------+-------------+-------------+
| Column Name  | Type        |
+--------------+-------------+
| requester_id | int         |
| accepter_id  | int         |
| accept_date  | date        |
+--------------+-------------+
```
- **(requester_id, accepter_id)** is the **primary key**.
- Each row indicates the user who sent a friend request (`requester_id`), the user who accepted it (`accepter_id`), and the date when the request was accepted.

### **Task:**
Find the person who has the **most friends** along with the number of friends they have.  
*Note:* The test cases are generated so that only one person has the most friends.

---

## **Example 1:**

### **Input:**
#### **RequestAccepted Table**
```
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
```

### **Output:**
```
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
```

### **Explanation:**
- User with `id = 3` is friends with users 1, 2, and 4, making a total of **3 friends**—the highest among all users.

---

## **Solution Approaches**

### **SQL Solution (Using UNION ALL)**
```sql
WITH T AS (
    SELECT requester_id, accepter_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id, requester_id FROM RequestAccepted
)
SELECT requester_id AS id, COUNT(*) AS num
FROM T
GROUP BY requester_id
ORDER BY num DESC
LIMIT 1;
```
**Explanation:**
- The CTE `T` creates a complete friendship list by combining both directions of the friend relationship.
- The outer query groups by `requester_id` (which now represents a user) and counts the number of occurrences (i.e., friends).
- The result is ordered by the friend count in descending order and limited to one row, returning the user with the most friends.

---

### **Pandas Solution**
```python
import pandas as pd

def most_friends(requests: pd.DataFrame) -> pd.DataFrame:
    # Create a DataFrame that contains all friend relationships in both directions
    friend_df = pd.concat([
        requests[['requester_id', 'accepter_id']].rename(columns={'requester_id': 'id', 'accepter_id': 'friend'}),
        requests[['accepter_id', 'requester_id']].rename(columns={'accepter_id': 'id', 'requester_id': 'friend'})
    ])
    
    # Count number of friends for each user
    friend_counts = friend_df.groupby('id').size().reset_index(name='num')
    
    # Get the user with the most friends
    max_friends = friend_counts.loc[friend_counts['num'].idxmax()]
    
    return pd.DataFrame({'id': [max_friends['id']], 'num': [max_friends['num']]})

# Example usage:
# requests_df = pd.read_csv('request_accepted.csv')
# print(most_friends(requests_df))
```
**Explanation:**
- The solution concatenates two DataFrames to consider friend relationships in both directions.
- It then groups by user `id` and counts the number of friends.
- The user with the maximum friend count is selected and returned.

---

## **File Structure**
```
LeetCode602/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution using UNION ALL.
├── pandas_solution.py         # Contains the Pandas solution for Python users.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 602](https://leetcode.com/problems/friend-requests-ii-who-has-the-most-friends/)
- [SQL UNION ALL Documentation](https://www.w3schools.com/sql/sql_union.asp)
- [Pandas concat Documentation](https://pandas.pydata.org/docs/reference/api/pandas.concat.html)
- [Pandas groupby Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
