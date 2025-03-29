# **596. Classes More Than 5 Students**

## **Problem Statement**
You are given a table `Courses` that contains the names of students and the class in which they are enrolled.

### **Courses Table**
```
+---------+---------+
| Column  | Type    |
+---------+---------+
| student | varchar |
| class   | varchar |
+---------+---------+
```
- The combination of `(student, class)` is the **primary key**.
- Each row indicates the name of a student and the class they are enrolled in.

### **Task:**
Write a solution to find all the classes that have **at least five students**.

Return the result table in **any order**.

---

## **Example 1:**

### **Input:**
```
Courses table:
+---------+----------+
| student | class    |
+---------+----------+
| A       | Math     |
| B       | English  |
| C       | Math     |
| D       | Biology  |
| E       | Math     |
| F       | Computer |
| G       | Math     |
| H       | Math     |
| I       | Math     |
+---------+----------+
```

### **Output:**
```
+---------+
| class   |
+---------+
| Math    |
+---------+
```

### **Explanation:**
- **Math** has 6 students, so it is included.
- **English**, **Biology**, and **Computer** have fewer than 5 students, so they are excluded.

---

## **Solution Approaches**

### **SQL Solution**
```sql
SELECT class
FROM Courses
GROUP BY class
HAVING COUNT(student) >= 5;
```
**Explanation:**
- The query groups records by `class`.
- The `HAVING` clause filters out groups with fewer than 5 students.

---

### **Pandas Solution**
```python
import pandas as pd

def classes_with_five_or_more_students(courses: pd.DataFrame) -> pd.DataFrame:
    # Group by 'class' and count the number of students
    result = courses.groupby('class').filter(lambda x: len(x) >= 5)
    # Return only the distinct class names
    return result[['class']].drop_duplicates().reset_index(drop=True)

# Example usage:
# courses_df = pd.read_csv('courses.csv')
# print(classes_with_five_or_more_students(courses_df))
```
**Explanation:**
- The Pandas solution groups the DataFrame by `class` and filters groups with 5 or more students.
- It then extracts and returns the distinct class names.

---

## **File Structure**
```
LeetCode596/
├── problem_statement.md       # Contains the problem description and constraints.
├── sql_solution.sql           # Contains the SQL solution.
├── pandas_solution.py         # Contains the Pandas solution for Python users.
├── README.md                  # Overview of the problem and available solutions.
```

---

## **Useful Links**
- [LeetCode Problem 596](https://leetcode.com/problems/classes-more-than-5-students/)
- [SQL GROUP BY and HAVING Clause](https://www.w3schools.com/sql/sql_groupby.asp)
- [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)

