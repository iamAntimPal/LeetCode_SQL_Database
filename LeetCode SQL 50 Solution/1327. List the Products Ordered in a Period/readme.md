# 🛒 List the Products Ordered in a Period - LeetCode 1327

## 📌 Problem Statement
You are given two tables: **Products** and **Orders**.  
Your task is to **list the product names** that had at least **100 units ordered in February 2020** along with the total amount ordered.

---

## 📊 Table Structure

### **Products Table**
| Column Name      | Type    |
| ---------------- | ------- |
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |

- `product_id` is the **primary key** (unique identifier).
- This table contains details about products.

---

### **Orders Table**
| Column Name | Type |
| ----------- | ---- |
| product_id  | int  |
| order_date  | date |
| unit        | int  |

- `product_id` is a **foreign key** referencing the `Products` table.
- `order_date` represents when the order was placed.
- `unit` represents the **number of products ordered** on that date.
- The table **may contain duplicate rows**.

---

## 🔢 Goal:
Find all products that had **at least 100 units ordered** during **February 2020** and display:
- `product_name`
- Total `unit` ordered in that period

---

## 📊 Example 1:
### **Input:**
#### **Products Table**
| product_id | product_name          | product_category |
| ---------- | --------------------- | ---------------- |
| 1          | Leetcode Solutions    | Book             |
| 2          | Jewels of Stringology | Book             |
| 3          | HP                    | Laptop           |
| 4          | Lenovo                | Laptop           |
| 5          | Leetcode Kit          | T-shirt          |

#### **Orders Table**
| product_id | order_date | unit |
| ---------- | ---------- | ---- |
| 1          | 2020-02-05 | 60   |
| 1          | 2020-02-10 | 70   |
| 2          | 2020-01-18 | 30   |
| 2          | 2020-02-11 | 80   |
| 3          | 2020-02-17 | 2    |
| 3          | 2020-02-24 | 3    |
| 4          | 2020-03-01 | 20   |
| 4          | 2020-03-04 | 30   |
| 4          | 2020-03-04 | 60   |
| 5          | 2020-02-25 | 50   |
| 5          | 2020-02-27 | 50   |
| 5          | 2020-03-01 | 50   |

### **Output:**
| product_name       | unit |
| ------------------ | ---- |
| Leetcode Solutions | 130  |
| Leetcode Kit       | 100  |

### **Explanation:**
- **Leetcode Solutions** (ID=1) was ordered in February:  
  \[
  60 + 70 = 130 \quad (\text{✓ included})
  \]
- **Jewels of Stringology** (ID=2) was ordered **only 80** times in February. (**✗ not included**)
- **HP Laptop** (ID=3) was ordered **5 times** in February. (**✗ not included**)
- **Lenovo Laptop** (ID=4) was **not ordered** in February. (**✗ not included**)
- **Leetcode Kit** (ID=5) was ordered **100 times** in February. (**✓ included**)

---

## 🖥 SQL Solution

### ✅ **Using `JOIN` + `GROUP BY` + `HAVING`**
#### **Explanation:**
1. **Join** the `Products` and `Orders` tables on `product_id`.
2. **Filter orders** placed in **February 2020** (`BETWEEN '2020-02-01' AND '2020-02-29'`).
3. **Sum up the `unit` ordered** for each product.
4. **Use `HAVING` to filter products with at least 100 units.**
5. Return results in **any order**.

```sql
SELECT P.PRODUCT_NAME, SUM(O.UNIT) AS UNIT  
FROM PRODUCTS P  
INNER JOIN ORDERS O  
ON P.PRODUCT_ID = O.PRODUCT_ID  
WHERE O.ORDER_DATE BETWEEN '2020-02-01' AND '2020-02-29'  
GROUP BY P.PRODUCT_NAME  
HAVING SUM(O.UNIT) >= 100;
```

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
1. **Merge** `products` and `orders` on `product_id`.
2. **Filter only February 2020 orders**.
3. **Group by `product_name`** and **sum `unit`**.
4. **Filter products with at least 100 units**.
5. **Return the final DataFrame**.

```python
import pandas as pd

def products_ordered(products: pd.DataFrame, orders: pd.DataFrame) -> pd.DataFrame:
    # Merge both tables on product_id
    merged_df = pd.merge(orders, products, on="product_id", how="inner")

    # Convert order_date to datetime format and filter February 2020
    merged_df["order_date"] = pd.to_datetime(merged_df["order_date"])
    feb_orders = merged_df[
        (merged_df["order_date"] >= "2020-02-01") & (merged_df["order_date"] <= "2020-02-29")
    ]

    # Group by product_name and sum the units
    result = feb_orders.groupby("product_name")["unit"].sum().reset_index()

    # Filter products with at least 100 units
    result = result[result["unit"] >= 100]

    return result
```

---

## 📁 File Structure
```
📂 List-Products-Ordered
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/list-the-products-ordered-in-a-period/)
- 📚 [SQL `HAVING` Clause](https://www.w3schools.com/sql/sql_having.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
