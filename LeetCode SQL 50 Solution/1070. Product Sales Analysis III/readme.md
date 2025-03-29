
# **1070. Product Sales Analysis III**

## **Problem Statement**
You are given two tables:

- `Sales` (contains sales data including `product_id`, `year`, `quantity`, and `price`).  
- `Product` (contains `product_id` and `product_name`).

Each `product_id` in `Sales` is a **foreign key** referring to the `Product` table.

### **Sales Table**
```
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+
| int     | int        | int  | int      | int   |
+---------+------------+------+----------+-------+
```
- `(sale_id, year)` is the **primary key** (unique values).
- `product_id` refers to the `Product` table.
- `price` represents the **per unit price** of the product in that year.

### **Product Table**
```
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| int        | varchar      |
+------------+--------------+
```
- `product_id` is the **primary key** of this table.

### **Task:**
Find the `product_id`, `first_year`, `quantity`, and `price` for **the first year a product was sold**.

---

## **Example 1:**

### **Input:**
**Sales Table**
```
+---------+------------+------+----------+-------+
| sale_id | product_id | year | quantity | price |
+---------+------------+------+----------+-------+
| 1       | 100        | 2008 | 10       | 5000  |
| 2       | 100        | 2009 | 12       | 5000  |
| 7       | 200        | 2011 | 15       | 9000  |
+---------+------------+------+----------+-------+
```

**Product Table**
```
+------------+--------------+
| product_id | product_name |
+------------+--------------+
| 100        | Nokia        |
| 200        | Apple        |
| 300        | Samsung      |
+------------+--------------+
```

### **Output:**
```
+------------+------------+----------+-------+
| product_id | first_year | quantity | price |
+------------+------------+----------+-------+
| 100        | 2008       | 10       | 5000  |
| 200        | 2011       | 15       | 9000  |
+------------+------------+----------+-------+
```

### **Explanation:**
- **Product 100 (Nokia):** First sold in **2008** with **10 units** at **5000** price.
- **Product 200 (Apple):** First sold in **2011** with **15 units** at **9000** price.

---

## **SQL Solutions**

### **1️⃣ Standard MySQL Solution**
```sql
SELECT 
  product_id, 
  year AS first_year, 
  quantity, 
  price 
FROM 
  Sales 
WHERE 
  (product_id, year) IN (
    SELECT 
      product_id, 
      MIN(year) AS year 
    FROM 
      Sales 
    GROUP BY 
      product_id
  );
```
#### **Explanation:**
1. **Subquery (`MIN(year)`)** → Finds the **first year** (`MIN(year)`) each `product_id` was sold.
2. **Filter the main table** → Selects rows matching the **earliest year** for each product.

---

### **2️⃣ Window Function (SQL) Solution**
```sql
WITH RankedSales AS (
    SELECT 
        product_id, 
        year AS first_year, 
        quantity, 
        price,
        RANK() OVER (PARTITION BY product_id ORDER BY year ASC) AS rnk
    FROM Sales
)
SELECT product_id, first_year, quantity, price
FROM RankedSales
WHERE rnk = 1;
```
#### **Explanation:**
1. **`RANK() OVER (PARTITION BY product_id ORDER BY year ASC)`**  
   - Assigns **rank 1** to the first sale per `product_id`.
2. **Filter (`WHERE rnk = 1`)**  
   - Retrieves **only the first sale per product**.

---

## **Pandas Solution (Python)**
```python
import pandas as pd

# Sample Data
sales_data = {'sale_id': [1, 2, 7], 
              'product_id': [100, 100, 200], 
              'year': [2008, 2009, 2011], 
              'quantity': [10, 12, 15], 
              'price': [5000, 5000, 9000]}

# Create DataFrame
sales_df = pd.DataFrame(sales_data)

# Find the first sale per product
first_sales = sales_df.loc[sales_df.groupby('product_id')['year'].idxmin(), ['product_id', 'year', 'quantity', 'price']]

# Rename columns
first_sales.rename(columns={'year': 'first_year'}, inplace=True)

print(first_sales)
```

### **Explanation:**
1. **Create DataFrame** → Convert `Sales` table into Pandas DataFrame.
2. **Group by `product_id` and get the `idxmin()` of `year`** → Finds the first sale per product.
3. **Retrieve `product_id`, `year`, `quantity`, and `price`**.
4. **Rename `year` to `first_year`**.

---

## **File Structure**
```
LeetCode1070/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solutions (Standard + Window Functions).
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 1070](https://leetcode.com/problems/product-sales-analysis-iii/)
- [SQL JOIN Documentation](https://www.w3schools.com/sql/sql_join.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)


## 🚀 **Now it's a complete guide!** 🚀