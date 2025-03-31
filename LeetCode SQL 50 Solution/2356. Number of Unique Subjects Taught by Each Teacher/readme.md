# 📚 Number of Unique Subjects Taught by Each Teacher - LeetCode 2356

## 📌 Problem Statement
You are given a table **Teacher** that provides information about the subjects taught by teachers in various departments of a university.

Your task is to calculate the **number of unique subjects** each teacher teaches.  
Note that the table can have multiple rows for the same subject taught in different departments, but you should count each subject only once per teacher.

Return the result table in **any order**.

---

## 📊 Table Structure

### **Teacher Table**
| Column Name | Type |
| ----------- | ---- |
| teacher_id  | int  |
| subject_id  | int  |
| dept_id     | int  |

- `(subject_id, dept_id)` is the **primary key**.
- Each row indicates that the teacher with `teacher_id` teaches the subject `subject_id` in the department `dept_id`.

---

## 📊 Example 1:

### **Input:**
#### **Teacher Table**
| teacher_id | subject_id | dept_id |
| ---------- | ---------- | ------- |
| 1          | 2          | 3       |
| 1          | 2          | 4       |
| 1          | 3          | 3       |
| 2          | 1          | 1       |
| 2          | 2          | 1       |
| 2          | 3          | 1       |
| 2          | 4          | 1       |

### **Output:**
| teacher_id | cnt |
| ---------- | --- |
| 1          | 2   |
| 2          | 4   |

### **Explanation:**
- **Teacher 1:**  
  - Teaches subject **2** (in departments 3 and 4) and subject **3** (in department 3).  
  - Unique subjects = {2, 3} → **2 subjects**.
- **Teacher 2:**  
  - Teaches subjects **1**, **2**, **3**, and **4** (all in department 1).  
  - Unique subjects = {1, 2, 3, 4} → **4 subjects**.

---

## 🖥 SQL Solution

### ✅ **Approach:**
- Use `COUNT(DISTINCT subject_id)` to count the number of unique subjects taught by each teacher.
- Group the results by `teacher_id`.

```sql
SELECT teacher_id, COUNT(DISTINCT subject_id) AS cnt
FROM Teacher
GROUP BY teacher_id;
```

---

## 🐍 Python (Pandas) Solution

### ✅ **Approach:**
1. **Group by `teacher_id`:**  
   - Group the DataFrame by `teacher_id`.
2. **Count Unique Subjects:**  
   - Use the `nunique()` function on the `subject_id` column within each group to count unique subjects.
3. **Reset Index and Rename:**  
   - Reset the index and rename the column appropriately.

```python
import pandas as pd

def count_unique_subjects(teacher: pd.DataFrame) -> pd.DataFrame:
    # Group by teacher_id and count unique subject_id values
    result = teacher.groupby('teacher_id')['subject_id'].nunique().reset_index()
    result = result.rename(columns={'subject_id': 'cnt'})
    return result

# Example usage:
# teacher_df = pd.DataFrame({
#     'teacher_id': [1, 1, 1, 2, 2, 2, 2],
#     'subject_id': [2, 2, 3, 1, 2, 3, 4],
#     'dept_id': [3, 4, 3, 1, 1, 1, 1]
# })
# print(count_unique_subjects(teacher_df))
```

---

## 📁 File Structure
```
📂 Unique-Subjects-Per-Teacher
│── README.md
│── solution.sql
│── solution_pandas.py
│── test_cases.sql
│── sample_data.csv
```

---

## 🔗 Useful Links
- 📖 [LeetCode Problem](https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/)
- 🔍 [MySQL COUNT(DISTINCT) Documentation](https://www.w3schools.com/sql/sql_count_distinct.asp)
- 🐍 [Pandas GroupBy Documentation](https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.groupby.html)
