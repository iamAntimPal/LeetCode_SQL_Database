# 🏆 LeetCode 176: Second Highest Salary (Pandas) 🚀  

## **Problem Statement**  
You are given an **Employee** table with the following schema:  

```
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
```
- `id` is the **primary key** (unique for each employee).  
- Each row contains information about an employee's salary.  

Your task is to **find the second highest distinct salary**.  
- If there is no second highest salary, return `None`.  

---

## **Example 1**  

### **Input:**  
```plaintext
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
```
### **Output:**  
```plaintext
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
```

---

## **Example 2**  

### **Input:**  
```plaintext
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
```
### **Output:**  
```plaintext
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+
```

---

## **Approach**  

1. **Remove duplicate salaries** using `.drop_duplicates()`.  
2. **Sort salaries** in descending order.  
3. **Retrieve the second highest salary**, if it exists.  
4. If there is no second highest salary, return `None`.  

---

## **Code (Pandas Solution)**  

```python
import pandas as pd

def second_highest_salary(employee: pd.DataFrame) -> pd.DataFrame:
    # Get distinct salaries, sorted in descending order
    unique_salaries = employee['salary'].drop_duplicates().sort_values(ascending=False)
    
    # Check if there is a second highest salary
    second_highest = unique_salaries.iloc[1] if len(unique_salaries) > 1 else None
    
    # Return as a DataFrame with column name 'SecondHighestSalary'
    return pd.DataFrame({'SecondHighestSalary': [second_highest]})
```

---

## **Complexity Analysis**  
- **Time Complexity:** $$O(n \log n)$$ due to sorting.  
- **Space Complexity:** $$O(n)$$ for storing unique salaries.  

---

## **Why This Works?**  
✅ Uses Pandas' `drop_duplicates()` for distinct values.  
✅ Sorts efficiently using `sort_values()`.  
✅ Handles cases where no second highest salary exists.  

---

## **SQL Equivalent Solution**  
If solving in SQL, we can use **`DENSE_RANK()`**:  
```sql
WITH RankedEmployees AS (
    SELECT salary, DENSE_RANK() OVER(ORDER BY salary DESC) AS `rank`
    FROM Employee
)
SELECT MAX(salary) AS SecondHighestSalary
FROM RankedEmployees
WHERE `rank` = 2;
```

---

### **Happy Coding! 🚀💡**  
Hope this helps! Feel free to ⭐ **star** this repo if you found it useful. 😊