# **550. Game Play Analysis IV**

## **Problem Statement**
You are given a table named `Activity`, which logs the gaming activity of players.

### **Activity Table**
```rb
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
```
- **(player_id, event_date)** is the **primary key**.
- Each row contains:
  - `player_id`: The ID of the player.
  - `event_date`: The date when the player logged in.
  - `games_played`: The number of games played before logging out.

### **Task:**
Find the **fraction** of players who logged in **again** the day after their **first login date**, rounded to **2 decimal places**.

---

## **Example 1:**
### **Input:**
#### **Activity Table**
```rb
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
```
### **Output:**
```rb
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
```
### **Explanation:**
- `player_id = 1`: First login on **2016-03-01**, logs in again on **2016-03-02** ✅
- `player_id = 2`: First login on **2017-06-25**, no next-day login ❌
- `player_id = 3`: First login on **2016-03-02**, no next-day login ❌

Total players = **3**, Players who logged in the next day = **1** → **1 / 3 = 0.33** ✅

---

## **Solution Approaches**

### **SQL Solution (Using `JOIN` & `DATEDIFF`)**
```sql
SELECT 
    ROUND((
        SELECT COUNT(DISTINCT a.player_id)
        FROM Activity a
        INNER JOIN (
            SELECT player_id, MIN(event_date) AS first_login
            FROM Activity
            GROUP BY player_id
        ) b
        ON a.player_id = b.player_id
        AND DATEDIFF(a.event_date, b.first_login) = 1
    ) / 
    (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction;
```
**Explanation:**
1. **Find First Login Date per Player**
   - `MIN(event_date) AS first_login`
   - **Grouped by** `player_id`
2. **Find Players Who Logged in on the Next Day**
   - **Join** the table with itself.
   - Use `DATEDIFF(a.event_date, b.first_login) = 1` to check next-day logins.
   - Count unique `player_id`s.
3. **Calculate Fraction**
   - Divide by total distinct `player_id`s.
   - Round to **2 decimal places**.

---

### **Alternative SQL Solution (Using `EXISTS`)**
```sql
SELECT ROUND(
    (SELECT COUNT(DISTINCT player_id) 
     FROM Activity a
     WHERE EXISTS (
         SELECT 1 FROM Activity b
         WHERE a.player_id = b.player_id 
         AND DATEDIFF(b.event_date, a.event_date) = 1
     )) / 
    (SELECT COUNT(DISTINCT player_id) FROM Activity), 2) AS fraction;
```
**Explanation:**
- Checks if a player has **ANY** login exactly **one day after**.
- Uses `EXISTS` to optimize performance.

---

### **Pandas Solution**
```python
import pandas as pd

def game_play_analysis(activity: pd.DataFrame) -> pd.DataFrame:
    # Get first login date for each player
    first_login = activity.groupby("player_id")["event_date"].min().reset_index()
    first_login.columns = ["player_id", "first_login"]
    
    # Merge first login date with original table
    merged = activity.merge(first_login, on="player_id")
    
    # Filter players who logged in the next day
    next_day_logins = merged[
        (merged["event_date"] - merged["first_login"]).dt.days == 1
    ]["player_id"].nunique()
    
    # Total unique players
    total_players = activity["player_id"].nunique()
    
    # Calculate fraction
    fraction = round(next_day_logins / total_players, 2)
    
    return pd.DataFrame({"fraction": [fraction]})
```
**Explanation:**
1. **Find First Login Date**
   - Group by `player_id`, get `min(event_date)`.
2. **Merge with Original Table**
   - Check if `event_date - first_login = 1 day`.
3. **Count Unique Players**
   - Divide by total unique `player_id`s.

---

## **File Structure**
```
📂 LeetCode550
│── 📜 problem_statement.md
│── 📜 sql_solution.sql
│── 📜 sql_exists_solution.sql
│── 📜 pandas_solution.py
│── 📜 README.md
```
- `problem_statement.md` → Contains the problem description.
- `sql_solution.sql` → SQL solution using **JOIN & DATEDIFF**.
- `sql_exists_solution.sql` → SQL solution using **EXISTS**.
- `pandas_solution.py` → Pandas solution.
- `README.md` → Overview of problem and solutions.

---

## **Useful Links**
- [LeetCode Problem 550](https://leetcode.com/problems/game-play-analysis-iv/)
- [SQL `DATEDIFF()`](https://www.w3schools.com/sql/func_mysql_datediff.asp)
- [Pandas `.groupby()`](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
