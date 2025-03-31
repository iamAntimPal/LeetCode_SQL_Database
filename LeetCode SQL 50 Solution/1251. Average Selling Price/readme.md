
# 🛒 Average Selling Price - LeetCode 1251

## 📌 Problem Statement
You are given two tables, **Prices** and **UnitsSold**, which contain information about product pricing and sales.

### 📊 Prices Table
| Column Name | Type |
| ----------- | ---- |
| product_id  | int  |
| start_date  | date |
| end_date    | date |
| price       | int  |

- `(product_id, start_date, end_date)` is the **primary key**.
- Each row defines the price for `product_id` **within a specific date range**.
- **No two price periods overlap** for the same product.

### 📊 UnitsSold Table
| Column Name   | Type |
| ------------- | ---- |
| product_id    | int  |
| purchase_date | date |
| units         | int  |

- Each row records the number of units sold for `product_id` on `purchase_date`.
- **Table may contain duplicate rows**.

### 🔢 Goal:
Find the **average selling price** for each `product_id`, rounded to **2 decimal places**.  
If a product has **no sales**, its average price should be **0**.

---

## 📊 Example 1:
### Input:
### **Prices Table**
| product_id | start_date | end_date   | price |
| ---------- | ---------- | ---------- | ----- |
| 1          | 2019-02-17 | 2019-02-28 | 5     |
| 1          | 2019-03-01 | 2019-03-22 | 20    |
| 2          | 2019-02-01 | 2019-02-20 | 15    |
| 2          | 2019-02-21 | 2019-03-31 | 30    |

### **UnitsSold Table**
| product_id | purchase_date | units |
| ---------- | ------------- | ----- |
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |

### Output:
| product_id | average_price |
| ---------- | ------------- |
| 1          | 6.96          |
| 2          | 16.96         |

---

## 🔍 Explanation:
### **Formula**
\[
\text{Average Selling Price} = \frac{\sum (\text{price} \times \text{units sold})}{\sum (\text{units sold})}
\]

### **Product 1 Calculation**
- **Feb 25, 2019:** 100 units sold at **$5**
- **Mar 01, 2019:** 15 units sold at **$20**
- **Total Price Contribution:**  
  \[
  (100 \times 5) + (15 \times 20) = 500 + 300 = 800
  \]
- **Total Units Sold:**  
  \[
  100 + 15 = 115
  \]
- **Average Price:**  
  \[
  800 / 115 = 6.96
  \]

### **Product 2 Calculation**
- **Feb 10, 2019:** 200 units sold at **$15**
- **Mar 22, 2019:** 30 units sold at **$30**
- **Total Price Contribution:**  
  \[
  (200 \times 15) + (30 \times 30) = 3000 + 900 = 3900
  \]
- **Total Units Sold:**  
  \[
  200 + 30 = 230
  \]
- **Average Price:**  
  \[
  3900 / 230 = 16.96
  \]

---

## 🖥 SQL Solution

### 1️⃣ Standard MySQL Query
#### **Explanation:**
- **Join `Prices` and `UnitsSold`** on `product_id`, ensuring `purchase_date` falls **within the valid price period** (`start_date` ≤ `purchase_date` ≤ `end_date`).
- **Multiply `price * units`** for total revenue.
- **Sum total units** for each product.
- **Use `ROUND(..., 2)`** to get 2 decimal places.
- **Use `IFNULL(..., 0)`** to handle cases where no units were sold.

```sql
SELECT p.product_id, 
       IFNULL(ROUND(SUM(p.price * u.units) / SUM(u.units), 2), 0) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id 
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```

---

### 📝 Step-by-Step Breakdown:

1️⃣ **Join Tables Based on Matching Date Ranges**
```sql
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id 
AND u.purchase_date BETWEEN p.start_date AND p.end_date
```
- Ensures we only match **valid** sales based on pricing periods.

2️⃣ **Calculate Revenue Per Product**
```sql
SUM(p.price * u.units)
```
- Computes total revenue for each product.

3️⃣ **Compute Total Sold Units Per Product**
```sql
SUM(u.units)
```
- Sums up all sold units.

4️⃣ **Calculate Average Price and Handle Edge Cases**
```sql
ROUND(SUM(p.price * u.units) / SUM(u.units), 2)
```
- Ensures precision with 2 decimal places.

5️⃣ **Handle Products with No Sales**
```sql
IFNULL(..., 0)
```
- If `SUM(u.units)` is `NULL`, return `0`.

---

### 2️⃣ Alternative MySQL Query (Using `COALESCE`)
```sql
SELECT p.product_id, 
       ROUND(SUM(COALESCE(p.price, 0) * COALESCE(u.units, 0)) / SUM(COALESCE(u.units, 0)), 2) AS average_price
FROM Prices p
LEFT JOIN UnitsSold u
ON p.product_id = u.product_id 
AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id;
```
- Uses **`COALESCE(value, 0)`** instead of `IFNULL()` for robustness.

---

## 🐍 Pandas Solution (Python)
#### **Explanation:**
- **Merge DataFrames on `product_id`** where `purchase_date` falls in the price range.
- **Compute total price & units**.
- **Handle cases where no units were sold**.

```python
import pandas as pd

def average_selling_price(prices: pd.DataFrame, units_sold: pd.DataFrame) -> pd.DataFrame:
    # Merge on product_id where purchase_date is within the valid price period
    merged = prices.merge(units_sold, on="product_id")
    merged = merged[(merged["purchase_date"] >= merged["start_date"]) & 
                    (merged["purchase_date"] <= merged["end_date"])]

    # Calculate total revenue and total units per product
    merged["total_price"] = merged["price"] * merged["units"]
    result = merged.groupby("product_id").agg(
        average_price=("total_price", lambda x: round(x.sum() / merged.loc[x.index, "units"].sum(), 2))
    ).reset_index()

    # Handle products with no sales
    result["average_price"] = result["average_price"].fillna(0)

    return result
```

---

## 📁 File Structure
```
📂 Average-Selling-Price
│── 📜 README.md
│── 📜 solution.sql
│── 📜 solution_pandas.py
│── 📜 test_cases.sql
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/average-selling-price/)
- 📚 [SQL `LEFT JOIN` Documentation](https://www.w3schools.com/sql/sql_join_left.asp)
- 🐍 [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)
