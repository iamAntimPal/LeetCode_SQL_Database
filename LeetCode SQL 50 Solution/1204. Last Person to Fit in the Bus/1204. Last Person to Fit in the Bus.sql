1204. Last Person to Fit in the Bus

Table: Queue

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.
 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

Note that only one person can board the bus at any given turn.

The result format is in the following example.

 

Example 1:

Input: 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
Output: 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
Explanation: The folowing table is ordered by the turn for simplicity.
+------+----+-----------+--------+--------------+
| Turn | ID | Name      | Weight | Total Weight |
+------+----+-----------+--------+--------------+
| 1    | 5  | Alice     | 250    | 250          |
| 2    | 3  | Alex      | 350    | 600          |
| 3    | 6  | John Cena | 400    | 1000         | (last person to board)
| 4    | 2  | Marie     | 200    | 1200         | (cannot board)
| 5    | 4  | Bob       | 175    | ___          |
| 6    | 1  | Winston   | 500    | ___          |
+------+----+-----------+--------+--------------+



# Write your MySQL query statement below
SELECT a.person_name
FROM
    Queue AS a,
    Queue AS b
WHERE a.turn >= b.turn
GROUP BY a.person_id
HAVING SUM(b.weight) <= 1000
ORDER BY a.turn DESC
LIMIT 1;


Let's break down the query step by step to understand what it does:

---

### 1. Self-Join of the Table

```sql
FROM
    Queue AS a,
    Queue AS b
WHERE a.turn >= b.turn
```

- **Self-Join:**  
  The query treats the `Queue` table as two separate aliases: `a` and `b`. This is a self-join, meaning each row in `a` is paired with rows in `b`.

- **Join Condition (`a.turn >= b.turn`):**  
  For each row in alias `a`, the query pairs it with every row in alias `b` that has a `turn` value less than or equal to `a.turn`.  
  - **Purpose:** This setup is used to accumulate data from the start of the queue up to the current person's turn.

---

### 2. Grouping by Person

```sql
GROUP BY a.person_id
```

- **Grouping:**  
  The query groups the resulting joined rows by `a.person_id`.  
  - **Effect:** For each person in the queue (represented by alias `a`), all rows (from `b`) where `b.turn` is less than or equal to `a.turn` are aggregated together.

---

### 3. Calculating the Cumulative Weight

```sql
HAVING SUM(b.weight) <= 1000
```

- **Cumulative Sum:**  
  Within each group, the query calculates the sum of `b.weight`.  
  - **Condition:** The `HAVING` clause filters out groups where the cumulative weight (i.e., the sum of weights from the start of the queue up to the current person's turn) exceeds 1000.
  - **Interpretation:** Only those persons for whom the cumulative weight of all people before and including them is **less than or equal to 1000** are kept.

---

### 4. Selecting the Result

```sql
SELECT a.person_name
```

- **Result Column:**  
  After filtering, the query selects the `person_name` from alias `a` for each group that passed the `HAVING` condition.

---

### 5. Ordering and Limiting the Result

```sql
ORDER BY a.turn DESC
LIMIT 1;
```

- **Ordering:**  
  The results are ordered by `a.turn` in descending order.  
  - **Purpose:** This ensures that among all persons whose cumulative weight is ≤ 1000, the one with the **latest (highest) turn** is at the top.
  
- **Limiting:**  
  The `LIMIT 1` clause restricts the output to only the top result, effectively returning **one person**.

---
