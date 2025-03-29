# **595. Big Countries**

## **Problem Statement**
You are given a table `World` that contains information about countries.

### **World Table**
```
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| name        | varchar |
| continent   | varchar |
| area        | int     |
| population  | int     |
| gdp         | bigint  |
+-------------+---------+
```
- `name` is the **primary key**.
- Each row contains:
  - `name`: Name of the country.
  - `continent`: Continent the country belongs to.
  - `area`: Area of the country (in km²).
  - `population`: Population of the country.
  - `gdp`: GDP of the country.

### **Task:**
A country is considered **big** if:
- It has an **area** of at least **3,000,000 km²**, **or**
- It has a **population** of at least **25,000,000**.

Write a solution to find the **name**, **population**, and **area** of the big countries.

Return the result table in **any order**.

---

## **Example 1:**

### **Input:**
#### **World Table**
```
+-------------+-----------+---------+------------+--------------+
| name        | continent | area    | population | gdp          |
+-------------+-----------+---------+------------+--------------+
| Afghanistan | Asia      | 652230  | 25500100   | 20343000000  |
| Albania     | Europe    | 28748   | 2831741    | 12960000000  |
| Algeria     | Africa    | 2381741 | 37100000   | 188681000000 |
| Andorra     | Europe    | 468     | 78115      | 3712000000   |
| Angola      | Africa    | 1246700 | 20609294   | 100990000000 |
+-------------+-----------+---------+------------+--------------+
```

### **Output:**
```
+-------------+------------+---------+
| name        | population | area    |
+-------------+------------+---------+
| Afghanistan | 25500100   | 652230  |
| Algeria     | 37100000   | 2381741 |
+-------------+------------+---------+
```

### **Explanation:**
- **Afghanistan** is not big by area (652,230 < 3,000,000) but is big by population (25,500,100 ≥ 25,000,000).
- **Algeria** is big by population (37,100,000 ≥ 25,000,000), even though its area (2,381,741) is less than 3,000,000.
- The other countries do not meet either condition.

---

## **Solution Approaches**

### **SQL Solution (Using UNION)**
```sql
SELECT name, population, area 
FROM World 
WHERE area >= 3000000
UNION
SELECT name, population, area 
FROM World 
WHERE population >= 25000000;
```
**Explanation:**
- The first `SELECT` returns countries with an area of at least 3,000,000 km².
- The second `SELECT` returns countries with a population of at least 25,000,000.
- `UNION` combines these two result sets, ensuring unique rows.

---

### **SQL Alternative (Using OR)**
```sql
SELECT name, population, area
FROM World
WHERE area >= 3000000 OR population >= 25000000;
```
**Explanation:**
- This query uses a single `SELECT` statement with an `OR` condition to capture countries that meet either criterion.

---

### **Pandas Solution**
```python
import pandas as pd

def big_countries(world: pd.DataFrame) -> pd.DataFrame:
    # Filter countries that are considered big by either area or population
    result = world[(world['area'] >= 3000000) | (world['population'] >= 25000000)][['name', 'population', 'area']]
    return result

# Example usage:
# world_df = pd.read_csv('world.csv')
# print(big_countries(world_df))
```
**Explanation:**
- The Pandas solution filters the DataFrame based on the condition that `area` is at least 3,000,000 or `population` is at least 25,000,000.
- It then returns the columns `name`, `population`, and `area`.

---

## **File Structure**
```
LeetCode595/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_union_solution.sql     # SQL solution using UNION.
├── sql_or_solution.sql        # SQL alternative solution using OR.
├── pandas_solution.py         # Pandas solution for Python users.
├── README.md                  # Overview of the problem and solutions.
```

---

## **Useful Links**
- [LeetCode Problem 595](https://leetcode.com/problems/big-countries/)
- [SQL WHERE Clause](https://www.w3schools.com/sql/sql_where.asp)
- [Pandas Documentation](https://pandas.pydata.org/docs/)

