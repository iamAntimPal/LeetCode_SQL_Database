
# **1045. Customers Who Bought All Products**

## **Problem Statement**
You are given two tables:  
- `Customer` (contains `customer_id` and `product_key`)  
- `Product` (contains all available `product_key`s)

Each `product_key` in `Customer` is a **foreign key** referring to the `Product` table.

### **Customer Table**
```
+-------------+-------------+
| Column Name | Type        |
+-------------+-------------+
| customer_id | int         |
| product_key | int         |
+-------------+-------------+
```
- The table may contain **duplicate rows**.
- `customer_id` is **not NULL**.
- `product_key` refers to the `Product` table.

### **Product Table**
```
+-------------+
| product_key |
+-------------+
| int         |
+-------------+
```
- `product_key` is the **primary key** (unique values) of this table.

### **Task:**
Find **all customer IDs** who bought **every product** listed in the `Product` table.

---

## **Example 1:**

### **Input:**
**Customer Table**
```
+-------------+-------------+
| customer_id | product_key |
+-------------+-------------+
| 1           | 5           |
| 2           | 6           |
| 3           | 5           |
| 3           | 6           |
| 1           | 6           |
+-------------+-------------+
```

**Product Table**
```
+-------------+
| product_key |
+-------------+
| 5           |
| 6           |
+-------------+
```

### **Output:**
```
+-------------+
| customer_id |
+-------------+
| 1           |
| 3           |
+-------------+
```

### **Explanation:**
- There are **two products** (5 and 6).
- Customers who bought **both** products:
  - **Customer 1**: Bought `5, 6` ✅
  - **Customer 2**: Bought `6` ❌ (missing `5`)
  - **Customer 3**: Bought `5, 6` ✅
- So, **customers 1 and 3** are returned.

---

## **SQL Solutions**

### **1️⃣ Standard MySQL Solution**
```sql
SELECT customer_id 
FROM Customer 
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(product_key) FROM Product);
```
#### **Explanation:**
1. **GROUP BY `customer_id`** → Group purchases per customer.
2. **COUNT(DISTINCT product_key)** → Count unique products each customer bought.
3. **Compare with total products:**  
   - `(SELECT COUNT(product_key) FROM Product)` counts all available products.
   - Only customers with `COUNT(DISTINCT product_key) = total products` are included.
4. **HAVING** ensures we return only those who bought **all products**.

---

### **2️⃣ Window Function (SQL) Solution**
```sql
WITH product_count AS (
    SELECT COUNT(*) AS total_products FROM Product
),
customer_purchase AS (
    SELECT customer_id, COUNT(DISTINCT product_key) AS purchased_count
    FROM Customer
    GROUP BY customer_id
)
SELECT customer_id 
FROM customer_purchase, product_count
WHERE customer_purchase.purchased_count = product_count.total_products;
```
#### **Explanation:**
1. **CTE `product_count`** → Stores total number of products in `Product` table.
2. **CTE `customer_purchase`** → Groups purchases per customer and counts distinct products.
3. **Final SELECT query** → Compares each customer's purchase count with `total_products` and returns only those who match.

---

## **Pandas Solution (Python)**
```python
import pandas as pd

# Sample data
customer_data = {'customer_id': [1, 2, 3, 3, 1],
                 'product_key': [5, 6, 5, 6, 6]}
product_data = {'product_key': [5, 6]}

# Create DataFrames
customer_df = pd.DataFrame(customer_data)
product_df = pd.DataFrame(product_data)

# Get the total number of products
total_products = product_df['product_key'].nunique()

# Count distinct products per customer
customer_purchase = customer_df.groupby('customer_id')['product_key'].nunique()

# Filter customers who bought all products
result = customer_purchase[customer_purchase == total_products].reset_index()

print(result)
```

### **Explanation:**
1. **Create DataFrames** → Convert customer and product tables into Pandas DataFrames.
2. **Get total unique products** → `product_df['product_key'].nunique()`
3. **Count distinct products per customer** → `.groupby('customer_id')['product_key'].nunique()`
4. **Filter customers who match total products** → Customers with `purchased_count == total_products`
5. **Return final result**.

---

## **File Structure**
```
LeetCode1045/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solutions (Standard + Window Functions).
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 1045](https://leetcode.com/problems/customers-who-bought-all-products/)
- [SQL GROUP BY Documentation](https://www.w3schools.com/sql/sql_groupby.asp)
- [SQL HAVING Clause](https://www.w3schools.com/sql/sql_having.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)

---ture & Useful Links**  

🚀 **Now it's a complete guide!** 🚀
