# 📰 Article Views I - LeetCode 1148

## 📌 Problem Statement
You are given the **Views** table that records article views.

### Views Table
| Column Name | Type |
| ----------- | ---- |
| article_id  | int  |
| author_id   | int  |
| viewer_id   | int  |
| view_date   | date |

- The table **may contain duplicate rows**.
- Each row indicates that **some viewer viewed an article** written by some author on a specific date.
- If `author_id = viewer_id`, it means **the author viewed their own article**.

### Task:
Find **all authors** who have viewed **at least one of their own articles**.
- **Return the result sorted by `id` in ascending order**.

---

## 📊 Example 1:
### Input:
**Views Table**
| article_id | author_id | viewer_id | view_date  |
| ---------- | --------- | --------- | ---------- |
| 1          | 3         | 5         | 2019-08-01 |
| 1          | 3         | 6         | 2019-08-02 |
| 2          | 7         | 7         | 2019-08-01 |
| 2          | 7         | 6         | 2019-08-02 |
| 4          | 7         | 1         | 2019-07-22 |
| 3          | 4         | 4         | 2019-07-21 |
| 3          | 4         | 4         | 2019-07-21 |

### Output:
| id  |
| --- |
| 4   |
| 7   |

### Explanation:
- **Author 4** viewed their own article (`viewer_id = author_id`).
- **Author 7** viewed their own article (`viewer_id = author_id`).
- The result is sorted in **ascending order**.

---

## 🖥 SQL Solutions

### 1️⃣ Standard MySQL Solution
#### Explanation:
- **Filter rows** where `author_id = viewer_id`.
- Use `DISTINCT` to **remove duplicates**.
- **Sort the result** in ascending order.

```sql
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC;
```

---

### 2️⃣ Alternative Solution Using `GROUP BY`
#### Explanation:
- **Group by** `author_id` and **filter authors** who have viewed at least one of their own articles.

```sql
SELECT author_id AS id
FROM Views
WHERE author_id = viewer_id
GROUP BY author_id
ORDER BY id ASC;
```

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- **Filter rows** where `author_id == viewer_id`.
- **Select distinct author IDs**.
- **Sort the result** in ascending order.

```python
import pandas as pd

def authors_who_viewed_own_articles(views: pd.DataFrame) -> pd.DataFrame:
    # Filter rows where author_id == viewer_id
    filtered = views[views["author_id"] == views["viewer_id"]]
    
    # Select unique author IDs and sort
    result = pd.DataFrame({"id": sorted(filtered["author_id"].unique())})
    
    return result
```

---

## 📁 File Structure
```
📂 Article-Views-I
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_group_by.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/article-views-i/)
- 📚 [SQL DISTINCT vs GROUP BY](https://www.w3schools.com/sql/sql_distinct.asp)
- 🐍 [Pandas Unique Function](https://pandas.pydata.org/docs/reference/api/pandas.Series.unique.html)

## Let me know if you need any changes! 🚀