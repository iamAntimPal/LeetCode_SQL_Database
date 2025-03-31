# 🚌 Last Person to Fit in the Bus - LeetCode 1204

## 📌 Problem Statement
You are given the **Queue** table, which contains information about people waiting for a bus.

### Queue Table
| Column Name | Type    |
| ----------- | ------- |
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |

- **person_id** contains unique values.
- The **turn** column determines the order in which people will board (`turn = 1` means the first person to board).
- The **bus has a weight limit of 1000 kg**.
- Only **one person can board at a time**.

### Task:
Find **the last person** who can board the bus **without exceeding the 1000 kg weight limit**.

---

## 📊 Example 1:
### Input:
**Queue Table**
| person_id | person_name | weight | turn |
| --------- | ----------- | ------ | ---- |
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |

### Output:
| person_name |
| ----------- |
| John Cena   |

### Explanation:
Ordering by `turn`:
| Turn | ID  | Name      | Weight | Total Weight |
| ---- | --- | --------- | ------ | ------------ |
| 1    | 5   | Alice     | 250    | 250          |
| 2    | 3   | Alex      | 350    | 600          |
| 3    | 6   | John Cena | 400    | 1000         | ✅ (last person to board) |
| 4    | 2   | Marie     | 200    | 1200         | ❌ (exceeds limit)        |
| 5    | 4   | Bob       | 175    | ❌            |
| 6    | 1   | Winston   | 500    | ❌            |

---

## 🖥 SQL Solution

### 1️⃣ Standard MySQL Solution
#### Explanation:
- **Use a self-join** to accumulate the total weight up to each person's turn.
- **Filter out** people whose cumulative weight exceeds **1000**.
- **Find the last person** who can board.

```sql
SELECT a.person_name
FROM
    Queue AS a,
    Queue AS b
WHERE a.turn >= b.turn
GROUP BY a.person_id
HAVING SUM(b.weight) <= 1000
ORDER BY a.turn DESC
LIMIT 1;
```

---

### 📝 Step-by-Step Breakdown:

1️⃣ **Self-Join on the Table**
```sql
FROM Queue AS a, Queue AS b
WHERE a.turn >= b.turn
```
- This pairs each row `a` with all rows `b` where `b.turn` is less than or equal to `a.turn`.
- Allows us to calculate the **cumulative sum of weights** for each person.

2️⃣ **Group by Each Person**
```sql
GROUP BY a.person_id
```
- Groups all rows by `person_id` so we can perform calculations per person.

3️⃣ **Compute the Cumulative Weight**
```sql
HAVING SUM(b.weight) <= 1000
```
- Filters out people whose cumulative boarding weight exceeds **1000 kg**.

4️⃣ **Find the Last Person Who Can Board**
```sql
ORDER BY a.turn DESC
LIMIT 1;
```
- **Sorts by turn in descending order** so that we find the **last person** who can board.
- **Limits to 1 row** to return only the last eligible person.

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- **Sort by `turn`** to simulate the boarding order.
- **Compute the cumulative sum** of weights.
- **Find the last person** whose weight sum **does not exceed 1000**.

```python
import pandas as pd

def last_person_to_fit(queue: pd.DataFrame) -> pd.DataFrame:
    # Sort by turn
    queue = queue.sort_values(by="turn")

    # Compute cumulative weight sum
    queue["cumulative_weight"] = queue["weight"].cumsum()

    # Filter those who fit on the bus
    queue = queue[queue["cumulative_weight"] <= 1000]

    # Return the last person to fit
    return queue.tail(1)[["person_name"]]
```

---

## 📁 File Structure
```
📂 Last-Person-Fit
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/last-person-to-fit-in-the-bus/)
- 📚 [SQL `GROUP BY` Clause](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas cumsum() Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.cumsum.html)

## Let me know if you need any modifications! 🚀