

# **1174. Immediate Food Delivery II**

## **Problem Statement**
You are given a table `Delivery` that records food deliveries made to customers. Each row represents an order with the date it was placed and the customer’s preferred delivery date.

---

## **Delivery Table**
```
+-------------+-------------+------------+-----------------------------+
| Column Name | Type        | Description                                  |
+-------------+-------------+----------------------------------------------+
| delivery_id | int         | Unique identifier for the delivery           |
| customer_id | int         | Identifier for the customer                  |
| order_date  | date        | Date when the order was placed               |
| customer_pref_delivery_date | date | Customer’s preferred delivery date  |
+-------------+-------------+----------------------------------------------+
```
- `delivery_id` is the **primary key**.
- Each customer specifies a preferred delivery date, which can be the same as or after the order date.

---

## **Task:**
Calculate the **percentage** of customers whose **first order** is **immediate** (i.e., the order date is the same as the customer’s preferred delivery date).  
- A customer’s **first order** is defined as the order with the **earliest order_date** for that customer.
- The result should be **rounded to 2 decimal places**.
- Return the percentage as `immediate_percentage`.

---

## **Example 1:**

### **Input:**
**Delivery Table**
```
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
```

### **Output:**
```
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
```

### **Explanation:**
- **Customer 1:** First order is on **2019-08-01** (preferred: 2019-08-02) → **Scheduled**
- **Customer 2:** First order is on **2019-08-02** (preferred: 2019-08-02) → **Immediate**
- **Customer 3:** First order is on **2019-08-21** (preferred: 2019-08-22) → **Scheduled**
- **Customer 4:** First order is on **2019-08-09** (preferred: 2019-08-09) → **Immediate**
  
Out of 4 customers, 2 have immediate first orders.  
Percentage = (2 / 4) * 100 = **50.00**

---

## **SQL Solutions**

### **1️⃣ Standard MySQL Solution**
```sql
SELECT 
    ROUND(100 * SUM(CASE 
        WHEN first_orders.order_date = first_orders.customer_pref_delivery_date THEN 1 
        ELSE 0 
    END) / COUNT(*), 2) AS immediate_percentage
FROM (
    -- Get the first order (earliest order_date) for each customer
    SELECT customer_id, order_date, customer_pref_delivery_date 
    FROM Delivery 
    WHERE (customer_id, order_date) IN (
        SELECT customer_id, MIN(order_date) 
        FROM Delivery 
        GROUP BY customer_id
    )
) AS first_orders;
```

#### **Explanation:**
- **Subquery:** Retrieves the first order for each customer by selecting the minimum `order_date`.
- **Outer Query:**  
  - Uses a `CASE` statement to check if the `order_date` equals `customer_pref_delivery_date` (i.e., immediate order).
  - Calculates the percentage of immediate first orders.
  - Rounds the result to 2 decimal places.

---

### **2️⃣ Window Function (SQL) Solution**
```sql
WITH RankedOrders AS (
    SELECT 
        customer_id, 
        order_date, 
        customer_pref_delivery_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date) AS rn
    FROM Delivery
)
SELECT 
    ROUND(100 * SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1 ELSE 0 END) / COUNT(*), 2) AS immediate_percentage
FROM RankedOrders
WHERE rn = 1;
```

#### **Explanation:**
- **CTE `RankedOrders`:**  
  - Uses `ROW_NUMBER()` to rank orders for each customer by `order_date`.
  - Filters for the first order of each customer (`rn = 1`).
- **Final SELECT:**  
  - Computes the percentage of first orders that are immediate.
  - Rounds the result to 2 decimal places.

---

## **Pandas Solution (Python)**
```python
import pandas as pd

def immediate_food_delivery_percentage(delivery: pd.DataFrame) -> pd.DataFrame:
    # Ensure order_date and customer_pref_delivery_date are in datetime format
    delivery['order_date'] = pd.to_datetime(delivery['order_date'])
    delivery['customer_pref_delivery_date'] = pd.to_datetime(delivery['customer_pref_delivery_date'])
    
    # Get the first order date for each customer
    first_order = delivery.groupby('customer_id')['order_date'].min().reset_index()
    first_order = first_order.rename(columns={'order_date': 'first_order_date'})
    
    # Merge to get the corresponding preferred delivery date for the first order
    merged = pd.merge(delivery, first_order, on='customer_id', how='inner')
    first_orders = merged[merged['order_date'] == merged['first_order_date']]
    
    # Calculate immediate orders
    immediate_count = (first_orders['order_date'] == first_orders['customer_pref_delivery_date']).sum()
    total_customers = first_orders['customer_id'].nunique()
    immediate_percentage = round(100 * immediate_count / total_customers, 2)
    
    return pd.DataFrame({'immediate_percentage': [immediate_percentage]})

# Example usage:
# df = pd.read_csv('delivery.csv')
# print(immediate_food_delivery_percentage(df))
```

#### **Explanation:**
- **Convert Dates:**  
  - Convert `order_date` and `customer_pref_delivery_date` to datetime for accurate comparison.
- **Determine First Order:**  
  - Group by `customer_id` to find the minimum `order_date` as the first order.
  - Merge with the original DataFrame to obtain details of the first order.
- **Calculate Percentage:**  
  - Count how many first orders are immediate (where `order_date` equals `customer_pref_delivery_date`).
  - Compute the percentage and round to 2 decimal places.
  
---

## **File Structure**
```
LeetCode1174/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_standard_solution.sql  # Contains the Standard MySQL solution.
├── sql_window_solution.sql    # Contains the Window Function solution.
├── pandas_solution.py         # Contains the Pandas solution.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 1174](https://leetcode.com/problems/immediate-food-delivery-ii/)
- [SQL GROUP BY Documentation](https://www.w3schools.com/sql/sql_groupby.asp)
- [SQL Window Functions](https://www.w3schools.com/sql/sql_window.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
- [Pandas Merge Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.merge.html)
