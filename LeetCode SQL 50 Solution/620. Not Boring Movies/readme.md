# **620. Not Boring Movies**

## **Problem Statement**
You are given a table `Cinema` that contains information about movies, their descriptions, and ratings.

### **Cinema Table**
```
+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| id             | int      |
| movie          | varchar  |
| description    | varchar  |
| rating         | float    |
+----------------+----------+
```
- `id` is the **primary key**.
- Each row provides details about a movie:
  - `id`: The movie's unique identifier.
  - `movie`: The name of the movie.
  - `description`: The description or genre of the movie.
  - `rating`: A float representing the movie's rating (in the range [0, 10] with 2 decimal places).

### **Task:**
Write a solution to report the movies that have:
- An **odd-numbered `id`**.
- A `description` that is **not "boring"**.

Return the result table **ordered by rating in descending order**.

---

## **Example 1:**

### **Input:**
#### **Cinema Table**
```
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 1  | War        | great 3D    | 8.9    |
| 2  | Science    | fiction     | 8.5    |
| 3  | irish      | boring      | 6.2    |
| 4  | Ice song   | Fantacy     | 8.6    |
| 5  | House card | Interesting | 9.1    |
+----+------------+-------------+--------+
```

### **Output:**
```
+----+------------+-------------+--------+
| id | movie      | description | rating |
+----+------------+-------------+--------+
| 5  | House card | Interesting | 9.1    |
| 1  | War        | great 3D    | 8.9    |
+----+------------+-------------+--------+
```

### **Explanation:**
- Movies with **odd-numbered IDs**: `1`, `3`, and `5`.
- Excluding movie with `id = 3` because its description is `"boring"`.
- Sorting the remaining movies by `rating` in descending order gives the result.

---

## **Solution Approaches**

### **SQL Solution**
```sql
SELECT * 
FROM Cinema 
WHERE id % 2 = 1 
  AND description != 'boring'
ORDER BY rating DESC;
```
**Explanation:**
- The query filters movies where the `id` is odd (`id % 2 = 1`) and the `description` is not `"boring"`.
- The results are ordered by `rating` in descending order.

---

### **Pandas Solution**
```python
import pandas as pd

def not_boring_movies(cinema: pd.DataFrame) -> pd.DataFrame:
    # Filter movies with odd-numbered id and description not equal to 'boring'
    result = cinema[(cinema['id'] % 2 == 1) & (cinema['description'] != 'boring')]
    # Sort the result by rating in descending order
    return result.sort_values(by='rating', ascending=False)

# Example usage:
# cinema_df = pd.read_csv('cinema.csv')
# print(not_boring_movies(cinema_df))
```
**Explanation:**
- The Pandas solution filters the DataFrame to include only rows where the `id` is odd and the `description` is not `"boring"`.
- It then sorts the filtered results by `rating` in descending order.

---

## **File Structure**
```
LeetCode620/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution for Python users.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 620](https://leetcode.com/problems/not-boring-movies/)
- [SQL WHERE Clause Documentation](https://www.w3schools.com/sql/sql_where.asp)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

