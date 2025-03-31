# 📊 Queries Quality and Percentage - LeetCode 1211

## 📌 Problem Statement
You are given the **Queries** table, which contains information collected from various queries on a database.

### Queries Table
| Column Name | Type    |
| ----------- | ------- |
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |

- The **position** column has values from **1 to 500**.
- The **rating** column has values from **1 to 5**.
- **Queries with rating < 3 are considered "poor queries".**

### Definitions:
1️⃣ **Query Quality:**  
   The **average** of the **ratio** between query rating and its position:
   \[
   \text{quality} = \frac{\sum (\text{rating} / \text{position})}{\text{total queries for that name}}
   \]

2️⃣ **Poor Query Percentage:**  
   The percentage of all queries where **rating < 3**:
   \[
   \text{poor\_query\_percentage} = \left(\frac{\text{count of poor queries}}{\text{total queries}}\right) \times 100
   \]

---

## 📊 Example 1:
### Input:
**Queries Table**
| query_name | result           | position | rating |
| ---------- | ---------------- | -------- | ------ |
| Dog        | Golden Retriever | 1        | 5      |
| Dog        | German Shepherd  | 2        | 5      |
| Dog        | Mule             | 200      | 1      |
| Cat        | Shirazi          | 5        | 2      |
| Cat        | Siamese          | 3        | 3      |
| Cat        | Sphynx           | 7        | 4      |

### Output:
| query_name | quality | poor_query_percentage |
| ---------- | ------- | --------------------- |
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |

### Explanation:
#### **Dog**
- **Quality Calculation:**
  \[
  \left( \frac{5}{1} + \frac{5}{2} + \frac{1}{200} \right) \div 3 = 2.50
  \]
- **Poor Query Percentage:**
  - Poor Queries: **1** (Mule, rating = 1)
  - Total Queries: **3**
  \[
  (1 / 3) \times 100 = 33.33\%
  \]

#### **Cat**
- **Quality Calculation:**
  \[
  \left( \frac{2}{5} + \frac{3}{3} + \frac{4}{7} \right) \div 3 = 0.66
  \]
- **Poor Query Percentage:**
  - Poor Queries: **1** (Shirazi, rating = 2)
  - Total Queries: **3**
  \[
  (1 / 3) \times 100 = 33.33\%
  \]

---

## 🖥 SQL Solution

### 1️⃣ Standard MySQL Query
#### Explanation:
- **Calculate quality** using `AVG(rating / position)`.
- **Count poor queries** using `SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END)`.
- **Calculate percentage** using `(COUNT of poor queries / total queries) * 100`.

```sql
SELECT query_name, 
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
```

---

### 📝 Step-by-Step Breakdown:

1️⃣ **Grouping Queries by `query_name`**
```sql
GROUP BY query_name;
```
- Ensures calculations are **per query type**.

2️⃣ **Calculating Query Quality**
```sql
ROUND(AVG(rating * 1.0 / position), 2) AS quality
```
- **`rating / position`** calculates the ratio.
- **`AVG(...)`** finds the average across all entries for the query.
- **Multiplying by `1.0` ensures floating-point division.**
- **`ROUND(..., 2)` rounds to 2 decimal places**.

3️⃣ **Calculating Poor Query Percentage**
```sql
ROUND(SUM(CASE WHEN rating < 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS poor_query_percentage
```
- **Counts queries with `rating < 3` using `SUM(CASE WHEN ... THEN 1 ELSE 0 END)`**.
- **Divides by total queries (`COUNT(*)`) and multiplies by `100`**.
- **Rounds to 2 decimal places**.

---

### 2️⃣ Alternative MySQL Query (Using `IF` Instead of `CASE`)

```sql
SELECT query_name,
    ROUND(AVG(rating * 1.0 / position), 2) AS quality,
    ROUND(SUM(IF(rating < 3, 1, 0)) * 100.0 / COUNT(*), 2) AS poor_query_percentage  
FROM Queries
GROUP BY query_name;
```
- **`IF(rating < 3, 1, 0)`** is equivalent to `CASE WHEN rating < 3 THEN 1 ELSE 0 END`.

---

## 🐍 Pandas Solution (Python)
#### Explanation:
- **Group by `query_name`**.
- **Calculate query quality** as `rating / position`, then average.
- **Filter poor queries (`rating < 3`) and compute percentage**.

```python
import pandas as pd

def queries_quality(queries: pd.DataFrame) -> pd.DataFrame:
    # Group by query_name
    grouped = queries.groupby("query_name")

    # Compute Quality
    quality = grouped.apply(lambda x: round((x["rating"] / x["position"]).mean(), 2))

    # Compute Poor Query Percentage
    poor_query_percentage = grouped.apply(lambda x: round((x["rating"] < 3).mean() * 100, 2))

    # Return result
    result = pd.DataFrame({"query_name": quality.index, 
                           "quality": quality.values, 
                           "poor_query_percentage": poor_query_percentage.values})
    return result
```

---

## 📁 File Structure
```
📂 Queries-Quality
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/queries-quality-and-percentage/)
- 📚 [SQL `GROUP BY` Documentation](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/groupby.html)

## Let me know if you'd like any modifications! 🚀