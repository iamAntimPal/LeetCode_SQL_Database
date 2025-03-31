# 🎬 Movie Rating - LeetCode 1341

## 📌 Problem Statement
You are given three tables: **Movies**, **Users**, and **MovieRating**.  

Your task is to:
1. Find the **user who has rated the greatest number of movies**.  
   - In case of a tie, return the **lexicographically smaller** name.  
2. Find the **movie with the highest average rating** in **February 2020**.  
   - In case of a tie, return the **lexicographically smaller** movie title.

---

## 📊 Table Structure

### **Movies Table**
| Column Name | Type    |
| ----------- | ------- |
| movie_id    | int     |
| title       | varchar |

- `movie_id` is the **primary key** (unique identifier).
- `title` is the **name of the movie**.

---

### **Users Table**
| Column Name | Type    |
| ----------- | ------- |
| user_id     | int     |
| name        | varchar |

- `user_id` is the **primary key** (unique identifier).
- `name` is **unique** for each user.

---

### **MovieRating Table**
| Column Name | Type |
| ----------- | ---- |
| movie_id    | int  |
| user_id     | int  |
| rating      | int  |
| created_at  | date |

- `(movie_id, user_id)` is the **primary key** (ensuring unique user-movie ratings).
- `created_at` represents the **review date**.

---

## 🔢 Goal:
- Return a **single-column result** containing:
  1. **User name** with the most ratings.
  2. **Movie title** with the highest **average rating** in **February 2020**.

---

## 📊 Example 1:
### **Input:**
#### **Movies Table**
| movie_id | title    |
| -------- | -------- |
| 1        | Avengers |
| 2        | Frozen 2 |
| 3        | Joker    |

#### **Users Table**
| user_id | name   |
| ------- | ------ |
| 1       | Daniel |
| 2       | Monica |
| 3       | Maria  |
| 4       | James  |

#### **MovieRating Table**
| movie_id | user_id | rating | created_at |
| -------- | ------- | ------ | ---------- |
| 1        | 1       | 3      | 2020-01-12 |
| 1        | 2       | 4      | 2020-02-11 |
| 1        | 3       | 2      | 2020-02-12 |
| 1        | 4       | 1      | 2020-01-01 |
| 2        | 1       | 5      | 2020-02-17 |
| 2        | 2       | 2      | 2020-02-01 |
| 2        | 3       | 2      | 2020-03-01 |
| 3        | 1       | 3      | 2020-02-22 |
| 3        | 2       | 4      | 2020-02-25 |

### **Output:**
| results  |
| -------- |
| Daniel   |
| Frozen 2 |

### **Explanation:**
- **Most Active User:**  
  - `Daniel` and `Monica` both rated **3 movies**.
  - Since `Daniel` is **lexicographically smaller**, he is chosen.

- **Highest Average Movie Rating in February 2020:**
  - **Frozen 2**: `(5 + 2) / 2 = 3.5`
  - **Joker**: `(3 + 4) / 2 = 3.5`
  - Since **Frozen 2** is **lexicographically smaller**, it is chosen.

---

## 🖥 SQL Solution

### ✅ **Using `JOIN` + `GROUP BY` + `HAVING`**
#### **Explanation:**
1. **Find the most active user:**
   - Count the number of ratings per user.
   - Use `ORDER BY COUNT(*) DESC, name` to get the **user with the most ratings**, breaking ties lexicographically.
   - Limit the result to **1 user**.

2. **Find the highest-rated movie in February 2020:**
   - Filter rows where `created_at` is **in February 2020**.
   - **Calculate the average rating per movie**.
   - Use `ORDER BY AVG(rating) DESC, title` to get the **highest-rated movie**, breaking ties lexicographically.
   - Limit the result to **1 movie**.

```sql
(
    SELECT name AS results
    FROM
        Users
        JOIN MovieRating USING (user_id)
    GROUP BY user_id
    ORDER BY COUNT(1) DESC, name
    LIMIT 1
)
UNION ALL
(
    SELECT title
    FROM
        MovieRating
        JOIN Movies USING (movie_id)
    WHERE DATE_FORMAT(created_at, '%Y-%m') = '2020-02'
    GROUP BY movie_id
    ORDER BY AVG(rating) DESC, title
    LIMIT 1
);
```

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
1. **Find the user with the most ratings:**
   - Group by `user_id`, count the ratings.
   - Merge with `Users` table to get `name`.
   - Sort by **count descending**, then **lexicographically**.

2. **Find the highest-rated movie in February 2020:**
   - Filter only `created_at` **in February 2020**.
   - Group by `movie_id` and calculate **average rating**.
   - Merge with `Movies` to get `title`.
   - Sort by **rating descending**, then **lexicographically**.

```python
import pandas as pd

def movie_rating(users: pd.DataFrame, movies: pd.DataFrame, movie_rating: pd.DataFrame) -> pd.DataFrame:
    # Most active user
    user_counts = movie_rating.groupby("user_id")["rating"].count().reset_index()
    most_active_user = user_counts.merge(users, on="user_id")
    most_active_user = most_active_user.sort_values(by=["rating", "name"], ascending=[False, True]).iloc[0]["name"]

    # Highest-rated movie in February 2020
    movie_rating["created_at"] = pd.to_datetime(movie_rating["created_at"])
    feb_ratings = movie_rating[movie_rating["created_at"].dt.strftime('%Y-%m') == "2020-02"]
    
    avg_ratings = feb_ratings.groupby("movie_id")["rating"].mean().reset_index()
    highest_rated_movie = avg_ratings.merge(movies, on="movie_id")
    highest_rated_movie = highest_rated_movie.sort_values(by=["rating", "title"], ascending=[False, True]).iloc[0]["title"]

    return pd.DataFrame({"results": [most_active_user, highest_rated_movie]})
```

---

## 📁 File Structure
```
📂 Movie-Rating
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/movie-rating/)
- 📚 [SQL `GROUP BY` Clause](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)

## Would you like any changes or additions? 🚀