1978. Employees Whose Manager Left the Company
Solved
Easy
Topics
Companies
SQL Schema
Pandas Schema
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| manager_id  | int      |
| salary      | int      |
+-------------+----------+
In SQL, employee_id is the primary key for this table.
This table contains information about the employees, their salary, and the ID of their manager. Some employees do not have a manager (manager_id is null). 
 

Find the IDs of the employees whose salary is strictly less than $30000 and whose manager left the company. When a manager leaves the company, their information is deleted from the Employees table, but the reports still have their manager_id set to the manager that left.

Return the result table ordered by employee_id.

The result format is in the following example.

 

Example 1:

Input:  
Employees table:
+-------------+-----------+------------+--------+
| employee_id | name      | manager_id | salary |
+-------------+-----------+------------+--------+
| 3           | Mila      | 9          | 60301  |
| 12          | Antonella | null       | 31000  |
| 13          | Emery     | null       | 67084  |
| 1           | Kalel     | 11         | 21241  |
| 9           | Mikaela   | null       | 50937  |
| 11          | Joziah    | 6          | 28485  |
+-------------+-----------+------------+--------+
Output: 
+-------------+
| employee_id |
+-------------+
| 11          |
+-------------+

Explanation: 
The employees with a salary less than $30000 are 1 (Kalel) and 11 (Joziah).
Kalel's manager is employee 11, who is still in the company (Joziah).
Joziah's manager is employee 6, who left the company because there is no row for employee 6 as it was deleted.



# Write your MySQL query statement below
SELECT e1.employee_id
FROM
    Employees AS e1
    LEFT JOIN Employees AS e2 ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000 AND e1.manager_id IS NOT NULL AND e2.employee_id IS NULL
ORDER BY 1;





Sure! Let's break down the given MySQL query step by step, explain each part, and analyze its purpose.

---

## **Understanding the Problem Statement**
We want to find **employees** whose:
1. **Salary is less than 30,000.**
2. **Have a manager (i.e., `manager_id IS NOT NULL`).**
3. **Their manager does not exist in the `Employees` table.** (i.e., the `manager_id` they refer to does not match any existing `employee_id`).

---

## **Database Schema**
Assume we have a table called `Employees` with the following structure:

| employee_id | name    | salary | manager_id |
|------------|--------|--------|------------|
| 1          | Alice  | 50000  | NULL       |
| 2          | Bob    | 20000  | 1          |
| 3          | Charlie| 25000  | 4          |
| 4          | David  | 60000  | NULL       |
| 5          | Emma   | 27000  | 10         |

- **`employee_id`**: Unique ID for each employee.
- **`name`**: Employee’s name.
- **`salary`**: Salary of the employee.
- **`manager_id`**: The `employee_id` of their manager. `NULL` means the employee has no manager.

---

## **Step-by-Step Explanation of the Query**
```sql
SELECT e1.employee_id
```
- We are selecting the `employee_id` of employees who satisfy the given conditions.

```sql
FROM Employees AS e1
```
- We define the alias `e1` for the `Employees` table to refer to employees.

```sql
LEFT JOIN Employees AS e2 ON e1.manager_id = e2.employee_id
```
- We perform a **LEFT JOIN** to check if the `manager_id` of `e1` exists in the `employee_id` column of another instance of `Employees` (aliased as `e2`).
- If there is **no match**, it means the manager does not exist in the table.

```sql
WHERE e1.salary < 30000
```
- We **filter employees** whose salary is **less than 30,000**.

```sql
AND e1.manager_id IS NOT NULL
```
- Ensures that the employee **has a manager** (`manager_id` should not be `NULL`).

```sql
AND e2.employee_id IS NULL
```
- This is the key condition!
- Since we did a **LEFT JOIN**, `e2.employee_id` will be `NULL` if the manager **does not exist** in the `Employees` table.

```sql
ORDER BY 1;
```
- Orders the result by `employee_id` in ascending order.

---

## **Example Execution**
Using the above `Employees` table, let's analyze the output:

| employee_id | name   | salary | manager_id |
|------------|--------|--------|------------|
| 1          | Alice  | 50000  | NULL       |
| 2          | Bob    | 20000  | 1          |
| 3          | Charlie| 25000  | 4          |
| 4          | David  | 60000  | NULL       |
| 5          | Emma   | 27000  | 10         |

### **Step 1: LEFT JOIN**
We join the table on `manager_id = employee_id`:

| e1.employee_id | e1.salary | e1.manager_id | e2.employee_id |
|---------------|----------|--------------|---------------|
| 2             | 20000    | 1            | 1             |
| 3             | 25000    | 4            | 4             |
| 5             | 27000    | 10           | NULL          |

### **Step 2: Apply WHERE Conditions**
- `e1.salary < 30000`: Only `Bob`, `Charlie`, and `Emma` qualify.
- `e1.manager_id IS NOT NULL`: No issue.
- `e2.employee_id IS NULL`: Only **Emma (employee_id = 5) qualifies** because `manager_id = 10`, and there is no `employee_id = 10`.

### **Final Output**
| employee_id |
|------------|
| 5          |

So, the result is:
```
5
```
---
## **Summary**
### **Key Takeaways:**
✔ We use **LEFT JOIN** to check if the manager exists.  
✔ We filter employees whose **salary is below 30,000**.  
✔ We ensure the manager **does not exist** in the database (`e2.employee_id IS NULL`).  
✔ The query returns a **list of employees** who meet these conditions.  

Would you like me to explain anything further or modify the query for additional scenarios? 😊