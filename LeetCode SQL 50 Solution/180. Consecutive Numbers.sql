180. Consecutive Numbers
"""
# Write your MySQL query statement below
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Logs table:
+----+-----+
| id | num |
+----+-----+
| 1  | 1   |
| 2  | 1   |
| 3  | 1   |
| 4  | 2   |
| 5  | 1   |
| 6  | 2   |
| 7  | 2   |
+----+-----+
Output: 
+-----------------+
| ConsecutiveNums |
+-----------------+
| 1               |
+-----------------+

"""
Explanation: 1 is the only number that appears consecutively for at least three times.

# Write your MySQL query statement below
with consecutive_runs as (
    select id, num, lead(num, 1) over (order by id) as lead_num, lag(num, 1) over (order by id) as lag_num
    from Logs
)
select distinct num as ConsecutiveNums
from consecutive_runs 
where num = lead_num and num = lag_num

"""
Explanation
 Common Table Expression (CTE): consecutive_runs
sql
Copy
Edit
with consecutive_runs as (
    select 
        id, 
        num, 
        lead(num, 1) over (order by id) as lead_num, 
        lag(num, 1) over (order by id) as lag_num
    from Logs
)
Purpose of the CTE:
This part creates a temporary result set named consecutive_runs that enriches each row from the Logs table with two extra columns:

lead_num: The value of the num column in the next row (based on the id order).
lag_num: The value of the num column in the previous row (based on the id order).
Window Functions:

lead(num, 1) over (order by id):
This function returns the value of num from the row immediately following the current one when sorted by id.
lag(num, 1) over (order by id):
This function returns the value of num from the row immediately preceding the current one when sorted by id.
This setup allows us to compare each row with its immediate neighbors.

2. Final SELECT Query
sql
Copy
Edit
select distinct num as ConsecutiveNums
from consecutive_runs 
where num = lead_num and num = lag_num
Filtering Condition:
The WHERE clause checks if the current row's num value is equal to both its next (lead_num) and previous (lag_num) values:

num = lead_num
num = lag_num
This ensures that the number appears consecutively (at least three times in a row).

DISTINCT Keyword:
The distinct keyword makes sure that each number is listed only once in the final output, even if it occurs in multiple consecutive sequences.

Result Column Alias:
The output column is renamed to ConsecutiveNums for clarity.

Summary
CTE Usage:
The query first computes additional columns using window functions (lead and lag) to look at neighboring rows.

Consecutive Check:
It then filters out rows where the current value is the same as both the previous and next value, meaning there are at least three consecutive occurrences of that number.

Final Output:
The final result is a list of distinct numbers that appear consecutively in the Logs table.
"""


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
