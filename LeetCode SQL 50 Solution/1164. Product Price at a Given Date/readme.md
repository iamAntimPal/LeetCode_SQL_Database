

# **1164. Product Price at a Given Date**

## **Problem Statement**
You are given the **Products** table, which keeps track of price changes.

### **Products Table**
```
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| int        | int       | date        |
+------------+-----------+-------------+
```
- `(product_id, change_date)` is the **primary key**.
- Each row represents a price update for a product on a specific date.

### **Task:**
Find the price of all products on **2019-08-16**.  
Assume the **initial price of all products is 10** before any change occurs.

---

## **Example 1:**

### **Input:**
**Products Table**
```
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
```

### **Output:**
```
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+
```

### **Explanation:**
- **Product 1:** Last change before `2019-08-16` → **35**  
- **Product 2:** Last change before `2019-08-16` → **50**  
- **Product 3:** **No price change before 2019-08-16**, so default price is **10**  

---

## **SQL Solutions**

### **1️⃣ Standard MySQL Solution**
```sql
SELECT 
    p.product_id, 
    COALESCE((
        SELECT new_price 
        FROM Products 
        WHERE product_id = p.product_id 
        AND change_date <= '2019-08-16' 
        ORDER BY change_date DESC 
        LIMIT 1
    ), 10) AS price
FROM 
    (SELECT DISTINCT product_id FROM Products) p;
```
#### **Explanation:**
1. **Find the last price before or on `2019-08-16`**  
   - `ORDER BY change_date DESC LIMIT 1` → Gets the most recent price before `2019-08-16`.
2. **Use `COALESCE()`**  
   - If no price exists, set default price **10**.
3. **Use `DISTINCT product_id`**  
   - Ensures all unique products are checked.

---

### **2️⃣ Window Function (SQL) Solution**
```sql
# Write your MySQL query statement below
# Write your MySQL query statement below
WITH
    T AS (SELECT DISTINCT product_id FROM Products),
    P AS (
        SELECT product_id, new_price AS price
        FROM Products
        WHERE
            (product_id, change_date) IN (
                SELECT product_id, MAX(change_date) AS change_date
                FROM Products
                WHERE change_date <= '2019-08-16'
                GROUP BY 1
            )
    )
SELECT product_id, IFNULL(price, 10) AS price
FROM
    T
    LEFT JOIN P USING (product_id);
```
#### **Explanation:**
1. **`RANK() OVER (PARTITION BY product_id ORDER BY change_date DESC)`**  
   - Assigns **rank 1** to the last price before `2019-08-16`.
2. **`LEFT JOIN` with `DISTINCT product_id`**  
   - Ensures all products are included.
3. **Use `COALESCE(price, 10)`**  
   - If no price exists, set default **10**.

---

## **Pandas Solution (Python)**
```python
import pandas as pd

# Sample Data
products_data = {
    'product_id': [1, 2, 1, 1, 2, 3],
    'new_price': [20, 50, 30, 35, 65, 20],
    'change_date': ['2019-08-14', '2019-08-14', '2019-08-15', '2019-08-16', '2019-08-17', '2019-08-18']
}

# Create DataFrame
products_df = pd.DataFrame(products_data)
products_df['change_date'] = pd.to_datetime(products_df['change_date'])  # Convert to datetime

# Filter for changes before or on '2019-08-16'
valid_prices = products_df[products_df['change_date'] <= '2019-08-16']

# Get the latest price for each product before '2019-08-16'
latest_prices = valid_prices.sort_values(by=['product_id', 'change_date']).groupby('product_id').last().reset_index()

# Rename column
latest_prices = latest_prices[['product_id', 'new_price']].rename(columns={'new_price': 'price'})

# Get all unique products
all_products = products_df[['product_id']].drop_duplicates()

# Merge with latest prices and fill missing values with 10
final_prices = all_products.merge(latest_prices, on='product_id', how='left').fillna({'price': 10})

print(final_prices)
```

### **Explanation:**
1. **Convert `change_date` to datetime**  
   - Ensures proper date comparison.
2. **Filter for prices before `2019-08-16`**  
   - Excludes future price changes.
3. **Get the latest price per product (`groupby().last()`)**  
   - Retrieves the most recent price change.
4. **Merge with all products and set missing prices to `10`**  
   - Ensures all products are included.

---

## **File Structure**
```
LeetCode1164/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solutions (Standard + Window Functions).
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 1164](https://leetcode.com/problems/product-price-at-a-given-date/)
- [SQL COALESCE Documentation](https://www.w3schools.com/sql/sql_coalesce.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)

