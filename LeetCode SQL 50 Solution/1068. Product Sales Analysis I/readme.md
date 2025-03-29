

# **1068. Product Sales Analysis I**

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
Find the `product_name`, `year`, and `price` for each sale in the `Sales` table.

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
+--------------+-------+-------+
| product_name | year  | price |
+--------------+-------+-------+
| Nokia        | 2008  | 5000  |
| Nokia        | 2009  | 5000  |
| Apple        | 2011  | 9000  |
+--------------+-------+-------+
```

### **Explanation:**
- **Sale ID 1:** `Nokia` was sold in **2008** for **5000**.
- **Sale ID 2:** `Nokia` was sold in **2009** for **5000**.
- **Sale ID 7:** `Apple` was sold in **2011** for **9000**.

---

## **SQL Solutions**

### **1️⃣ Standard MySQL Solution**
```sql
SELECT p.product_name, s.year, s.price
FROM Sales s
JOIN Product p ON s.product_id = p.product_id;
```
#### **Explanation:**
1. **JOIN** the `Sales` table with the `Product` table using `product_id`.
2. **Select `product_name`, `year`, and `price`** from the joined result.

---

### **2️⃣ Window Function (SQL) Solution**
```sql
WITH SalesData AS (
    SELECT s.product_id, s.year, s.price, p.product_name
    FROM Sales s
    JOIN Product p ON s.product_id = p.product_id
)
SELECT product_name, year, price 
FROM SalesData;
```
#### **Explanation:**
1. **CTE `SalesData`** → Stores the joined data from `Sales` and `Product`.
2. **Final SELECT** → Retrieves `product_name`, `year`, and `price`.

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

product_data = {'product_id': [100, 200, 300], 
                'product_name': ['Nokia', 'Apple', 'Samsung']}

# Create DataFrames
sales_df = pd.DataFrame(sales_data)
product_df = pd.DataFrame(product_data)

# Perform Join
result = sales_df.merge(product_df, on='product_id')[['product_name', 'year', 'price']]

print(result)
```

### **Explanation:**
1. **Create DataFrames** → Convert `Sales` and `Product` tables into Pandas DataFrames.
2. **Perform `merge()` on `product_id`** → Equivalent to SQL `JOIN`.
3. **Select required columns (`product_name`, `year`, `price`)**.

---

## **File Structure**
```
LeetCode1068/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solutions (Standard + Window Functions).
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 1068](https://leetcode.com/problems/product-sales-analysis-i/)
- [SQL JOIN Documentation](https://www.w3schools.com/sql/sql_join.asp)
- [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)



## 🚀 **Now it's a complete guide!** 🚀