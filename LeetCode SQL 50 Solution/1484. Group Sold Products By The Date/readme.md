# 🛍️ Group Sold Products By The Date - LeetCode 1484

## 📌 Problem Statement
You are given a table **Activities** that contains records of products sold on different dates.

Your task is to return:
- The **number of distinct products** sold on each date.
- A **comma-separated string** of the product names, sorted **lexicographically**.

The result should be **ordered by `sell_date`**.

---

## 📊 Table Structure

### **Activities Table**
| Column Name | Type    |
| ----------- | ------- |
| sell_date   | date    |
| product     | varchar |

- This table **does not** have a **primary key**.
- It may **contain duplicate entries**.

---

## 📊 Example 1:
### **Input:**
#### **Activities Table**
| sell_date  | product    |
| ---------- | ---------- |
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |

### **Output:**
| sell_date  | num_sold | products                     |
| ---------- | -------- | ---------------------------- |
| 2020-05-30 | 3        | Basketball,Headphone,T-Shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |

### **Explanation:**
- `2020-05-30`: Sold items → _(Headphone, Basketball, T-Shirt)_  
  - Sorted → **"Basketball, Headphone, T-Shirt"**  
- `2020-06-01`: Sold items → _(Pencil, Bible)_  
  - Sorted → **"Bible, Pencil"**  
- `2020-06-02`: Sold item → _(Mask)_  
  - **"Mask"** (only one item)

---

## 🖥 SQL Solution

### ✅ **Using `GROUP_CONCAT` with `DISTINCT`**
#### **Explanation:**
- Use `COUNT(DISTINCT product)` to get the **number of distinct products**.
- Use `GROUP_CONCAT(DISTINCT product ORDER BY product ASC)` to **join product names in alphabetical order**.
- Group by `sell_date`, then order the result by `sell_date`.

```sql
SELECT 
    sell_date, 
    COUNT(DISTINCT product) AS num_sold,
    GROUP_CONCAT(DISTINCT product ORDER BY product ASC SEPARATOR ',') AS products
FROM Activities
GROUP BY sell_date
ORDER BY sell_date ASC;
```

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
- **Group by `sell_date`**.
- Use `.nunique()` to count distinct products.
- Use `', '.join(sorted(set(products)))` to sort and concatenate product names.

```python
import pandas as pd

def group_sold_products(activities: pd.DataFrame) -> pd.DataFrame:
    grouped_df = (
        activities.groupby("sell_date")["product"]
        .agg(lambda x: ", ".join(sorted(set(x))))
        .reset_index()
    )
    grouped_df["num_sold"] = grouped_df["product"].apply(lambda x: len(x.split(",")))
    return grouped_df.rename(columns={"product": "products"})
```

---

## 📁 File Structure
```
📂 Group-Sold-Products
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/group-sold-products-by-the-date/)
- 📚 [SQL `GROUP BY`](https://www.w3schools.com/sql/sql_groupby.asp)
- 🐍 [Pandas `groupby()` Documentation](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.DataFrame.groupby.html)
