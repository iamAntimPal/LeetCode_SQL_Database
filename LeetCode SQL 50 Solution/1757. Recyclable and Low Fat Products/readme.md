# ♻️ Recyclable and Low Fat Products - LeetCode 1757

## 📌 Problem Statement
You are given a table **Products** that contains information about products with respect to their fat content and recyclability.

- The **low_fats** column is an ENUM with values `'Y'` and `'N'`, where `'Y'` indicates the product is low fat.
- The **recyclable** column is an ENUM with values `'Y'` and `'N'`, where `'Y'` indicates the product is recyclable.

Your task is to **find the IDs of products that are both low fat and recyclable**.

Return the result in **any order**.

---

## 📊 Table Structure

### **Products Table**
| Column Name | Type |
| ----------- | ---- |
| product_id  | int  |
| low_fats    | enum |
| recyclable  | enum |

- `product_id` is the **primary key**.

---

## 📊 Example 1:

### **Input:**
#### **Products Table**
| product_id | low_fats | recyclable |
| ---------- | -------- | ---------- |
| 0          | Y        | N          |
| 1          | Y        | Y          |
| 2          | N        | Y          |
| 3          | Y        | Y          |
| 4          | N        | N          |

### **Output:**
| product_id |
| ---------- |
| 1          |
| 3          |

### **Explanation:**
- Only products with `product_id` **1** and **3** are **both low fat and recyclable**.

---

## 🖥 SQL Solution

### ✅ **Approach:**
- Filter the **Products** table for rows where `low_fats = 'Y'` and `recyclable = 'Y'`.
- Return the corresponding `product_id`.

```sql
SELECT product_id
FROM Products
WHERE low_fats = 'Y' AND recyclable = 'Y';
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. Load the **Products** table into a Pandas DataFrame.
2. Filter the DataFrame to keep rows where both `low_fats` and `recyclable` are `'Y'`.
3. Select and return the `product_id` column.

```python
import pandas as pd

def recyclable_low_fat_products(products: pd.DataFrame) -> pd.DataFrame:
    # Filter rows where both low_fats and recyclable are 'Y'
    filtered = products[(products['low_fats'] == 'Y') & (products['recyclable'] == 'Y')]
    # Select only the product_id column
    result = filtered[['product_id']]
    return result
```

---

## 📁 File Structure
```
📂 Recyclable-Low-Fat-Products
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
│── 📜 sample_data.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/recyclable-and-low-fat-products/)
- 🔍 [MySQL WHERE Clause](https://www.w3schools.com/sql/sql_where.asp)
- 🐍 [Pandas DataFrame Filtering](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.loc.html)
