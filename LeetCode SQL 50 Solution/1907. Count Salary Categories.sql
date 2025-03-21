907. Count Salary Categories
Solved
Medium
Topics
Companies
SQL Schema
Pandas Schema
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.


# Write your MySQL query statement below
WITH
    S AS (
        SELECT 'Low Salary' AS category
        UNION
        SELECT 'Average Salary'
        UNION
        SELECT 'High Salary'
    ),
    T AS (
        SELECT
            CASE
                WHEN income < 20000 THEN "Low Salary"
                WHEN income > 50000 THEN 'High Salary'
                ELSE 'Average Salary'
            END AS category,
            COUNT(1) AS accounts_count
        FROM Accounts
        GROUP BY 1
    )
SELECT category, IFNULL(accounts_count, 0) AS accounts_count
FROM
    S
    LEFT JOIN T USING (category);



### 1. Common Table Expression (CTE) "S"


WITH
    S AS (
        SELECT 'Low Salary' AS category
        UNION
        SELECT 'Average Salary'
        UNION
        SELECT 'High Salary'
    ),


- **Purpose:**  
  This CTE defines a static list of salary categories.  
- **How it works:**  
  - The `SELECT` statements with `UNION` combine three rows, each containing one of the categories: `'Low Salary'`, `'Average Salary'`, and `'High Salary'`.
- **Result:**  
  The result of `S` is a temporary table with one column (`category`) and three rows.

---

### 2. Common Table Expression (CTE) "T"

```sql
    T AS (
        SELECT
            CASE
                WHEN income < 20000 THEN "Low Salary"
                WHEN income > 50000 THEN 'High Salary'
                ELSE 'Average Salary'
            END AS category,
            COUNT(1) AS accounts_count
        FROM Accounts
        GROUP BY 1
    )
```

- **Purpose:**  
  This CTE categorizes each account from the `Accounts` table based on the `income` value, then counts the number of accounts in each category.
- **How it works:**  
  - **CASE Statement:**  
    - If `income` is less than 20000, it labels the row as `"Low Salary"`.
    - If `income` is greater than 50000, it labels the row as `"High Salary"`.
    - Otherwise, it labels the row as `"Average Salary"`.
  - **COUNT(1):**  
    - It counts the number of rows (accounts) in each category.
  - **GROUP BY 1:**  
    - It groups the results by the first column in the SELECT list, which is the computed `category`.
- **Result:**  
  The result of `T` is a temporary table that contains two columns: `category` and `accounts_count`. It holds the count of accounts for each salary category that exists in the `Accounts` table.

---

### 3. Final SELECT with LEFT JOIN

```sql
SELECT category, IFNULL(accounts_count, 0) AS accounts_count
FROM
    S
    LEFT JOIN T USING (category);
```

- **Purpose:**  
  This part combines the two CTEs (`S` and `T`) to ensure that every salary category from `S` is included in the final result, even if there are no corresponding accounts in `T`.
- **How it works:**
  - **LEFT JOIN:**  
    - It joins `S` (all predefined categories) with `T` (the computed counts) on the `category` column.
    - If a category from `S` does not exist in `T` (i.e., there were no accounts that fell into that category), the join will produce a `NULL` value for `accounts_count`.
  - **IFNULL(accounts_count, 0):**  
    - This function replaces any `NULL` in `accounts_count` with `0`, ensuring that the final output shows 0 for categories with no accounts.
- **Result:**  
  The final output is a list of salary categories along with the corresponding count of accounts. If a category has no accounts, it will show as 0.

---

### Summary

- **CTE "S":** Defines a static list of salary categories.
- **CTE "T":** Categorizes and counts accounts from the `Accounts` table based on income.
- **LEFT JOIN:** Combines both CTEs so every predefined category appears in the final result, with missing counts defaulting to 0.
- **Final Output:**  
  A table with two columns:
  - `category`: The salary category (Low Salary, Average Salary, High Salary).
  - `accounts_count`: The number of accounts in that category (or 0 if there are none).
