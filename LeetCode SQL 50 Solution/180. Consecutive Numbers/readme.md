# 180. Consecutive Numbers

## Problem Statement
Table: `Logs`

| Column Name | Type    |
| ----------- | ------- |
| id          | int     |
| num         | varchar |

- `id` is the primary key (auto-incremented starting from 1).
- Find all numbers that appear **at least three times consecutively**.
- Return the result table in **any order**.

### Example 1:

#### Input:
| id  | num |
| --- | --- |
| 1   | 1   |
| 2   | 1   |
| 3   | 1   |
| 4   | 2   |
| 5   | 1   |
| 6   | 2   |
| 7   | 2   |

#### Output:
| ConsecutiveNums |
| --------------- |
| 1               |

---

## Solution

```sql
SELECT DISTINCT num AS ConsecutiveNums
FROM Logs l1
JOIN Logs l2 ON l1.id = l2.id - 1
JOIN Logs l3 ON l2.id = l3.id - 1
WHERE l1.num = l2.num AND l2.num = l3.num;
```

### Explanation:
- We use **self-joins** to check three consecutive rows where `num` values are the same.
- `l1`, `l2`, and `l3` represent three consecutive rows.
- The condition `l1.num = l2.num AND l2.num = l3.num` ensures that we only select numbers appearing at least three times consecutively.
- `DISTINCT` ensures we don't get duplicate results.

---

## Alternative Approach using `LAG()` (MySQL 8+)

```sql
WITH Consecutive AS (
    SELECT num,
           LAG(num, 1) OVER (ORDER BY id) AS prev1,
           LAG(num, 2) OVER (ORDER BY id) AS prev2
    FROM Logs
)
SELECT DISTINCT num AS ConsecutiveNums
FROM Consecutive
WHERE num = prev1 AND num = prev2;
```

### Explanation:
- We use the `LAG()` function to check the previous two rows for the same `num` value.
- If a `num` matches with its two previous values, it qualifies as a **consecutive number appearing at least three times**.

---

## File Structure

```
📂 ConsecutiveNumbers
 ├── 📄 README.md  # Problem statement, approach, and solutions
 ├── 📄 consecutive_numbers.sql  # SQL solution
 ├── 📄 alternative_solution.sql  # Alternative solution using LAG()
```

---

## Useful Links
- [LeetCode Problem](https://leetcode.com/problems/consecutive-numbers/) 🚀
- [SQL `JOIN` Explained](https://www.w3schools.com/sql/sql_join.asp)
- [MySQL `LAG()` Window Function](https://dev.mysql.com/doc/refman/8.0/en/window-function-descriptions.html)

---

Feel free to contribute with optimized solutions! 💡